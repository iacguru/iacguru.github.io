
# Module `auto-generated-tfcode/network`

Core Version Constraints:
* `>= 1.0`

Provider Requirements:
* **azurerm (`hashicorp/azurerm`):** `~> 2.20`

## Input Variables
* `address_space` (required): The address space that is used by the virtual network.
* `address_spaces` (required): The list of the address spaces that is used by the virtual network.
* `client_id` (required): The client_id of a service principal in the owner role for the subscription
* `client_secret` (required): The secret key (password) of a service principal in the owner role for the subscription. variable needs to be pulled from Azure Devops Key Vault and passed in at build time. DO NOT INCLUDE IN AND FILES!!
* `dns_servers` (required): The DNS servers to be used with vNet.
* `resource_group_name` (required): The name of an existing resource group to be imported.
* `subnet_enforce_private_link_endpoint_network_policies` (required): A map with key (string) `subnet name`, value (bool) `true` or `false` to indicate enable or disable network policies for the private link endpoint on the subnet. Default value is false.
* `subnet_names` (required): A list of public subnets inside the vNet.
* `subnet_prefixes` (required): The address prefix to use for the subnet.
* `subnet_service_endpoints` (required): A map with key (string) `subnet name`, value (list(string)) to indicate enabled service endpoints on the subnet. Default value is [].
* `subscription_id` (required): The subscription_id of a service principal in the owner role for the subscription
* `tags` (required): The tags to associate with your network and subnets.
* `tenant_id` (required): The tenant_id of a service principal in the owner role for the subscription
* `vnet_name` (required): Name of the vnet to create.

## Child Modules
* `terraform-azurerm-network` from `Azure/network/azurerm` (`v3.0.1`)

