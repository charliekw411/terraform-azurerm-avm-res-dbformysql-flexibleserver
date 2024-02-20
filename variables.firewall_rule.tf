variable "firewall_rules" {
  type = map(object({
    end_ip_address      = string
    name                = string
    resource_group_name = string
    server_name         = string
    start_ip_address    = string
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
  description = <<-EOT
 - `end_ip_address` - (Required) Specifies the End IP Address associated with this Firewall Rule.
 - `name` - (Required) Specifies the name of the MySQL Firewall Rule. Changing this forces a new resource to be created.
 - `resource_group_name` - (Required) The name of the resource group in which the MySQL Flexible Server exists. Changing this forces a new resource to be created.
 - `server_name` - (Required) Specifies the name of the MySQL Flexible Server. Changing this forces a new resource to be created.
 - `start_ip_address` - (Required) Specifies the Start IP Address associated with this Firewall Rule.

 ---
 `timeouts` block supports the following:
 - `create` - (Defaults to 30 minutes) Used when creating the MySQL Firewall Rule.
 - `delete` - (Defaults to 30 minutes) Used when deleting the MySQL Firewall Rule.
 - `read` - (Defaults to 5 minutes) Used when retrieving the MySQL Firewall Rule.
 - `update` - (Defaults to 30 minutes) Used when updating the MySQL Firewall Rule.
EOT
  default     = {}
}
