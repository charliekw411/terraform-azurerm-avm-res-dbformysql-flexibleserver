resource "azurerm_user_assigned_identity" "this" {
  name                = "mysqladmin"
  resource_group_name = azurerm_mysql_flexible_server.this.resource_group_name
  location            = azurerm_mysql_flexible_server.this.location
}

resource "azurerm_mysql_flexible_server_active_directory_administrator" "this" {
  for_each = var.mysql_ad_administrators
  server_id   = azurerm_mysql_flexible_server.this[each.key].id # use [each.key] to dynamically reference the server and id values 
  identity_id = azurerm_user_assigned_identity.this[each.key].id # TODO: this might be wrong 
  login       = each.value.login
  object_id   = each.value.object_id
  tenant_id   = each.value.tenant_id
}
