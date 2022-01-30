terraform {
  required_version = "~>1.0"
  required_providers {
    azurerm = {
      version = ">= 2.90"
      source  = "hashicorp/azurerm"
    }
  }
}