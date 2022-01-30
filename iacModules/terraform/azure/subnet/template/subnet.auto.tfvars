# Required Variables
temp-resource-group-name = "default"
temp-vnet-name           = "mynewvnet"
temp-subnet-name         = "mynewsubnet"
temp-address_prefixes    = ["10.0.1.0/24"]

# Optional Variables
temp-service-endpoints           = []
temp-service-endpoint-policy-ids = []
temp-delegation = [
  {
    name         = "delegation1"
    service-name = "Microsoft.ContainerInstance/containerGroups"
    actions      = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
  }
]