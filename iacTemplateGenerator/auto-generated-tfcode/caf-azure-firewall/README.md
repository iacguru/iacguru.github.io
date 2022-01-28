
# Module `auto-generated-tfcode/caf-azure-firewall`

Core Version Constraints:
* `>= 1.0`

Provider Requirements:
* **azurerm (`hashicorp/azurerm`):** `~> 2.20`

## Input Variables
* `convention` (required): (Required) Naming convention method to use
* `diagnostics_map` (required): (Required) Storage Account and Event Hub data for the AzFW diagnostics
* `diagnostics_settings` (required): (Required) Map with the diagnostics settings for AzFW deployment
* `la_workspace_id` (required): (Required) ID of Log Analytics data for the AzFW diagnostics
* `location` (required): (Required) Location of the Azure Firewall to be created
* `max_length` (required): (Optional) You can speficy a maximum length to the name of the resource
* `name` (required): (Required) Name of the Azure Firewall to be created
* `postfix` (required): (Optional) You can use a postfix to the name of the resource
* `prefix` (required): (Optional) You can use a prefix to the name of the resource
* `public_ip_id` (required): (Required) Public IP address identifier. IP address must be of type static and standard.
* `resource_group_name` (required): (Required) Resource Group of the Azure Firewall to be created
* `subnet_id` (required): (Required) ID for the subnet where to deploy the Azure Firewall 
* `tags` (required): (Required) Tags of the Azure Firewall to be created

## Child Modules
* `terraform-azurerm-caf-azure-firewall` from `aztfmod/caf-azure-firewall/azurerm` (`v2.1`)

