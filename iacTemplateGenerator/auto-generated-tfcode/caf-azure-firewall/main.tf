
#-------------------------------------------#
# terraform-azurerm-caf-azure-firewall module!
#-------------------------------------------#

module "terraform-azurerm-caf-azure-firewall" {
  source               = "aztfmod/caf-azure-firewall/azurerm"
  version              = "v2.1"
  depends_on           = []
  subnet_id            = var.subnet_id
  name                 = var.name
  la_workspace_id      = var.la_workspace_id
  resource_group_name  = var.resource_group_name
  diagnostics_map      = var.diagnostics_map
  public_ip_id         = var.public_ip_id
  diagnostics_settings = var.diagnostics_settings
  convention           = var.convention
  prefix               = var.prefix
  location             = var.location
  tags                 = var.tags
  postfix              = var.postfix
  max_length           = var.max_length
}
