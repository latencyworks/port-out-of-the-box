# integration environment
# Copy to integration.tfvars to get started.
# Set via TF_VAR_* (not this file): port_client_id, port_client_secret,
# hosting_subscription_id (CI: AZURE_SUBSCRIPTION_ID).

port_base_url = "https://api.us.port.io"
# Changing integration_identifier forces a lengthy destroy/recreate on next apply.
integration_identifier = "azure"

location = "East US 2"

initialize_port_resources = false
event_listener_type       = "POLLING"
scheduled_resync_interval = 1440

# Required for live-event workers. After first apply:
#   terraform output -raw container_app_fqdn_stable
# then set (https + FQDN, no path):
# ocean_base_url = "https://<container_app_fqdn_stable>"

# Existing long-running subscription: reuse a Microsoft.Resources.Subscriptions system topic
# event_grid_system_topic_name = "my-subscription-events"
# event_grid_resource_group    = "my-event-grid-rg"  # if topic is not in the integration RG
