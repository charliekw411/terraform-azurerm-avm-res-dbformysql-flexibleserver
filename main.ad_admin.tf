resource "azurerm_mysql_flexible_server_active_directory_administrator" "this" {
  count = var.active_directory_administrator == {} ? 0 : 1 # if this variable is empty, do not create the resource
  server_id   = azurerm_mysql_flexible_server.this.id
  identity_id = azurerm_mysql_flexible_server.this.identity[0]
  login       = var.active_directory_administrator.login
  object_id   = var.active_directory_administrator.object_id
  tenant_id   = var.active_directory_administrator.tenant_id
}
 