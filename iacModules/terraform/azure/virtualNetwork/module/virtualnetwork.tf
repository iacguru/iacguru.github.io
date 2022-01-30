data "azurerm_resource_group" "rg" {
  name = var.resource-group-name
}

resource "azurerm_virtual_network" "vnet" {
  name                    = var.vnet-name
  location                = data.azurerm_resource_group.rg.location
  resource_group_name     = data.azurerm_resource_group.rg.name
  address_space           = var.address-space
  tags                    = var.tags
  bgp_community           = var.bgp-community != "" ? var.bgp-community : null
  dns_servers             = var.dns-servers
  flow_timeout_in_minutes = var.flow-timeout-in-minutes

  dynamic "ddos_protection_plan" {
    for_each = var.ddos-protection-plan-id != "" ? [""] : []
    content {
      id     = var.ddos-protection-plan-id
      enable = var.ddos-protection-plan-enabled
    }
  }

  dynamic "subnet" {
    for_each = var.subnet-info
    content {
      name           = subnet.value.name
      address_prefix = subnet.value.address-prefix
      security_group = subnet.value.security-group
    }
  }
}