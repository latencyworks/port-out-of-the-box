variable "subscription_id" {
  type        = string
  description = "Azure subscription for role assignments (and where the integration will deploy)."
}

variable "application_display_name" {
  type        = string
  default     = "port-azure-tf"
  description = "Entra app registration display name."
}

variable "github_org" {
  type        = string
  default     = "port-experimental"
  description = "GitHub org trusted by the federated credential."
}

variable "github_repo" {
  type        = string
  default     = "port-out-of-the-box"
  description = "GitHub repo trusted by the federated credential."
}

variable "github_environment" {
  type        = string
  default     = "integration"
  description = "GitHub Actions environment name in the federated credential subject."
}
