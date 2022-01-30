# Required Variables
variable "resource-group-name" {
  type        = string
  description = "Name of the resource group to create."
}

variable "location" {
  type        = string
  description = "Location of the resource group to create."
}

# Optional Variables
variable "tags" {
  type        = map(string)
  description = "Tags to be created for the resource group."
  default     = {}
}