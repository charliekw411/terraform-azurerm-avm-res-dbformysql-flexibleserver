# Module owners should include the full resource via a 'resource' output
# https://azure.github.io/Azure-Verified-Modules/specs/terraform/#id-tffr2---category-outputs---additional-terraform-outputs
output "resource" {
  value       = azurerm_mysql_flexible_server.this
  description = "This is the full output for the resource."
}

output "id" {
  description = "The ID of the resoure"
  value       = azurerm_mysql_flexible_server.this
}

output "name" {
  description = "The name of the rresource"
  value       = azurerm_mysql_flexible_server.this.id
}

output "private_endpoints" {
  value       = azurerm_private_endpoint.this
  description = "A map of private endpoints. The map key is the supplied input to var.private_endpoints. The map value is the entire azurerm_private_endpoint resource."
}
