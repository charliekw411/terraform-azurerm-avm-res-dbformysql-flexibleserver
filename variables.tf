variable "administrator_login" {
  type        = string
  default     = null
  description = "(Optional) The Administrator login for the MySQL Flexible Server. Required when `create_mode` is `Default`. Changing this forces a new MySQL Flexible Server to be created."
}

variable "administrator_password" {
  type        = string
  default     = null
  description = "(Optional) The Password associated with the `administrator_login` for the MySQL Flexible Server. Required when `create_mode` is `Default`."
  sensitive   = true
}

variable "backup_retention_days" {
  type        = number
  default     = null
  description = "(Optional) The backup retention days for the MySQL Flexible Server. Possible values are between `1` and `35` days. Defaults to `7`."
}

variable "create_mode" {
  type        = string
  default     = null
  description = "(Optional)The creation mode which can be used to restore or replicate existing servers. Possible values are `Default`, `PointInTimeRestore`, `GeoRestore`, and `Replica`. Changing this forces a new MySQL Flexible Server to be created."
}

variable "customer_managed_key" {
  type = object({
    geo_backup_key_vault_key_id          = optional(string)
    geo_backup_user_assigned_identity_id = optional(string)
    key_vault_key_id                     = optional(string)
    primary_user_assigned_identity_id    = optional(string)
  })
  default     = null
  description = <<-EOT
 - `geo_backup_key_vault_key_id` - (Optional) The ID of the geo backup Key Vault Key. It can't cross region and need Customer Managed Key in same region as geo backup.
 - `geo_backup_user_assigned_identity_id` - (Optional) The geo backup user managed identity id for a Customer Managed Key. Should be added with `identity_ids`. It can't cross region and need identity in same region as geo backup.
 - `key_vault_key_id` - (Optional) The ID of the Key Vault Key.
 - `primary_user_assigned_identity_id` - (Optional) Specifies the primary user managed identity id for a Customer Managed Key. Should be added with `identity_ids`.
EOT
}

variable "identity" {
  type = object({
    identity_ids = set(string)
    type         = string
  })
  default     = null
  description = <<-EOT
 - `identity_ids` - (Required) A list of User Assigned Managed Identity IDs to be assigned to this MySQL Flexible Server.
 - `type` - (Required) Specifies the type of Managed Service Identity that should be configured on this MySQL Flexible Server. The only possible value is `UserAssigned`.
EOT
}

variable "delegated_subnet_id" {
  type        = string
  default     = null
  description = "(Optional) The ID of the virtual network subnet to create the MySQL Flexible Server. Changing this forces a new MySQL Flexible Server to be created."
}

variable "geo_redundant_backup_enabled" {
  type        = bool
  default     = null
  description = "(Optional) Should geo redundant backup enabled? Defaults to `false`. Changing this forces a new MySQL Flexible Server to be created."
}

variable "high_availability" {
  type = object({
    mode                      = string
    standby_availability_zone = optional(string)
  })
  default     = null
  description = <<-EOT
 - `mode` - (Required) The high availability mode for the MySQL Flexible Server. Possibles values are `SameZone` and `ZoneRedundant`.
 - `standby_availability_zone` - (Optional) Specifies the Availability Zone in which the standby Flexible Server should be located. Possible values are `1`, `2` and `3`.
EOT
}

variable "maintenance_window" {
  type = object({
    day_of_week  = optional(number)
    start_hour   = optional(number)
    start_minute = optional(number)
  })
  default     = null
  description = <<-EOT
 - `day_of_week` - (Optional) The day of week for maintenance window. Defaults to `0`.
 - `start_hour` - (Optional) The start hour for maintenance window. Defaults to `0`.
 - `start_minute` - (Optional) The start minute for maintenance window. Defaults to `0`.
EOT
}

variable "point_in_time_restore_time_in_utc" {
  type        = string
  default     = null
  description = "(Optional) The point in time to restore from `creation_source_server_id` when `create_mode` is `PointInTimeRestore`. Changing this forces a new MySQL Flexible Server to be created."
}

variable "private_dns_zone_id" {
  type        = string
  default     = null
  description = "(Optional) The ID of the private DNS zone to create the MySQL Flexible Server. Changing this forces a new MySQL Flexible Server to be created."
}

variable "replication_role" {
  type        = string
  default     = null
  description = "(Optional) The replication role. Possible value is `None`."
}

variable "sku_name" {
  type        = string
  default     = null
  description = "(Optional) The SKU Name for the MySQL Flexible Server."
}

variable "source_server_id" {
  type        = string
  default     = null
  description = "(Optional)The resource ID of the source MySQL Flexible Server to be restored. Required when `create_mode` is `PointInTimeRestore`, `GeoRestore`, and `Replica`. Changing this forces a new MySQL Flexible Server to be created."
}

