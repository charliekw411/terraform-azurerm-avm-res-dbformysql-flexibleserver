variable "mysql_ad_administrators" {
  type = map(object({
    server_id   = string
    identity_id = string
    login       = string
    object_id   = string
    tenant_id   = string
    timeouts    = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  description = <<-EOT
 - `server_id` - (Required) The resource ID of the MySQL Flexible Server. Changing this forces a new resource to be created.
 - `identity_id` - (Required) The resource ID of the identity used for AAD Authentication.
 - `login` - (Required) The login name of the principal to set as the server administrator.
 - `object_id` - (Required) The ID of the principal to set as the server administrator. For a managed identity, this should be the Client ID of the identity.
 - `tenant_id` - (Required) The Azure Tenant ID.

 ---
 `timeouts` block supports the following:
 - `create` - (Defaults to 30 minutes) Used when creating the MySQL Flexible Server Active Directory Administrator.
 - `read` - (Defaults to 5 minutes) Used when retrieving the MySQL Flexible Server Active Directory Administrator.
 - `update` - (Defaults to 30 minutes) Used when updating the MySQL Flexible Server Active Directory Administrator.
 - `delete` - (Defaults to 30 minutes) Used when deleting the MySQL Flexible Server Active Directory Administrator.
EOT
  default     = {}
}

