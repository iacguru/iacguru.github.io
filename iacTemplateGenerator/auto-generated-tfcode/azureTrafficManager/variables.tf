
#-------------------------------------------#
# azureTrafficManager variables!
#-------------------------------------------#

variable "enable_for_geographic_routing" {
  description = "Condition to enable geographic routing method "
  type        = bool
}
variable "port_no" {
  description = "Port number used by the monitoring checks"
  type        = number
}
variable "enable_for_nested_endpoint" {
  description = "Condition to enable nested Endpoint type"
  type        = bool
}
variable "traffic_manager_profile_name" {
  description = "(Required) Specifies the Name of the  Traffic manager profile"
  type        = string
}
variable "failover_priority_value" {
  description = "Priority Value of failover azure target resource to connect to"
  type        = number
}
variable "failover_endpoint_location" {
  description = "Locaton of failover endpoint service"
  type        = string
}
variable "enable_for_priority_routing" {
  description = "Condition to enable priority routing method "
  type        = bool
}
variable "enable_for_Performance_routing" {
  description = "Condition to enable performance routing method "
  type        = bool
}
variable "tolerated_no_of_failures" {
  description = "No of health probe failures tolerated before endpoint failure is triggered"
  type        = number
}
variable "primary_fqdn" {
  description = "fqdn of primary endpoint"
  type        = string
}
variable "protocol" {
  description = "Protocol used by the monitoring checks."
  type        = string
}
variable "failover_endpoint_name" {
  description = "The name of the primary endpoint"
  type        = string
}
variable "primary_weight_value" {
  description = "Weight Value of primary azure target resource to connect to"
  type        = number
}
variable "failover_weight_value" {
  description = "Weight Value of failover azure target resource to connect to"
  type        = number
}
variable "primary_app_service_name" {
  description = "Name of primary app service"
  type        = string
}
variable "dns_ttl_value" {
  description = "TTL value of the profile used for dns config"
  type        = number
}
variable "enable_app_service" {
  description = "Condition to enable app service"
  type        = bool
}
variable "public_ip_add_rg" {
  description = "Resource group where public ip exists"
  type        = string
}
variable "failover_fqdn" {
  description = "fqdn of primary endpoint"
  type        = string
}
variable "enable_for_subnet_routing" {
  description = "Condition to enable subnet routing method "
  type        = bool
}
variable "timeout_in_seconds" {
  description = "Time required before endpoint health probe times out"
  type        = number
}
variable "enable_for_external_endpoint" {
  description = "Condition to enable external Endpoint type"
  type        = bool
}
variable "failover_app_service_name" {
  description = "Name of failover app service"
  type        = string
}
variable "app_service_rg" {
  description = "Resource group of app service"
  type        = string
}
variable "primary_public_ip_add_name" {
  description = "Name of primary ip address"
  type        = string
}
variable "primary_endpoint_location" {
  description = "Locaton of primary endpoint service"
  type        = string
}
variable "resource_group_name" {
  description = "(Required) Specifies the Name of the Resource Group within which the Traffic manager should exist. Changing this forces a new resource to be created"
  type        = string
}
variable "enable_for_Weighted_routing" {
  description = "Condition to enable weighted routing method "
  type        = bool
}
variable "interval_in_seconds" {
  description = "Time interval between endpoint health probes"
  type        = number
}
variable "primary_endpoint_name" {
  description = "The name of the primary endpoint"
  type        = string
}
variable "enable_for_azure_endpoint" {
  description = "Condition to enable azure Endpoint type"
  type        = bool
}
variable "enable_for_multivalue_routing" {
  description = "Condition to enable multivalue routing method "
  type        = bool
}
variable "path" {
  description = "Path used by the monitoring checks"
  type        = string
}
variable "primary_priority_value" {
  description = "Priority Value of primary azure target resource to connect to"
  type        = number
}
variable "enable_ip_add" {
  description = "Condition to enable public ip address"
  type        = bool
}
variable "failover_public_ip_add_name" {
  description = "Name of failover public ip address"
  type        = string
}
