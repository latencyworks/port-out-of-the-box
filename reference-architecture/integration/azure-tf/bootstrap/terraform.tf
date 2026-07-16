# One-time OIDC bootstrap for GitHub Actions. Apply locally with `az login`.
# Not used by the CI workflow (that runs ../terraform only). Local state only.

terraform {
  required_version = ">= 1.15.0"

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azuread" {}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}
