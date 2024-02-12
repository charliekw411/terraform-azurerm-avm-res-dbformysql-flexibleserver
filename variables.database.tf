variable "databases" {
  type = map(object({
    charset   = string
    collation = string
    name      = string
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
    }))
  }))
  description = <<-EOT
 - `charset` - (Required) Specifies the Charset for the MySQL Database, which needs [to be a valid MySQL Charset](https://dev.mysql.com/doc/refman/5.7/en/charset-charsets.html). Changing this forces a new resource to be created.
 - `collation` - (Required) Specifies the Collation for the MySQL Database, which needs [to be a valid MySQL Collation](https://dev.mysql.com/doc/refman/5.7/en/charset-mysql.html). Changing this forces a new resource to be created.
 - `name` - (Required) Specifies the name of the MySQL Database, which needs [to be a valid MySQL identifier](https://dev.mysql.com/doc/refman/5.7/en/identifiers.html). Changing this forces a new resource to be created.

 ---
 `timeouts` block supports the following:
 - `create` - (Defaults to 60 minutes) Used when creating the MySQL Database.
 - `delete` - (Defaults to 60 minutes) Used when deleting the MySQL Database.
 - `read` - (Defaults to 5 minutes) Used when retrieving the MySQL Database.
EOT
  default     = {}
}
