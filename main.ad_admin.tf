resource "azurerm_mysql_flexible_server_active_directory_administrator" "this" {
  count = var.active_directory_administrator != null ? 1 : 0 # if this variable is not null, then create this resource
  server_id   = azurerm_mysql_flexible_server.this.id 
  identity_id = var.active_directory_administrator.identity_id
  login       = var.active_directory_administrator.login
  object_id   = var.active_directory_administrator.object_id
  tenant_id   = var.active_directory_administrator.tenant_id
}
