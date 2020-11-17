variable location {
    default="uksouth"
}

variable prefix {
    default="ins-domain"
}

resource "random_id" "storage_name" {
  keepers = {
    resource_group = data.azurerm_resource_group.rg.name
  }
  byte_length = 8
}