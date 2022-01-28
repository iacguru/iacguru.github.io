# Retreive Primary Azure app service details
data "azurerm_app_service" "primary_app_service" {
  count               = var.enable_app_service ? 1 : 0
  name                = var.primary_app_service_name
  resource_group_name = var.app_service_rg
}

# Retreive Failover Azure app service details
data "azurerm_app_service" "failover_app_service" {
  count               = var.enable_app_service ? 1 : 0
  name                = var.failover_app_service_name
  resource_group_name = var.app_service_rg
}

# Public IP address must be configured with DNS name
data "azurerm_public_ip" "primary_public_ip" {

  count               = var.enable_ip_add ? 1 : 0
  name                = var.primary_public_ip_add_name
  resource_group_name = var.public_ip_add_rg
}

# Public IP address must be configured with DNS name
data "azurerm_public_ip" "failover_public_ip" {

  count               = var.enable_ip_add ? 1 : 0
  name                = var.failover_public_ip_add_name
  resource_group_name = var.public_ip_add_rg
}

################################################################################
# Provision Traffic manager profile
# https://www.terraform.io/docs/providers/azurerm/r/traffic_manager_profile.html
################################################################################

resource "azurerm_traffic_manager_profile" "traffic_manager_profile" {
  name                   = var.traffic_manager_profile_name
  resource_group_name    = var.resource_group_name

  traffic_routing_method = var.enable_for_priority_routing ? "Priority" : var.enable_for_Weighted_routing ? "Weighted" : "Performance"
  #tags                   = var.tags

  dns_config {
    relative_name = var.traffic_manager_profile_name
    ttl           = var.dns_ttl_value
  }

  monitor_config {
    protocol                     = var.protocol 
    port                         = var.port_no 
    path                         = var.path
    interval_in_seconds          = var.interval_in_seconds 
    timeout_in_seconds           = var.timeout_in_seconds 
    tolerated_number_of_failures = var.tolerated_no_of_failures 
  }

  
}

#################################################################################
# Provision traffic manager endpoint
# https://www.terraform.io/docs/providers/azurerm/r/traffic_manager_endpoint.html
#################################################################################

resource "azurerm_traffic_manager_endpoint" "primary_endpoint" {
  count = 1
  name                = var.primary_endpoint_name
  resource_group_name = var.resource_group_name
  profile_name        = azurerm_traffic_manager_profile.traffic_manager_profile.name
  type                = var.enable_for_azure_endpoint ? "azureEndpoints" : var.enable_for_external_endpoint ? "externalEndpoints" : "nestedEndpoints"
  target_resource_id  = var.enable_for_azure_endpoint ? var.enable_app_service ? data.azurerm_app_service.primary_app_service[count.index].id : var.enable_ip_add ? data.azurerm_public_ip.primary_public_ip[count.index].id : null : null
  #target_resource_id  = var.enable_for_azure_endpoint ? var.enable_app_service ? data.azurerm_app_service.primary_app_service[count.index].id : data.azurerm_public_ip.primary_public_ip[count.index].id : null
  target              = var.enable_for_external_endpoint ? var.primary_fqdn : null
  priority            = var.enable_for_priority_routing ? var.primary_priority_value : null
  weight              = var.enable_for_Weighted_routing ? var.primary_weight_value : null
  endpoint_location   = var.enable_for_Performance_routing && var.enable_for_nested_endpoint || var.enable_for_external_endpoint ? var.primary_endpoint_location : null
   
}
resource "azurerm_traffic_manager_endpoint" "failover_endpoint" {
  count = 1
  name                = var.failover_endpoint_name
  resource_group_name = var.resource_group_name
  profile_name        = azurerm_traffic_manager_profile.traffic_manager_profile.name
  type                = var.enable_for_azure_endpoint ? "azureEndpoints" : var.enable_for_external_endpoint ? "externalEndpoints" : "nestedEndpoints"
  target_resource_id  = var.enable_for_azure_endpoint ? var.enable_app_service ? data.azurerm_app_service.failover_app_service[count.index].id : var.enable_ip_add ? data.azurerm_public_ip.failover_public_ip[count.index].id : null : null
  target              = var.enable_for_external_endpoint ? var.failover_fqdn : null
  priority            = var.enable_for_priority_routing ? var.failover_priority_value : null
  weight              = var.enable_for_Weighted_routing ? var.failover_weight_value : null
  endpoint_location   = var.enable_for_Performance_routing && var.enable_for_nested_endpoint || var.enable_for_external_endpoint ? var.failover_endpoint_location : null  
}
