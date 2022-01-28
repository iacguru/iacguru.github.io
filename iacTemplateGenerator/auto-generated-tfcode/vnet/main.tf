
#-------------------------------------------#
# terraform-azurerm-vnet module!
#-------------------------------------------#

module "terraform-azurerm-vnet" {
  source                                                = "Azure/vnet/azurerm"
  version                                               = "v1.2.0"
  depends_on                                            = []
  vnet_name                                             = var.vnet_name
  subnet_prefixes                                       = var.subnet_prefixes
  subnet_service_endpoints                              = var.subnet_service_endpoints
  subnet_enforce_private_link_endpoint_network_policies = var.subnet_enforce_private_link_endpoint_network_policies
  tags                                                  = var.tags
  resource_group_name                                   = var.resource_group_name
  subnet_names                                          = var.subnet_names
  subnet_enforce_private_link_service_network_policies  = var.subnet_enforce_private_link_service_network_policies
  subnet_delegation                                     = var.subnet_delegation
  nsg_ids                                               = var.nsg_ids
  address_space                                         = var.address_space
  dns_servers                                           = var.dns_servers
  route_tables_ids                                      = var.route_tables_ids
  vnet_location                                         = var.vnet_location
}
