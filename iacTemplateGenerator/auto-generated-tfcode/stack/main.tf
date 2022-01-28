
#-------------------------------------------#
# terraform-azurerm-caf module!
#-------------------------------------------#

module "terraform-azurerm-caf" {
  providers                             = {
		azurerm.vhub = azurerm.vhub
	  }
  source                                = "aztfmod/caf/azurerm"
  version                               = "5.5.1"
  depends_on                            = []
  tenant_id                             = var.tenant_id
  resource_groups                       = var.resource_groups
  connectivity_subscription_id          = var.connectivity_subscription_id
  azuread                               = var.azuread
  logged_user_objectId                  = var.logged_user_objectId
  event_hubs                            = var.event_hubs
  keyvault_access_policies_azuread_apps = var.keyvault_access_policies_azuread_apps
  shared_services                       = var.shared_services
  current_landingzone_key               = var.current_landingzone_key
  enable                                = var.enable
  connectivity_tenant_id                = var.connectivity_tenant_id
  role_mapping                          = var.role_mapping
  remote_objects                        = var.remote_objects
  diagnostics                           = var.diagnostics
  keyvaults                             = var.keyvaults
  random_strings                        = var.random_strings
  event_hub_namespaces                  = var.event_hub_namespaces
  compute                               = var.compute
  networking                            = var.networking
  keyvault_certificate_issuers          = var.keyvault_certificate_issuers
  cognitive_services                    = var.cognitive_services
  diagnostics_definition                = var.diagnostics_definition
  logged_aad_app_objectId               = var.logged_aad_app_objectId
  client_config                         = var.client_config
  use_msi                               = var.use_msi
  diagnostics_destinations              = var.diagnostics_destinations
  data_factory                          = var.data_factory
  security                              = var.security
  messaging                             = var.messaging
  subscription_billing_role_assignments = var.subscription_billing_role_assignments
  cloud                                 = var.cloud
  tags                                  = var.tags
  diagnostic_storage_accounts           = var.diagnostic_storage_accounts
  communication                         = var.communication
  apim                                  = var.apim
  event_hub_namespace_auth_rules        = var.event_hub_namespace_auth_rules
  global_settings                       = var.global_settings
  database                              = var.database
  keyvault_access_policies              = var.keyvault_access_policies
  event_hub_auth_rules                  = var.event_hub_auth_rules
  subscriptions                         = var.subscriptions
  log_analytics                         = var.log_analytics
  managed_identities                    = var.managed_identities
  user_type                             = var.user_type
  storage                               = var.storage
  tfstates                              = var.tfstates
  environment                           = var.environment
  custom_role_definitions               = var.custom_role_definitions
  dynamic_keyvault_secrets              = var.dynamic_keyvault_secrets
  identity                              = var.identity
  billing                               = var.billing
  webapp                                = var.webapp
  logic_app                             = var.logic_app
  storage_accounts                      = var.storage_accounts
  event_hub_consumer_groups             = var.event_hub_consumer_groups
}

#-------------------------------------------#
# terraform-azurerm-caf-azure-firewall module!
#-------------------------------------------#

module "terraform-azurerm-caf-azure-firewall" {
  source               = "aztfmod/caf-azure-firewall/azurerm"
  version              = "v2.1"
  depends_on           = [ module.terraform-azurerm-caf ]
  name                 = var.name
  location             = var.location
  tags                 = var.tags
  la_workspace_id      = var.la_workspace_id
  subnet_id            = var.subnet_id
  public_ip_id         = var.public_ip_id
  max_length           = var.max_length
  resource_group_name  = var.resource_group_name
  diagnostics_map      = var.diagnostics_map
  diagnostics_settings = var.diagnostics_settings
  convention           = var.convention
  prefix               = var.prefix
  postfix              = var.postfix
}
