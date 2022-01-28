
#-------------------------------------------#
# terraform-azurerm-caf variables!
#-------------------------------------------#

variable "event_hub_namespaces" {
  description = "Configuration object - Diagnostics object."
}
variable "azuread" {
  description = "Configuration object - Azure Active Directory resources"
}
variable "security" {
  description = "Configuration object - security resources"
}
variable "role_mapping" {
  description = "Configuration object - Role mapping"
}
variable "storage_accounts" {
  description = "Configuration object - Storage account resources"
}
variable "random_strings" {
  description = "Configuration object - Random string generator resources"
}
variable "identity" {
  description = "Configuration object - identity resources"
}
variable "client_config" {
  description = ""
}
variable "tfstates" {
  description = "Terraform states configuration object. Used in the context of landing zone deployment."
}
variable "diagnostics_destinations" {
  description = "Configuration object - Describes the destinations for the diagnostics."
}
variable "diagnostics" {
  description = "Configuration object - Diagnostics object."
}
variable "shared_services" {
  description = "Configuration object - Shared services resources"
}
variable "resource_groups" {
  description = "Configuration object - Resource groups."
}
variable "log_analytics" {
  description = "Configuration object - Log Analytics resources."
}
variable "event_hub_namespace_auth_rules" {
  description = "Configuration object - Event Hub namespaces authentication rules"
}
variable "apim" {
  description = ""
}
variable "keyvault_certificate_issuers" {
  description = "Configuration object - Azure Key Vault Certificate Issuers resources"
}
variable "cloud" {
  description = "Configuration object - Cloud resources defaults to Azure public, allows you to switch to other Azure endpoints."
}
variable "webapp" {
  description = "Configuration object - Web Applications"
}
variable "networking" {
  description = "Configuration object - networking resources"
}
variable "communication" {
  description = "Configuration object - communication resources"
}
variable "logged_user_objectId" {
  description = "Used to set access policies based on the value 'logged_in_user'. Can only be used in interactive execution with vscode."
  type        = string
}
variable "data_factory" {
  description = "Configuration object - Azure Data Factory resources"
}
variable "event_hubs" {
  description = "Configuration object - Event Hub resources"
}
variable "enable" {
  description = "Map of services defined in the configuration file you want to disable during a deployment."
}
variable "environment" {
  description = "Name of the CAF environment."
  type        = string
}
variable "use_msi" {
  description = "Deployment using an MSI for authentication."
  type        = bool
}
variable "storage" {
  description = "Configuration object - Storage account resources"
}
variable "event_hub_consumer_groups" {
  description = "Configuration object - Event Hub consumer group rules"
}
variable "billing" {
  description = "Configuration object - Billing information."
}
variable "logic_app" {
  description = "Configuration object - Azure Logic App resources"
}
variable "cognitive_services" {
  description = "Configuration object - Cognitive Service Resource "
}
variable "logged_aad_app_objectId" {
  description = "Used to set access policies based on the value 'logged_in_aad_app'"
  type        = string
}
variable "database" {
  description = "Configuration object - databases resources"
}
variable "keyvault_access_policies_azuread_apps" {
  description = "Configuration object - Azure Key Vault policy for azure ad applications"
}
variable "custom_role_definitions" {
  description = "Configuration object - Custom role definitions"
}
variable "current_landingzone_key" {
  description = "Key for the current landing zones where the deployment is executed. Used in the context of landing zone deployment."
  type        = string
}
variable "subscription_billing_role_assignments" {
  description = "Configuration object - subscription billing roleassignments."
}
variable "keyvaults" {
  description = "Configuration object - Azure Key Vault resources"
}
variable "global_settings" {
  description = "Global settings object for the current deployment."
}
variable "diagnostics_definition" {
  description = "Configuration object - Shared diadgnostics settings that can be used by the services to enable diagnostics."
}
variable "user_type" {
  description = "The rover set this value to user or serviceprincipal. It is used to handle Azure AD API consents."
}
variable "connectivity_subscription_id" {
  description = "Connectivity subscription id"
}
variable "remote_objects" {
  description = "Allow the landing zone to retrieve remote tfstate objects and pass them to the CAF module."
}
variable "tags" {
  description = "Tags to be used for this resource deployment."
  type        = map(any)
}
variable "connectivity_tenant_id" {
  description = "Connectivity tenant id"
}
variable "compute" {
  description = "Configuration object - Azure compute resources"
}
variable "managed_identities" {
  description = "Configuration object - Azure managed identity resources"
}
variable "dynamic_keyvault_secrets" {
  description = ""
}
variable "event_hub_auth_rules" {
  description = "Configuration object - Event Hub authentication rules"
}
variable "subscriptions" {
  description = "Configuration object - Subscriptions resources."
}
variable "messaging" {
  description = "Configuration object - messaging resources"
}
variable "keyvault_access_policies" {
  description = "Configuration object - Azure Key Vault policies"
}
variable "diagnostic_storage_accounts" {
  description = "Configuration object - Storage account for diagnostics resources"
}

#-------------------------------------------#
# terraform-azurerm-caf-azure-firewall variables!
#-------------------------------------------#

variable "prefix" {
  description = "(Optional) You can use a prefix to the name of the resource"
  type        = string
}
variable "resource_group_name" {
  description = "(Required) Resource Group of the Azure Firewall to be created"
}
variable "subnet_id" {
  description = "(Required) ID for the subnet where to deploy the Azure Firewall "
}
variable "diagnostics_map" {
  description = "(Required) Storage Account and Event Hub data for the AzFW diagnostics"
}
variable "la_workspace_id" {
  description = "(Required) ID of Log Analytics data for the AzFW diagnostics"
}
variable "public_ip_id" {
  description = "(Required) Public IP address identifier. IP address must be of type static and standard."
}
variable "diagnostics_settings" {
  description = "(Required) Map with the diagnostics settings for AzFW deployment"
}
variable "convention" {
  description = "(Required) Naming convention method to use"
}
variable "name" {
  description = "(Required) Name of the Azure Firewall to be created"
}
variable "location" {
  description = "(Required) Location of the Azure Firewall to be created"
}
variable "postfix" {
  description = "(Optional) You can use a postfix to the name of the resource"
  type        = string
}
variable "max_length" {
  description = "(Optional) You can speficy a maximum length to the name of the resource"
  type        = string
}