variable "storage" {
  type = object({
    auto_grow_enabled  = optional(bool)
    io_scaling_enabled = optional(bool)
    iops               = optional(number)
    size_gb            = optional(number)
  })
  default     = null
  description = <<-EOT
 - `auto_grow_enabled` - (Optional) Should Storage Auto Grow be enabled? Defaults to `true`.
 - `io_scaling_enabled` - (Optional) Should IOPS be scaled automatically? If `true`, `iops` can not be set. Defaults to `false`.
 - `iops` - (Optional) The storage IOPS for the MySQL Flexible Server. Possible values are between `360` and `20000`.
 - `size_gb` - (Optional) The max storage allowed for the MySQL Flexible Server. Possible values are between `20` and `16384`.
EOT
}

variable "timeouts" {
  type = object({
    create = optional(string)
    delete = optional(string)
    read   = optional(string)
    update = optional(string)
  })
  default     = null
  description = <<-EOT
 - `create` - (Defaults to 1 hour) Used when creating the MySQL Flexible Server.
 - `delete` - (Defaults to 1 hour) Used when deleting the MySQL Flexible Server.
 - `read` - (Defaults to 5 minutes) Used when retrieving the MySQL Flexible Server.
 - `update` - (Defaults to 1 hour) Used when updating the MySQL Flexible Server.
EOT
}

variable "mysql_version" {
  type        = string
  default     = null
  description = "(Optional) The version of the MySQL Flexible Server to use. Possible values are `5.7`, and `8.0.21`. Changing this forces a new MySQL Flexible Server to be created."
}

variable "zone" {
  type        = string
  default     = null
  description = "(Optional) Specifies the Availability Zone in which this MySQL Flexible Server should be located. Possible values are `1`, `2` and `3`."
}

variable "enable_telemetry" {
  type        = bool
  default     = true
  description = <<DESCRIPTION
This variable controls whether or not telemetry is enabled for the module.
For more information see <https://aka.ms/avm/telemetryinfo>.
If it is set to false, then no telemetry will be collected.
DESCRIPTION
}

# This is required for most resource modules
variable "resource_group_name" {
  type        = string
  description = "The resource group where the resources will be deployed."
}

variable "location" {
  type        = string
  description = "Azure region where the resource should be deployed.  If null, the location will be inferred from the resource group location."
  default     = null
}

variable "name" {
  type        = string
  description = "The name of the resource."
  validation {
    condition     = can(regex("^[a-z0-9-]{3,63}$", var.name))
    error_message = "The name must be between 3 and 63 characters long and can only contain lowercase letters, numbers and dashes."
  }
}

