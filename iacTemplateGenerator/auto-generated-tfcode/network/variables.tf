
#-------------------------------------------#
# terraform-azurerm-network variables!
#-------------------------------------------#

variable "resource_group_name" {
  description = "The name of an existing resource group to be imported."
  type        = string
}
variable "address_space" {
  description = "The address space that is used by the virtual network."
  type        = string
}
variable "address_spaces" {
  description = "The list of the address spaces that is used by the virtual network."
  type        = list(string)
}
variable "dns_servers" {
  description = "The DNS servers to be used with vNet."
  type        = list(string)
}
variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)
}
variable "vnet_name" {
  description = "Name of the vnet to create."
  type        = string
}
variable "subnet_prefixes" {
  description = "The address prefix to use for the subnet."
  type        = list(string)
}
variable "subnet_names" {
  description = "A list of public subnets inside the vNet."
  type        = list(string)
}
variable "subnet_enforce_private_link_endpoint_network_policies" {
  description = "A map with key (string) `subnet name`, value (bool) `true` or `false` to indicate enable or disable network policies for the private link endpoint on the subnet. Default value is false."
  type        = map(bool)
}
variable "subnet_service_endpoints" {
  description = "A map with key (string) `subnet name`, value (list(string)) to indicate enabled service endpoints on the subnet. Default value is []."
  type        = map(list(string))
}
