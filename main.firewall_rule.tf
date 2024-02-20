resource "azurerm_mysql_flexible_server_firewall_rule" "this" {
  for_each            = var.firewall_rules
  name                = each.key
  server_name         = azurerm_mysql_flexible_server.this.name
  resource_group_name = azurerm_mysql_flexible_server.this.resource_group_name
  start_ip_address    = each.value.start_ip_address
  end_ip_address      = each.value.end_ip_address

  dynamic "timeouts" {
    for_each = each.value.timeouts == null ? [] : [each.value.timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
    }
  }
}
