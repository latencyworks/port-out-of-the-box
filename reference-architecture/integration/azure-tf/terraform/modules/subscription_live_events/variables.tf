variable "subscription_id" {
  type        = string
  description = "Subscription to capture live events from."
}

variable "event_grid_resource_group_name" {
  type        = string
  description = "Resource group (in this subscription) to hold the Event Grid system topic."
}

variable "webhook_url" {
  type        = string
  description = "Integration events endpoint, e.g. https://<fqdn>/integration/events"
}

variable "resources_filter_values" {
  type        = list(string)
  description = "Resource types to receive live events for."
}

variable "included_event_types" {
  type        = list(string)
  description = "Event Grid event types to forward."
}
