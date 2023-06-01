terraform {
  required_version = ">= 1.4.0, <2.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.58.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }
  backend "azurerm" {
    resource_group_name  = "state-and-backend"
    storage_account_name = "jkrilovtfstate"
    container_name       = "state"
    key                  = "acapoker.tfstate"
  }
}

provider "azurerm" {
  features {}
}
