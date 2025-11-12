terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.44.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.7.1"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.18.1"
    }
  }
}


provider "azurerm" {
  features {}
  subscription_id = "3f4307f4-ae2b-4a54-a328-4564262560d1"
}