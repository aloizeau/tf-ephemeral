provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

terraform {
  required_version = "1.11.2"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.7.1"
    }
  }
}

resource "azurerm_resource_group" "example" {
  name     = "ephemeral-example"
  location = "West US"
}
