output "public_ip_output" {
  description = "Map of created public IPs"
  value       = azurerm_public_ip.pip
}
