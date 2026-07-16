data "azurerm_subscription" "current" {
  subscription_id = var.subscription_id
}

data "azuread_client_config" "current" {}

resource "azuread_application" "github" {
  display_name = var.application_display_name
}

resource "azuread_service_principal" "github" {
  client_id = azuread_application.github.client_id
}

# Matches: repo:<org>/<repo>:environment:<env>
resource "azuread_application_federated_identity_credential" "gha_deploy" {
  application_id = azuread_application.github.id
  display_name   = "gha-deploy"
  description    = "Allowing GHA from whitelisted repo/env combos"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  # Subject is environment-scoped only — GitHub's OIDC `sub` claim can't combine
  # `environment:` and `ref:` in one token when the job declares `environment:`.
  # Restrict which branches may use this environment via GitHub's Environment
  # "Deployment branches and tags" protection rule (see README: GitHub environment config).
  subject = "repo:${var.github_org}/${var.github_repo}:environment:${var.github_environment}"
}

# CI needs to create infra and assign roles to the Container App identity.
resource "azurerm_role_assignment" "contributor" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.github.object_id
}

# Built-in role definition IDs: https://learn.microsoft.com/azure/role-based-access-control/built-in-roles
locals {
  privileged_role_ids = {
    owner                           = "8e3af657-a8ff-443c-a75c-2fe8c4bcb635"
    user_access_administrator       = "18d7d88d-d35e-4fb5-a5c3-7773c20a72d9"
    role_based_access_control_admin = "f58310d9-a9f6-439a-9e8d-f62e7b41a168"
  }
}

# CI can assign roles at subscription scope (needed for the cataloging read role —
# see README) but is blocked from ever assigning itself or anyone the roles above.
resource "azurerm_role_assignment" "rbac_administrator" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Role Based Access Control Administrator"
  principal_id         = azuread_service_principal.github.object_id

  condition_version = "2.0"
  condition = join(" AND ", [
    "((!(ActionMatches{'Microsoft.Authorization/roleAssignments/write'})) OR (@Request[Microsoft.Authorization/roleAssignments:RoleDefinitionId] ForAnyOfAllValues:GuidNotEquals {${join(", ", values(local.privileged_role_ids))}}))",
    "((!(ActionMatches{'Microsoft.Authorization/roleAssignments/delete'})) OR (@Resource[Microsoft.Authorization/roleAssignments:RoleDefinitionId] ForAnyOfAllValues:GuidNotEquals {${join(", ", values(local.privileged_role_ids))}}))",
  ])
}

output "azure_client_id" {
  description = "GitHub variable AZURE_CLIENT_ID"
  value       = azuread_application.github.client_id
}

output "azure_tenant_id" {
  description = "GitHub variable AZURE_TENANT_ID"
  value       = data.azuread_client_config.current.tenant_id
}

output "azure_subscription_id" {
  description = "GitHub variable AZURE_SUBSCRIPTION_ID"
  value       = var.subscription_id
}
