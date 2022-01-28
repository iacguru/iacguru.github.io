
#-------------------------------------------#
# terraform-azurerm-vnet variables!
#-------------------------------------------#

variable "resource_group_name" {
  description = "Name of the resource group to be imported."
  type        = string
}
variable "route_tables_ids" {
  description = "A map of subnet name to Route table ids"
  type        = map(string)
}
variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)
}
variable "vnet_location" {
  description = "The location of the vnet to create. Defaults to the location of the resource group."
  type        = string
}
variable "address_space" {
  description = "The address space that is used by the virtual network."
  type        = list(string)
}
variable "dns_servers" {
  description = "The DNS servers to be used with vNet."
  type        = list(string)
}
variable "subnet_prefixes" {
  description = "The address prefix to use for the subnet."
  type        = list(string)
}
variable "subnet_names" {
  description = "A list of public subnets inside the vNet."
  type        = list(string)
}
variable "subnet_service_endpoints" {
  description = "A map of subnet name to service endpoints to add to the subnet."
  type        = map(any)
}
variable "subnet_enforce_private_link_endpoint_network_policies" {
  description = "A map of subnet name to enable/disable private link endpoint network policies on the subnet."
  type        = map(bool)
}
variable "nsg_ids" {
  description = "A map of subnet name to Network Security Group IDs"
  type        = map(string)
}
variable "vnet_name" {
  description = "Name of the vnet to create"
  type        = string
}
variable "subnet_enforce_private_link_service_network_policies" {
  description = "A map of subnet name to enable/disable private link service network policies on the subnet."
  type        = map(bool)
}
variable "subnet_delegation" {
  description = "A map of subnet name to delegation block on the subnet"
  type        = map(map(any))
}
