resource "azurerm_mysql_flexible_server_active_directory_administrator" "this" {
  # only create the resource if the user has supplied parameters to var.active_directory_administrator.
  count = length(var.active_directory_administrator) == 1 ? 1 : 0

  server_id   = azurerm_mysql_flexible_server.this.id
  identity_id = azurerm_mysql_flexible_server.this.identity[0].identity_ids
  login       = var.active_directory_administrator.login
  object_id   = var.active_directory_administrator.object_id
  tenant_id   = var.active_directory_administrator.tenant_id
}
