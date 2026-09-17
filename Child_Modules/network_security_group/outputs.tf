output "nsg_output" {
  description = "Map of created Network Security Groups"
  value       = azurerm_network_security_group.nsg
}