variable "diagnostic_settings" {
  type = map(object({
    name                                     = optional(string, null)
    log_categories                           = optional(set(string), [])
    log_groups                               = optional(set(string), ["allLogs"])
    metric_categories                        = optional(set(string), ["AllMetrics"])
    log_analytics_destination_type           = optional(string, "Dedicated")
    workspace_resource_id                    = optional(string, null)
    storage_account_resource_id              = optional(string, null)
    event_hub_authorization_rule_resource_id = optional(string, null)
    event_hub_name                           = optional(string, null)
    marketplace_partner_resource_id          = optional(string, null)
  }))
  default  = {}
  nullable = false

  validation {
    condition     = alltrue([for _, v in var.diagnostic_settings : contains(["Dedicated", "AzureDiagnostics"], v.log_analytics_destination_type)])
    error_message = "Log analytics destination type must be one of: 'Dedicated', 'AzureDiagnostics'."
  }
  validation {
    condition = alltrue(
      [
        for _, v in var.diagnostic_settings :
        v.workspace_resource_id != null || v.storage_account_resource_id != null || v.event_hub_authorization_rule_resource_id != null || v.marketplace_partner_resource_id != null
      ]
    )
    error_message = "At least one of `workspace_resource_id`, `storage_account_resource_id`, `marketplace_partner_resource_id`, or `event_hub_authorization_rule_resource_id`, must be set."
  }
  description = <<DESCRIPTION
A map of diagnostic settings to create on the Key Vault. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `name` - (Optional) The name of the diagnostic setting. One will be generated if not set, however this will not be unique if you want to create multiple diagnostic setting resources.
- `log_categories` - (Optional) A set of log categories to send to the log analytics workspace. Defaults to `[]`.
- `log_groups` - (Optional) A set of log groups to send to the log analytics workspace. Defaults to `["allLogs"]`.
- `metric_categories` - (Optional) A set of metric categories to send to the log analytics workspace. Defaults to `["AllMetrics"]`.
- `log_analytics_destination_type` - (Optional) The destination type for the diagnostic setting. Possible values are `Dedicated` and `AzureDiagnostics`. Defaults to `Dedicated`.
- `workspace_resource_id` - (Optional) The resource ID of the log analytics workspace to send logs and metrics to.
- `storage_account_resource_id` - (Optional) The resource ID of the storage account to send logs and metrics to.
- `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the event hub authorization rule to send logs and metrics to.
- `event_hub_name` - (Optional) The name of the event hub. If none is specified, the default event hub will be selected.
- `marketplace_partner_resource_id` - (Optional) The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic LogsLogs.
DESCRIPTION
}

variable "lock" {
  type = object({
    name = optional(string, null)
    kind = optional(string, "None")
  })
  description = "The lock level to apply. Default is `None`. Possible values are `None`, `CanNotDelete`, and `ReadOnly`."
  default     = {}
  nullable    = false
  validation {
    condition     = contains(["CanNotDelete", "ReadOnly", "None"], var.lock.kind)
    error_message = "The lock level must be one of: 'None', 'CanNotDelete', or 'ReadOnly'."
  }
}

# tflint-ignore: terraform_unused_declarations
variable "managed_identities" {
  type = object({
    system_assigned            = optional(bool, false)
    user_assigned_resource_ids = optional(set(string), [])
  })
  description = "Managed identities to be created for the resource."
  default     = {}
}

variable "private_endpoints" {
  type = map(object({
    name = optional(string, null)
    role_assignments = optional(map(object({
      role_definition_id_or_name             = string
      principal_id                           = string
      description                            = optional(string, null)
      skip_service_principal_aad_check       = optional(bool, false)
      condition                              = optional(string, null)
      condition_version                      = optional(string, null)
      delegated_managed_identity_resource_id = optional(string, null)
    })), {})
    lock = optional(object({
      name = optional(string, null)
      kind = optional(string, "None")
    }), {})
    tags                                    = optional(map(any), null)
    subnet_resource_id                      = string
    private_dns_zone_group_name             = optional(string, "default")
    private_dns_zone_resource_ids           = optional(set(string), [])
    application_security_group_associations = optional(map(string), {})
    private_service_connection_name         = optional(string, null)
    network_interface_name                  = optional(string, null)
    location                                = optional(string, null)
    resource_group_name                     = optional(string, null)
    ip_configurations = optional(map(object({
      name               = string
      private_ip_address = string
    })), {})
  }))
  default     = {}
  description = <<DESCRIPTION
A map of private endpoints to create on this resource. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `name` - (Optional) The name of the private endpoint. One will be generated if not set.
- `role_assignments` - (Optional) A map of role assignments to create on the private endpoint. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time. See `var.role_assignments` for more information.
- `lock` - (Optional) The lock level to apply to the private endpoint. Default is `None`. Possible values are `None`, `CanNotDelete`, and `ReadOnly`.
- `tags` - (Optional) A mapping of tags to assign to the private endpoint.
- `subnet_resource_id` - The resource ID of the subnet to deploy the private endpoint in.
- `private_dns_zone_group_name` - (Optional) The name of the private DNS zone group. One will be generated if not set.
- `private_dns_zone_resource_ids` - (Optional) A set of resource IDs of private DNS zones to associate with the private endpoint. If not set, no zone groups will be created and the private endpoint will not be associated with any private DNS zones. DNS records must be managed external to this module.
- `application_security_group_resource_ids` - (Optional) A map of resource IDs of application security groups to associate with the private endpoint. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.
- `private_service_connection_name` - (Optional) The name of the private service connection. One will be generated if not set.
- `network_interface_name` - (Optional) The name of the network interface. One will be generated if not set.
- `location` - (Optional) The Azure location where the resources will be deployed. Defaults to the location of the resource group.
- `resource_group_name` - (Optional) The resource group where the resources will be deployed. Defaults to the resource group of this resource.
- `ip_configurations` - (Optional) A map of IP configurations to create on the private endpoint. If not specified the platform will create one. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.
  - `name` - The name of the IP configuration.
  - `private_ip_address` - The private IP address of the IP configuration.
DESCRIPTION
}

variable "role_assignments" {
  type = map(object({
    role_definition_id_or_name             = string
    principal_id                           = string
    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    delegated_managed_identity_resource_id = optional(string, null)
  }))
  default     = {}
  description = <<DESCRIPTION
A map of role assignments to create on this resource. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `role_definition_id_or_name` - The ID or name of the role definition to assign to the principal.
- `principal_id` - The ID of the principal to assign the role to.
- `description` - The description of the role assignment.
- `skip_service_principal_aad_check` - If set to true, skips the Azure Active Directory check for the service principal in the tenant. Defaults to false.
- `condition` - The condition which will be used to scope the role assignment.
- `condition_version` - The version of the condition syntax. Valid values are '2.0'.

> Note: only set `skip_service_principal_aad_check` to true if you are assigning a role to a service principal.
DESCRIPTION
}

# tflint-ignore: terraform_unused_declarations
variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags which should be assigned to the MySQL Flexible Server."
  default     = {}
}

