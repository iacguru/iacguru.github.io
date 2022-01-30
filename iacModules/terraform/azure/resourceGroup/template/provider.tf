############# Azure Authentication Approaches #############
# Approach 1: Declare Service Prinicipal credentials as environment variables
# Approach 2: Create variables for each "azurerm" provider attribute and set values for it.

provider "azurerm" {
  features {}
}