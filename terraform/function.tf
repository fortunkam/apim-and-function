resource "azurerm_storage_account" "function_storage" {
  name                     = "tfsta${lower(random_id.storage_name.hex)}"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "appplan" {
  name                = local.appplan_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  sku {
    tier = "ElasticPremium"
    size = "EP1"
  }
}

resource "azurerm_function_app" "function" {
  name                      = local.function_name
  location                  = data.azurerm_resource_group.rg.location
  resource_group_name       = data.azurerm_resource_group.rg.name
  app_service_plan_id       = azurerm_app_service_plan.appplan.id
  storage_connection_string = azurerm_storage_account.function_storage.primary_connection_string
  version = "~3"


  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"         = azurerm_application_insights.insights.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING"  = azurerm_application_insights.insights.connection_string
    "FUNCTIONS_WORKER_RUNTIME" = "dotnet"

  }
}