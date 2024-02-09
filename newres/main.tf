resource "azurerm_mysql_flexible_database" "this" {
  charset             = var.mysql_flexible_database.charset
  collation           = var.mysql_flexible_database.collation
  name                = var.mysql_flexible_database.name
  resource_group_name = var.mysql_flexible_database.resource_group_name
  server_name         = var.mysql_flexible_database.server_name

  dynamic "timeouts" {
    for_each = var.mysql_flexible_database.timeouts == null ? [] : [var.mysql_flexible_database.timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
    }
  }
}

