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
    "APPINSIGHTS_PROFILERFEATURE_VERSION"="1.0.0"
    "APPINSIGHTS_SNAPSHOTFEATURE_VERSION"="1.0.0"
    "ApplicationInsightsAgent_EXTENSION_VERSION"="~2"
    "DiagnosticServices_EXTENSION_VERSION"="~3"
    "InstrumentationEngine_EXTENSION_VERSION"="disabled"
    "SnapshotDebugger_EXTENSION_VERSION"="disabled"
    "XDT_MicrosoftApplicationInsights_BaseExtensions"="disabled"
    "XDT_MicrosoftApplicationInsights_Mode"="recommended"
    "XDT_MicrosoftApplicationInsights_PreemptSdk"="disabled"
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
    "APPINSIGHTS_PROFILERFEATURE_VERSION"="1.0.0"
    "APPINSIGHTS_SNAPSHOTFEATURE_VERSION"="1.0.0"
    "ApplicationInsightsAgent_EXTENSION_VERSION"="~2"
    "DiagnosticServices_EXTENSION_VERSION"="~3"
    "InstrumentationEngine_EXTENSION_VERSION"="disabled"
    "SnapshotDebugger_EXTENSION_VERSION"="disabled"
    "XDT_MicrosoftApplicationInsights_BaseExtensions"="disabled"
    "XDT_MicrosoftApplicationInsights_Mode"="recommended"
    "XDT_MicrosoftApplicationInsights_PreemptSdk"="disabled"
  }

  tags = {
    "hidden-related:${data.azurerm_resource_group.rg.id}/providers/Microsoft.Web/serverfarms/${local.api_plan_name}" = "Resource"
    "displayName" = "inspolicysoapapi"
  }
}