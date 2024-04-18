provider "azurerm" {
  features {
    resource_provider_registration {
      skip_provider_registration = true
    }
  }
}

provider "azapi" {}
