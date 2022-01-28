
# Module `auto-generated-tfcode/stack`

Core Version Constraints:
* `>= 1.0`

Provider Requirements:
* **azurerm (`hashicorp/azurerm`):** `~> 2.20`

## Input Variables
* `apim` (required)
* `azuread` (required): Configuration object - Azure Active Directory resources
* `billing` (required): Configuration object - Billing information.
* `client_config` (required)
* `client_id` (required): The client_id of a service principal in the owner role for the subscription
* `client_secret` (required): The secret key (password) of a service principal in the owner role for the subscription. variable needs to be pulled from Azure Devops Key Vault and passed in at build time. DO NOT INCLUDE IN AND FILES!!
* `cloud` (required): Configuration object - Cloud resources defaults to Azure public, allows you to switch to other Azure endpoints.
* `cognitive_services` (required): Configuration object - Cognitive Service Resource 
* `communication` (required): Configuration object - communication resources
* `compute` (required): Configuration object - Azure compute resources
* `connectivity_subscription_id` (required): Connectivity subscription id
* `connectivity_tenant_id` (required): Connectivity tenant id
* `convention` (required): (Required) Naming convention method to use
* `current_landingzone_key` (required): Key for the current landing zones where the deployment is executed. Used in the context of landing zone deployment.
* `custom_role_definitions` (required): Configuration object - Custom role definitions
* `data_factory` (required): Configuration object - Azure Data Factory resources
* `database` (required): Configuration object - databases resources
* `diagnostic_storage_accounts` (required): Configuration object - Storage account for diagnostics resources
* `diagnostics` (required): Configuration object - Diagnostics object.
* `diagnostics_definition` (required): Configuration object - Shared diadgnostics settings that can be used by the services to enable diagnostics.
* `diagnostics_destinations` (required): Configuration object - Describes the destinations for the diagnostics.
* `diagnostics_map` (required): (Required) Storage Account and Event Hub data for the AzFW diagnostics
* `diagnostics_settings` (required): (Required) Map with the diagnostics settings for AzFW deployment
* `dynamic_keyvault_secrets` (required)
* `enable` (required): Map of services defined in the configuration file you want to disable during a deployment.
* `environment` (required): Name of the CAF environment.
* `event_hub_auth_rules` (required): Configuration object - Event Hub authentication rules
* `event_hub_consumer_groups` (required): Configuration object - Event Hub consumer group rules
* `event_hub_namespace_auth_rules` (required): Configuration object - Event Hub namespaces authentication rules
* `event_hub_namespaces` (required): Configuration object - Diagnostics object.
* `event_hubs` (required): Configuration object - Event Hub resources
* `global_settings` (required): Global settings object for the current deployment.
* `identity` (required): Configuration object - identity resources
* `keyvault_access_policies` (required): Configuration object - Azure Key Vault policies
* `keyvault_access_policies_azuread_apps` (required): Configuration object - Azure Key Vault policy for azure ad applications
* `keyvault_certificate_issuers` (required): Configuration object - Azure Key Vault Certificate Issuers resources
* `keyvaults` (required): Configuration object - Azure Key Vault resources
* `la_workspace_id` (required): (Required) ID of Log Analytics data for the AzFW diagnostics
* `location` (required): (Required) Location of the Azure Firewall to be created
* `log_analytics` (required): Configuration object - Log Analytics resources.
* `logged_aad_app_objectId` (required): Used to set access policies based on the value 'logged_in_aad_app'
* `logged_user_objectId` (required): Used to set access policies based on the value 'logged_in_user'. Can only be used in interactive execution with vscode.
* `logic_app` (required): Configuration object - Azure Logic App resources
* `managed_identities` (required): Configuration object - Azure managed identity resources
* `max_length` (required): (Optional) You can speficy a maximum length to the name of the resource
* `messaging` (required): Configuration object - messaging resources
* `name` (required): (Required) Name of the Azure Firewall to be created
* `networking` (required): Configuration object - networking resources
* `postfix` (required): (Optional) You can use a postfix to the name of the resource
* `prefix` (required): (Optional) You can use a prefix to the name of the resource
* `public_ip_id` (required): (Required) Public IP address identifier. IP address must be of type static and standard.
* `random_strings` (required): Configuration object - Random string generator resources
* `remote_objects` (required): Allow the landing zone to retrieve remote tfstate objects and pass them to the CAF module.
* `resource_group_name` (required): (Required) Resource Group of the Azure Firewall to be created
* `resource_groups` (required): Configuration object - Resource groups.
* `role_mapping` (required): Configuration object - Role mapping
* `security` (required): Configuration object - security resources
* `shared_services` (required): Configuration object - Shared services resources
* `storage` (required): Configuration object - Storage account resources
* `storage_accounts` (required): Configuration object - Storage account resources
* `subnet_id` (required): (Required) ID for the subnet where to deploy the Azure Firewall 
* `subscription_billing_role_assignments` (required): Configuration object - subscription billing roleassignments.
* `subscription_id` (required): The subscription_id of a service principal in the owner role for the subscription
* `subscriptions` (required): Configuration object - Subscriptions resources.
* `tags` (required): Tags to be used for this resource deployment.
* `tenant_id` (required): The tenant_id of a service principal in the owner role for the subscription
* `tfstates` (required): Terraform states configuration object. Used in the context of landing zone deployment.
* `use_msi` (required): Deployment using an MSI for authentication.
* `user_type` (required): The rover set this value to user or serviceprincipal. It is used to handle Azure AD API consents.
* `webapp` (required): Configuration object - Web Applications

## Child Modules
* `terraform-azurerm-caf` from `aztfmod/caf/azurerm` (`5.5.1`)
* `terraform-azurerm-caf-azure-firewall` from `aztfmod/caf-azure-firewall/azurerm` (`v2.1`)

