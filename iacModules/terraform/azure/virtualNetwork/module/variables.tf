# Required Variables
variable "resource-group-name" {
  type        = string
  description = "Name of the resource group to create the virtual network in."
}

variable "vnet-name" {
  type        = string
  description = "Name of the virtual network to create."
}

variable "address-space" {
  type        = list(string)
  description = "Address space of the virtual network to create."
}

# Optional Variables
variable "tags" {
  type        = map(string)
  description = "Tags to be created for the virtual network."
  default     = {}
}

variable "bgp-community" {
  type        = string
  description = "Value for the bgp community of the virtual network. Must be in format format <as-number>:<community-value>."
  default     = ""
}

variable "dns-servers" {
  type        = list(string)
  description = "List of IP addresses of DNS servers."
  default     = []
}

variable "flow-timeout-in-minutes" {
  type        = number
  description = "The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes."
  default     = 4
}

variable "ddos-protection-plan-id" {
  type        = string
  description = "The ID of DDoS Protection Plan."
  default     = ""
}

variable "ddos-protection-plan-enabled" {
  type        = bool
  description = "Enable/disable DDoS Protection Plan on Virtual Network."
  default     = false
}

variable "subnet-info" {
  type = list(object({
    name              = string
    address-prefix    = string
    security-group-id = string
  }))
  description = <<EOT
	1. name = The name of the subnet to create in the virtual network.
	2. address-prefix = The address prefix to use for the subnet.
	3. security-group-id = The Network Security Group to associate with the subnet. Requires NSG Id to be cofigured.
	EOT
  default     = []
}