# Required variables
temp-resource-group-name = "default"
temp-vnet-name           = "mynewvnet"
temp-address-space       = ["10.0.0.0/16"]

# Optional variables
temp-bgp-community                = ""
temp-dns-servers                  = []
temp-flow-timeout-in-minutes      = 4
temp-ddos-protection-plan-id      = ""
temp-ddos-protection-plan-enabled = false
temp-subnet-info = [
  {
    name              = "subnet1"
    address-prefix    = "10.0.1.0/24"
    security-group-id = ""
  },
  {
    name              = "subnet2"
    address-prefix    = "10.0.2.0/24"
    security-group-id = ""
  }
]
temp-tags = {
  owner = "iacguru"
}
