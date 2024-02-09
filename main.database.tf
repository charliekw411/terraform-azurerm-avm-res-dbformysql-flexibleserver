resource "azurerm_mysql_flexible_database" "this" {
  for_each            = var.databases
  charset             = each.value.charset
  collation           = each.value.collation
  name                = each.value.name
  resource_group_name = azurerm_mysql_flexible_server.this.resource_group_name
  server_name         = azurerm_mysql_flexible_server.this.resource_group_name

}

