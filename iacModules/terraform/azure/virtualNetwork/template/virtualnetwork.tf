module "vnet" {
  source                       = "../module"
  resource-group-name          = var.temp-resource-group-name
  vnet-name                    = var.temp-vnet-name
  address-space                = var.temp-address-space
  tags                         = var.temp-tags
  bgp-community                = var.temp-bgp-community
  dns-servers                  = var.temp-dns-servers
  flow-timeout-in-minutes      = var.temp-flow-timeout-in-minutes
  ddos-protection-plan-id      = var.temp-ddos-protection-plan-id
  ddos-protection-plan-enabled = var.temp-ddos-protection-plan-enabled
  subnet-info                  = var.temp-subnet-info
}