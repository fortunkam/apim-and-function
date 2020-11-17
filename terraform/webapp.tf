resource "azurerm_app_service_plan" "api_appplan" {
  name                = local.api_plan_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "rest_website" {
  name                = local.rest_web_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.api_appplan.id

  identity {
      type          = "SystemAssigned"   
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"         = azurerm_application_insights.insights.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING"  = azurerm_application_insights.insights.connection_string
  }

  tags = {
    "hidden-related:${data.azurerm_resource_group.rg.id}/providers/Microsoft.Web/serverfarms/${local.api_plan_name}" = "Resource"
    "displayName" = "inspolicyrestapi"
  }
}

resource "azurerm_app_service" "soap_website" {
  name                = local.soap_web_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.api_appplan.id

  identity {
      type          = "SystemAssigned"   
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"         = azurerm_application_insights.insights.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING"  = azurerm_application_insights.insights.connection_string
  }

  tags = {
    "hidden-related:${data.azurerm_resource_group.rg.id}/providers/Microsoft.Web/serverfarms/${local.api_plan_name}" = "Resource"
    "displayName" = "inspolicysoapapi"
  }
}