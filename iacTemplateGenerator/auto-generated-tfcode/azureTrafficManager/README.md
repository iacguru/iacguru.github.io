
# Module `auto-generated-tfcode/azureTrafficManager`

Core Version Constraints:
* `>= 1.0`

Provider Requirements:
* **azurerm (`hashicorp/azurerm`):** `~> 2.20`

## Input Variables
* `app_service_rg` (required): Resource group of app service
* `client_id` (required): The client_id of a service principal in the owner role for the subscription
* `client_secret` (required): The secret key (password) of a service principal in the owner role for the subscription. variable needs to be pulled from Azure Devops Key Vault and passed in at build time. DO NOT INCLUDE IN AND FILES!!
* `dns_ttl_value` (required): TTL value of the profile used for dns config
* `enable_app_service` (required): Condition to enable app service
* `enable_for_Performance_routing` (required): Condition to enable performance routing method 
* `enable_for_Weighted_routing` (required): Condition to enable weighted routing method 
* `enable_for_azure_endpoint` (required): Condition to enable azure Endpoint type
* `enable_for_external_endpoint` (required): Condition to enable external Endpoint type
* `enable_for_geographic_routing` (required): Condition to enable geographic routing method 
* `enable_for_multivalue_routing` (required): Condition to enable multivalue routing method 
* `enable_for_nested_endpoint` (required): Condition to enable nested Endpoint type
* `enable_for_priority_routing` (required): Condition to enable priority routing method 
* `enable_for_subnet_routing` (required): Condition to enable subnet routing method 
* `enable_ip_add` (required): Condition to enable public ip address
* `failover_app_service_name` (required): Name of failover app service
* `failover_endpoint_location` (required): Locaton of failover endpoint service
* `failover_endpoint_name` (required): The name of the primary endpoint
* `failover_fqdn` (required): fqdn of primary endpoint
* `failover_priority_value` (required): Priority Value of failover azure target resource to connect to
* `failover_public_ip_add_name` (required): Name of failover public ip address
* `failover_weight_value` (required): Weight Value of failover azure target resource to connect to
* `interval_in_seconds` (required): Time interval between endpoint health probes
* `path` (required): Path used by the monitoring checks
* `port_no` (required): Port number used by the monitoring checks
* `primary_app_service_name` (required): Name of primary app service
* `primary_endpoint_location` (required): Locaton of primary endpoint service
* `primary_endpoint_name` (required): The name of the primary endpoint
* `primary_fqdn` (required): fqdn of primary endpoint
* `primary_priority_value` (required): Priority Value of primary azure target resource to connect to
* `primary_public_ip_add_name` (required): Name of primary ip address
* `primary_weight_value` (required): Weight Value of primary azure target resource to connect to
* `protocol` (required): Protocol used by the monitoring checks.
* `public_ip_add_rg` (required): Resource group where public ip exists
* `resource_group_name` (required): (Required) Specifies the Name of the Resource Group within which the Traffic manager should exist. Changing this forces a new resource to be created
* `subscription_id` (required): The subscription_id of a service principal in the owner role for the subscription
* `tenant_id` (required): The tenant_id of a service principal in the owner role for the subscription
* `timeout_in_seconds` (required): Time required before endpoint health probe times out
* `tolerated_no_of_failures` (required): No of health probe failures tolerated before endpoint failure is triggered
* `traffic_manager_profile_name` (required): (Required) Specifies the Name of the  Traffic manager profile

## Child Modules
* `azureTrafficManager` from `terraform.io//azurerm`

