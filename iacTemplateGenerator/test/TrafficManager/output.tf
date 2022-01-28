output "traffic_manager_id" {
  value = azurerm_traffic_manager_profile.traffic_manager_profile.id
  description = "The ID of the traffic manager."
}

output "traffic_manager_fqdn" {
  value = azurerm_traffic_manager_profile.traffic_manager_profile.fqdn
  description = "The FQDN of the traffic manager."
}

output "traffic_manager_name" {
  value = azurerm_traffic_manager_profile.traffic_manager_profile.name
  description = "The Name of the traffic manager."
}
