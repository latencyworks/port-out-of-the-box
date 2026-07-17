terraform {
  required_version = ">= 1.15.0"

  # Partial Terraform Cloud config: CI sets TF_CLOUD_ORGANIZATION and TF_WORKSPACE
  # (plus TF_TOKEN_app_terraform_io via hashicorp/setup-terraform).
  cloud {}

  required_providers {
    # Local name must be port-labs so `terraform plan -generate-config-out`
    # emits matching `provider = port-labs` (no post-edit of generated.tf).
    port-labs = {
      source  = "port-labs/port-labs"
      version = "~> 2.22.0"
    }
  }
}
