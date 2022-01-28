
# Module `auto-generated-tfcode/vnet`

Core Version Constraints:
* `>= 1.0`

Provider Requirements:
* **azurerm (`hashicorp/azurerm`):** `~> 2.20`

## Input Variables
* `address_space` (required): The address space that is used by the virtual network.
* `client_id` (required): The client_id of a service principal in the owner role for the subscription
* `client_secret` (required): The secret key (password) of a service principal in the owner role for the subscription. variable needs to be pulled from Azure Devops Key Vault and passed in at build time. DO NOT INCLUDE IN AND FILES!!
* `dns_servers` (required): The DNS servers to be used with vNet.
* `nsg_ids` (required): A map of subnet name to Network Security Group IDs
* `resource_group_name` (required): Name of the resource group to be imported.
* `route_tables_ids` (required): A map of subnet name to Route table ids
* `subnet_delegation` (required): A map of subnet name to delegation block on the subnet
* `subnet_enforce_private_link_endpoint_network_policies` (required): A map of subnet name to enable/disable private link endpoint network policies on the subnet.
* `subnet_enforce_private_link_service_network_policies` (required): A map of subnet name to enable/disable private link service network policies on the subnet.
* `subnet_names` (required): A list of public subnets inside the vNet.
* `subnet_prefixes` (required): The address prefix to use for the subnet.
* `subnet_service_endpoints` (required): A map of subnet name to service endpoints to add to the subnet.
* `subscription_id` (required): The subscription_id of a service principal in the owner role for the subscription
* `tags` (required): The tags to associate with your network and subnets.
* `tenant_id` (required): The tenant_id of a service principal in the owner role for the subscription
* `vnet_location` (required): The location of the vnet to create. Defaults to the location of the resource group.
* `vnet_name` (required): Name of the vnet to create

## Child Modules
* `terraform-azurerm-vnet` from `Azure/vnet/azurerm` (`v1.2.0`)

