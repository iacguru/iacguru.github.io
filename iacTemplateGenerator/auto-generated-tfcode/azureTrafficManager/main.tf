
#-------------------------------------------#
# azureTrafficManager module!
#-------------------------------------------#

module "azureTrafficManager" {
  source                         = "terraform.io//azurerm"
  version                        = ""
  depends_on                     = []
  enable_for_priority_routing    = var.enable_for_priority_routing
  traffic_manager_profile_name   = var.traffic_manager_profile_name
  primary_endpoint_location      = var.primary_endpoint_location
  enable_for_subnet_routing      = var.enable_for_subnet_routing
  enable_for_geographic_routing  = var.enable_for_geographic_routing
  dns_ttl_value                  = var.dns_ttl_value
  failover_weight_value          = var.failover_weight_value
  enable_app_service             = var.enable_app_service
  tolerated_no_of_failures       = var.tolerated_no_of_failures
  primary_weight_value           = var.primary_weight_value
  primary_fqdn                   = var.primary_fqdn
  interval_in_seconds            = var.interval_in_seconds
  enable_for_azure_endpoint      = var.enable_for_azure_endpoint
  primary_priority_value         = var.primary_priority_value
  failover_app_service_name      = var.failover_app_service_name
  failover_public_ip_add_name    = var.failover_public_ip_add_name
  resource_group_name            = var.resource_group_name
  enable_for_Weighted_routing    = var.enable_for_Weighted_routing
  protocol                       = var.protocol
  app_service_rg                 = var.app_service_rg
  public_ip_add_rg               = var.public_ip_add_rg
  failover_priority_value        = var.failover_priority_value
  enable_ip_add                  = var.enable_ip_add
  primary_app_service_name       = var.primary_app_service_name
  enable_for_Performance_routing = var.enable_for_Performance_routing
  enable_for_multivalue_routing  = var.enable_for_multivalue_routing
  primary_endpoint_name          = var.primary_endpoint_name
  failover_endpoint_name         = var.failover_endpoint_name
  enable_for_external_endpoint   = var.enable_for_external_endpoint
  primary_public_ip_add_name     = var.primary_public_ip_add_name
  failover_fqdn                  = var.failover_fqdn
  port_no                        = var.port_no
  path                           = var.path
  timeout_in_seconds             = var.timeout_in_seconds
  enable_for_nested_endpoint     = var.enable_for_nested_endpoint
  failover_endpoint_location     = var.failover_endpoint_location
}
