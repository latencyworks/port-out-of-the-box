# Port Azure integration on Azure Container Apps.
# This module also creates the Event Grid System Topic + subscriptions for the
# hosting subscription, so live events work out of the box for that subscription.
module "azure" {
  source  = "port-labs/integration-factory/ocean//examples/azure_container_app_azure_integration"
  version = ">= 0.0.25"

  port_client_id     = var.port_client_id
  port_client_secret = var.port_client_secret
  port_base_url      = var.port_base_url

  initialize_port_resources = var.initialize_port_resources

  integration_type       = "azure"
  integration_identifier = var.integration_identifier

  event_listener = {
    type = var.event_listener_type
  }

  scheduled_resync_interval = var.scheduled_resync_interval

  hosting_subscription_id = var.hosting_subscription_id
  location                = var.location
  resource_group_name     = var.resource_group_name

  action_permissions_list = var.action_permissions_list
  resources_filter_values = var.resources_filter_values
  included_event_types    = var.included_event_types

  # Empty string = create a new topic (upstream default). Non-empty = reuse existing.
  event_grid_system_topic_name = var.event_grid_system_topic_name
  event_grid_resource_group    = var.event_grid_resource_group

  # Ocean only starts webhook queue workers when OCEAN__BASE_URL is set.
  # The upstream Azure module does not set this; apply once, then set
  # ocean_base_url from container_app_fqdn_stable and apply again (see README).
  additional_environment_variables = var.ocean_base_url != null ? {
    OCEAN__BASE_URL = var.ocean_base_url
  } : {}
}

# Ingest live events from a second subscription:
#   1. Uncomment the aliased provider in terraform.tf and set its subscription_id.
#   2. Uncomment this block.
# module "live_events_extra" {
#   source    = "./modules/subscription_live_events"
#   providers = { azurerm = azurerm.extra }
#
#   subscription_id                = "<other-subscription-id>"
#   event_grid_resource_group_name = module.azure.resource_group_name
#   webhook_url                    = "https://${module.azure.container_app_latest_fqdn}/integration/events"
#   resources_filter_values        = var.resources_filter_values
#   included_event_types           = var.included_event_types
# }

locals {
  # Upstream only exposes latest_revision_fqdn (…--abc1234.….azurecontainerapps.io).
  # Stable app hostname omits the revision segment.
  container_app_fqdn_stable = replace(
    module.azure.container_app_latest_fqdn,
    "/--[^.]+/",
    "",
  )
}

output "container_app_fqdn" {
  description = "Latest revision hostname (changes on every Container App update)."
  value       = module.azure.container_app_latest_fqdn
}

output "container_app_fqdn_stable" {
  description = "Stable app hostname (no revision suffix). Use for ocean_base_url."
  value       = local.container_app_fqdn_stable
}

output "live_events_webhook_url" {
  description = "Stable webhook URL for docs/operators. Upstream Event Grid may still use the revision FQDN."
  value       = "https://${local.container_app_fqdn_stable}/integration/events"
}
