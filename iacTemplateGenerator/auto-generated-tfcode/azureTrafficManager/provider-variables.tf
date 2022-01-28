variable "subscription_id" {
  description = "The subscription_id of a service principal in the owner role for the subscription"
  type        = string
}
variable "tenant_id" {
  description = "The tenant_id of a service principal in the owner role for the subscription"
  type        = string
}
variable "client_id" {
  description = "The client_id of a service principal in the owner role for the subscription"
  type        = string
}
variable "client_secret" {
  description = "The secret key (password) of a service principal in the owner role for the subscription. variable needs to be pulled from Azure Devops Key Vault and passed in at build time. DO NOT INCLUDE IN AND FILES!!"
  type        = string
}
