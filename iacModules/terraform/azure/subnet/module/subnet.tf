data "azurerm_resource_group" "rg" {
  name = var.resource-group-name
}

data "azurerm_virtual_network" "vnet" {
  name                = var.vnet-name
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "example" {
  name                        = var.subnet-name
  resource_group_name         = data.azurerm_resource_group.rg.name
  virtual_network_name        = data.azurerm_virtual_network.vnet.name
  address_prefixes            = var.address-prefixes
  service_endpoints           = var.service-endpoints
  service_endpoint_policy_ids = var.service-endpoint-policy-ids

  dynamic "delegation" {
    for_each = var.delegation
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service-name
        actions = delegation.value.actions
      }
    }
  }
}