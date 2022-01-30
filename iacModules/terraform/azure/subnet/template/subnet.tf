module "subnet" {
  source                      = "../module"
  resource-group-name         = var.temp-resource-group-name
  vnet-name                   = var.temp-vnet-name
  subnet-name                 = var.temp-subnet-name
  address-prefixes            = var.temp-address-prefixes
  service-endpoints           = var.temp-service-endpoints
  service-endpoint-policy-ids = var.temp-service-endpoint-policy-ids
  delegation                  = var.temp-delegation
}