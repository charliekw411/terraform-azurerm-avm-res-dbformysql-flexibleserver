resource "azurerm_mysql_flexible_server_firewall_rule" "this" {
  for_each            = var.firewall_rules
  name                = each.value.name
  server_name         = azurerm_mysql_flexible_server.this.name
  resource_group_name = azurerm_mysql_flexible_server.this.resource_group_name
  start_ip_address    = "40.112.0.0"     # can be modified to target a single ip address or a range
  end_ip_address      = "40.112.255.255" #TODO: should it target single, range or 0.0.0.0 to allow access to Azure services?

  dynamic "timeouts" {
    for_each = each.value.timeouts == null ? [] : [each.value.timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
    }
  }
}
