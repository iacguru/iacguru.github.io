
#-------------------------------------------#
# terraform-azurerm-network module!
#-------------------------------------------#

module "terraform-azurerm-network" {
  source                                                = "Azure/network/azurerm"
  version                                               = "v3.0.1"
  depends_on                                            = []
  address_spaces                                        = var.address_spaces
  subnet_prefixes                                       = var.subnet_prefixes
  tags                                                  = var.tags
  subnet_enforce_private_link_endpoint_network_policies = var.subnet_enforce_private_link_endpoint_network_policies
  subnet_service_endpoints                              = var.subnet_service_endpoints
  resource_group_name                                   = var.resource_group_name
  address_space                                         = var.address_space
  dns_servers                                           = var.dns_servers
  subnet_names                                          = var.subnet_names
  vnet_name                                             = var.vnet_name
}
