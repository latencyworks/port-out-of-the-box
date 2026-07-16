output "system_topic_name" {
  description = "Name of the Event Grid system topic created for the subscription."
  value       = azurerm_eventgrid_system_topic.this.name
}
