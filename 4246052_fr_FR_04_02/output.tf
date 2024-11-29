
output "public_ip_address" {
  value = azurerm_linux_virtual_machine.web.public_ip_address
}

output "tls_private_key" {
  value     = tls_private_key.web.private_key_pem
  sensitive = true
}
