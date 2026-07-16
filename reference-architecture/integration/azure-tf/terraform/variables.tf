# ---------------------------------------------------------------------------
# Port
# ---------------------------------------------------------------------------

variable "port_client_id" {
  type        = string
  sensitive   = true
  description = "Port client id. Set via TF_VAR_port_client_id, not in tfvars."
}

variable "port_client_secret" {
  type        = string
  sensitive   = true
  description = "Port client secret. Set via TF_VAR_port_client_secret, not in tfvars."
}

variable "port_base_url" {
  type        = string
  default     = "https://api.us.port.io"
  description = "Port API URL. US: https://api.us.port.io, EU: https://api.port.io"
}

variable "integration_identifier" {
  type        = string
  default     = "azure"
  description = "Identifier for this integration in Port. Set once before the first apply — changing it forces a lengthy destroy/recreate of the Container App and related Azure resources."
}

variable "initialize_port_resources" {
  type        = bool
  default     = false
  description = "true = let the integration seed default blueprints and mappings. Keep false to manage them as code (see README)."
}

# ---------------------------------------------------------------------------
# Azure
# ---------------------------------------------------------------------------

variable "hosting_subscription_id" {
  type        = string
  description = "Subscription that hosts the Container App and its Event Grid topic. Set via TF_VAR_hosting_subscription_id (CI: AZURE_SUBSCRIPTION_ID), not in tfvars."
}

variable "location" {
  type        = string
  default     = "East US 2"
  description = "Azure region for the Container App."
}

variable "resource_group_name" {
  type        = string
  default     = null
  description = "Existing resource group to deploy into. Leave null to let the module create one."
}

variable "action_permissions_list" {
  type = list(string)
  default = [
    "Microsoft.Resources/subscriptions/read",
    "Microsoft.Resources/subscriptions/resourceGroups/read",
    "Microsoft.Resources/subscriptions/resources/read",
    "*/read",
  ]
  description = "Read permissions granted to the integration identity to export Azure resources."
}

# ---------------------------------------------------------------------------
# Live events (Event Grid)
# ---------------------------------------------------------------------------

variable "event_grid_system_topic_name" {
  type        = string
  default     = ""
  description = "Existing Event Grid system topic (Microsoft.Resources.Subscriptions) in the hosting subscription. Empty string = create a new topic."
}

variable "event_grid_resource_group" {
  type        = string
  default     = ""
  description = "Resource group of the Event Grid topic/subscriptions when it differs from the integration RG. Required when using an existing topic outside the module RG."
}

variable "resources_filter_values" {
  type = list(string)
  default = [
    "Microsoft.Resources/subscriptions/resourceGroups",
    "Microsoft.App/containerApps",
    "Microsoft.Storage/storageAccounts",
    "Microsoft.Compute/virtualMachines",
    "Microsoft.ContainerService/managedClusters",
    "Microsoft.Network/loadBalancers",
    "Microsoft.Network/virtualNetworks",
  ]
  description = "Resource types to receive live events for."
}

variable "included_event_types" {
  type = list(string)
  default = [
    "Microsoft.Resources.ResourceWriteSuccess",
    "Microsoft.Resources.ResourceDeleteSuccess",
  ]
  description = "Event Grid event types to forward to the integration."
}

variable "ocean_base_url" {
  type        = string
  default     = null
  description = "Public Container App URL (https://<fqdn>, no path). Required for live-event queue workers. Set after the first apply from the container_app_fqdn_stable output (see README)."
}

variable "event_listener_type" {
  type        = string
  default     = "POLLING"
  description = "Scheduled resync listener (POLLING). Live updates also need Event Grid delivery plus OCEAN__BASE_URL (ocean_base_url) so queue workers start."
}

variable "scheduled_resync_interval" {
  type        = number
  default     = 1440
  description = "Full catalog resync interval in minutes (Ocean OCEAN__SCHEDULED_RESYNC_INTERVAL). Default 1440 = once per day. Not the POLLING listener's ~60s check interval."
}
