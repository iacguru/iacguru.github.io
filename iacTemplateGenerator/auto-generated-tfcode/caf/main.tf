
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
  enable                                = var.enable
  data_factory                          = var.data_factory
  networking                            = var.networking
  keyvault_access_policies_azuread_apps = var.keyvault_access_policies_azuread_apps
  environment                           = var.environment
  use_msi                               = var.use_msi
  security                              = var.security
  managed_identities                    = var.managed_identities
  event_hub_consumer_groups             = var.event_hub_consumer_groups
  logged_aad_app_objectId               = var.logged_aad_app_objectId
  keyvault_access_policies              = var.keyvault_access_policies
  communication                         = var.communication
  event_hubs                            = var.event_hubs
  resource_groups                       = var.resource_groups
  connectivity_subscription_id          = var.connectivity_subscription_id
  connectivity_tenant_id                = var.connectivity_tenant_id
  messaging                             = var.messaging
  cognitive_services                    = var.cognitive_services
  global_settings                       = var.global_settings
  diagnostics_destinations              = var.diagnostics_destinations
  role_mapping                          = var.role_mapping
  storage_accounts                      = var.storage_accounts
  shared_services                       = var.shared_services
  remote_objects                        = var.remote_objects
  diagnostics                           = var.diagnostics
  identity                              = var.identity
  event_hub_namespaces                  = var.event_hub_namespaces
  client_config                         = var.client_config
  database                              = var.database
  keyvaults                             = var.keyvaults
  tenant_id                             = var.tenant_id
  current_landingzone_key               = var.current_landingzone_key
  subscriptions                         = var.subscriptions
  log_analytics                         = var.log_analytics
  custom_role_definitions               = var.custom_role_definitions
  dynamic_keyvault_secrets              = var.dynamic_keyvault_secrets
  apim                                  = var.apim
  tfstates                              = var.tfstates
  user_type                             = var.user_type
  diagnostic_storage_accounts           = var.diagnostic_storage_accounts
  event_hub_namespace_auth_rules        = var.event_hub_namespace_auth_rules
  cloud                                 = var.cloud
  logged_user_objectId                  = var.logged_user_objectId
  storage                               = var.storage
  tags                                  = var.tags
  subscription_billing_role_assignments = var.subscription_billing_role_assignments
  billing                               = var.billing
  diagnostics_definition                = var.diagnostics_definition
  keyvault_certificate_issuers          = var.keyvault_certificate_issuers
  compute                               = var.compute
  webapp                                = var.webapp
  logic_app                             = var.logic_app
  event_hub_auth_rules                  = var.event_hub_auth_rules
  random_strings                        = var.random_strings
  azuread                               = var.azuread
}
