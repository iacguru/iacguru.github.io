module "resource-group" {
  source              = "../module"
  resource-group-name = var.temp-resource-group-name
  location            = var.temp-location
  tags                = var.temp-tags
}