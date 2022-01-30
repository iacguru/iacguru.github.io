# Required Variables
variable "resource-group-name" {
  type        = string
  description = "Name of the resource group to create the subnet in."
}

variable "vnet-name" {
  type        = string
  description = "The name of the virtual network to which to attach the subnet."
}

variable "subnet-name" {
  type        = string
  description = "Name of the subnet to create."
}

variable "address-prefixes" {
  type        = list(string)
  description = "The address prefixes to use for the subnet."
}

# Optional Variables
variable "service-endpoints" {
  type        = list(string)
  description = "The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web."
  default     = []
}

variable "service-endpoint-policy-ids" {
  type        = list(string)
  description = "The list of IDs of Service Endpoint Policies to associate with the subnet."
  default     = []
}

variable "delegation" {
  type = list(object({
    name         = string
    service-name = string
    actions      = list(string)
  }))
  description = <<EOT
  1. name = A name for this delegation.
  2. service-name = The name of service to delegate to. Possible values include Microsoft.ApiManagement/service, Microsoft.AzureCosmosDB/clusters, Microsoft.BareMetal/AzureVMware, Microsoft.BareMetal/CrayServers, Microsoft.Batch/batchAccounts, Microsoft.ContainerInstance/containerGroups, Microsoft.ContainerService/managedClusters, Microsoft.Databricks/workspaces, Microsoft.DBforMySQL/flexibleServers, Microsoft.DBforMySQL/serversv2, Microsoft.DBforPostgreSQL/flexibleServers, Microsoft.DBforPostgreSQL/serversv2, Microsoft.DBforPostgreSQL/singleServers, Microsoft.HardwareSecurityModules/dedicatedHSMs, Microsoft.Kusto/clusters, Microsoft.Logic/integrationServiceEnvironments, Microsoft.MachineLearningServices/workspaces, Microsoft.Netapp/volumes, Microsoft.Network/managedResolvers, Microsoft.PowerPlatform/vnetaccesslinks, Microsoft.ServiceFabricMesh/networks, Microsoft.Sql/managedInstances, Microsoft.Sql/servers, Microsoft.StreamAnalytics/streamingJobs, Microsoft.Synapse/workspaces, Microsoft.Web/hostingEnvironments, and Microsoft.Web/serverFarms.
  3. actions = A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include Microsoft.Network/networkinterfaces/*, Microsoft.Network/virtualNetworks/subnets/action, Microsoft.Network/virtualNetworks/subnets/join/action, Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action and Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action.
  EOT
  default     = []
}