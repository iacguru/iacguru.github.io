
#-------------------------------------------#
# terraform-azurerm-caf variables!
#-------------------------------------------#

variable "connectivity_tenant_id" {
  description = "Connectivity tenant id"
}
variable "compute" {
  description = "Configuration object - Azure compute resources"
}
variable "storage" {
  description = "Configuration object - Storage account resources"
}
variable "current_landingzone_key" {
  description = "Key for the current landing zones where the deployment is executed. Used in the context of landing zone deployment."
  type        = string
}
variable "use_msi" {
  description = "Deployment using an MSI for authentication."
  type        = bool
}
variable "event_hub_namespaces" {
  description = "Configuration object - Diagnostics object."
}
variable "diagnostic_storage_accounts" {
  description = "Configuration object - Storage account for diagnostics resources"
}
variable "event_hub_auth_rules" {
  description = "Configuration object - Event Hub authentication rules"
}
variable "communication" {
  description = "Configuration object - communication resources"
}
variable "networking" {
  description = "Configuration object - networking resources"
}
variable "keyvaults" {
  description = "Configuration object - Azure Key Vault resources"
}
variable "azuread" {
  description = "Configuration object - Azure Active Directory resources"
}
variable "messaging" {
  description = "Configuration object - messaging resources"
}
variable "shared_services" {
  description = "Configuration object - Shared services resources"
}
variable "tags" {
  description = "Tags to be used for this resource deployment."
  type        = map(any)
}
variable "diagnostics_destinations" {
  description = "Configuration object - Describes the destinations for the diagnostics."
}
variable "log_analytics" {
  description = "Configuration object - Log Analytics resources."
}
variable "storage_accounts" {
  description = "Configuration object - Storage account resources"
}
variable "logged_user_objectId" {
  description = "Used to set access policies based on the value 'logged_in_user'. Can only be used in interactive execution with vscode."
  type        = string
}
variable "billing" {
  description = "Configuration object - Billing information."
}
variable "logic_app" {
  description = "Configuration object - Azure Logic App resources"
}
variable "event_hub_namespace_auth_rules" {
  description = "Configuration object - Event Hub namespaces authentication rules"
}
variable "security" {
  description = "Configuration object - security resources"
}
variable "keyvault_access_policies" {
  description = "Configuration object - Azure Key Vault policies"
}
variable "subscription_billing_role_assignments" {
  description = "Configuration object - subscription billing roleassignments."
}
variable "diagnostics" {
  description = "Configuration object - Diagnostics object."
}
variable "managed_identities" {
  description = "Configuration object - Azure managed identity resources"
}
variable "data_factory" {
  description = "Configuration object - Azure Data Factory resources"
}
variable "event_hubs" {
  description = "Configuration object - Event Hub resources"
}
variable "cognitive_services" {
  description = "Configuration object - Cognitive Service Resource "
}
variable "client_config" {
  description = ""
}
variable "connectivity_subscription_id" {
  description = "Connectivity subscription id"
}
variable "keyvault_access_policies_azuread_apps" {
  description = "Configuration object - Azure Key Vault policy for azure ad applications"
}
variable "custom_role_definitions" {
  description = "Configuration object - Custom role definitions"
}
variable "role_mapping" {
  description = "Configuration object - Role mapping"
}
variable "cloud" {
  description = "Configuration object - Cloud resources defaults to Azure public, allows you to switch to other Azure endpoints."
}
variable "enable" {
  description = "Map of services defined in the configuration file you want to disable during a deployment."
}
variable "random_strings" {
  description = "Configuration object - Random string generator resources"
}
variable "identity" {
  description = "Configuration object - identity resources"
}
variable "keyvault_certificate_issuers" {
  description = "Configuration object - Azure Key Vault Certificate Issuers resources"
}
variable "database" {
  description = "Configuration object - databases resources"
}
variable "dynamic_keyvault_secrets" {
  description = ""
}
variable "resource_groups" {
  description = "Configuration object - Resource groups."
}
variable "subscriptions" {
  description = "Configuration object - Subscriptions resources."
}
variable "user_type" {
  description = "The rover set this value to user or serviceprincipal. It is used to handle Azure AD API consents."
}
variable "tfstates" {
  description = "Terraform states configuration object. Used in the context of landing zone deployment."
}
variable "webapp" {
  description = "Configuration object - Web Applications"
}
variable "logged_aad_app_objectId" {
  description = "Used to set access policies based on the value 'logged_in_aad_app'"
  type        = string
}
variable "remote_objects" {
  description = "Allow the landing zone to retrieve remote tfstate objects and pass them to the CAF module."
}
variable "diagnostics_definition" {
  description = "Configuration object - Shared diadgnostics settings that can be used by the services to enable diagnostics."
}
variable "event_hub_consumer_groups" {
  description = "Configuration object - Event Hub consumer group rules"
}
variable "apim" {
  description = ""
}
variable "global_settings" {
  description = "Global settings object for the current deployment."
}
variable "environment" {
  description = "Name of the CAF environment."
  type        = string
}
