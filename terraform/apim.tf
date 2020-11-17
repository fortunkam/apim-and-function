resource "azurerm_api_management" "apim" {
  name                = local.apim_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  publisher_name      = local.apim_publisher_name
  publisher_email     = local.apim_publisher_email

  sku_name = "Developer_1"

  identity {
      type = "SystemAssigned"
  }

}