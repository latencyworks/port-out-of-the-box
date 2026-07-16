# One system topic per subscription. Type Microsoft.Resources.Subscriptions
# emits resource create/update/delete events for the whole subscription.
resource "azurerm_eventgrid_system_topic" "this" {
  name                   = "port-ocean-subscription-topic"
  resource_group_name    = var.event_grid_resource_group_name
  location               = "Global"
  topic_type             = "Microsoft.Resources.Subscriptions"
  source_arm_resource_id = "/subscriptions/${var.subscription_id}"
}

# Event Grid allows max 25 values per advanced filter, so split the resource list
# into chunks and create one subscription per chunk.
locals {
  filter_chunks = { for i, chunk in chunklist(var.resources_filter_values, 25) : i => chunk }
}

resource "azurerm_eventgrid_system_topic_event_subscription" "this" {
  for_each = local.filter_chunks

  name                = "port-ocean-subscription-${each.key}"
  resource_group_name = var.event_grid_resource_group_name
  system_topic        = azurerm_eventgrid_system_topic.this.name

  included_event_types  = var.included_event_types
  event_delivery_schema = "CloudEventSchemaV1_0"

  webhook_endpoint {
    url = var.webhook_url
  }

  advanced_filtering_on_arrays_enabled = true

  advanced_filter {
    string_contains {
      key    = "data.operationName"
      values = each.value
    }
  }

  delivery_property {
    header_name = "Access-Control-Request-Method"
    type        = "Static"
    value       = "POST"
  }

  delivery_property {
    header_name = "Origin"
    type        = "Static"
    value       = "azure"
  }
}
