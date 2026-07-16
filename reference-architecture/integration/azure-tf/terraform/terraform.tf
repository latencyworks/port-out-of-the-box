terraform {
  required_version = ">= 1.15.0"

  # State lives in Terraform Cloud. Set TF_CLOUD_ORGANIZATION and TF_WORKSPACE
  # (or run `terraform login`). See README.
  cloud {}

  # Prefer an Azure-native backend instead? Comment out `cloud {}` above and use:
  # backend "azurerm" {
  #   resource_group_name  = "<state-rg>"
  #   storage_account_name = "<state-storage-account>"
  #   container_name       = "tfstate"
  #   key                  = "azure-tf.tfstate"
  # }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

# Hosting subscription: where the Container App and its Event Grid topic are created.
# prevent_deletion_if_contains_resources = false: this module owns the whole RG;
# allow Azure to clear nested leftovers (e.g. Container Apps Environment) on destroy.
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = var.hosting_subscription_id
}

# To also ingest live events from another subscription, add an aliased provider here
# and uncomment the matching module block in main.tf.
# provider "azurerm" {
#   alias           = "extra"
#   features {
#     resource_group {
#       prevent_deletion_if_contains_resources = false
#     }
#   }
#   subscription_id = "<other-subscription-id>"
# }
