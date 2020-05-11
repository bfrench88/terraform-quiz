output "win_agent-fqdn" {
  value = azurerm_public_ip.vm-winagent.*.fqdn
}

output "subnet_id" {
  value = azurerm_subnet.vs-buildgent.id
}