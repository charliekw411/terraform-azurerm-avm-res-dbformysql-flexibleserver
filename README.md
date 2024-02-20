<!-- BEGIN_TF_DOCS -->
# terraform-azurerm-res-dbformysql-flexibleserver

This is a Terraform module for the MySQL Flexible Server written for contribution to Azure Verified Modules.  For official modules please see <https://aka.ms/AVM>.

> [!IMPORTANT]
> As the overall AVM framework is not GA (generally available) yet - the CI framework and test automation is not fully functional and implemented across all supported languages yet - breaking changes are expected, and additional customer feedback is yet to be gathered and incorporated. Hence, modules **MUST NOT** be published at version `1.0.0` or higher at this time.
>
> All module **MUST** be published as a pre-release version (e.g., `0.1.0`, `0.1.1`, `0.2.0`, etc.) until the AVM framework becomes GA.
>
> However, it is important to note that this **DOES NOT** mean that the modules cannot be consumed and utilized. They **CAN** be leveraged in all types of environments (dev, test, prod etc.). Consumers can treat them just like any other IaC module and raise issues or feature requests against them as they learn from the usage of the module. Consumers should also read the release notes for each version, if considering updating to a more recent version of a module to see if there are any considerations or breaking changes etc.

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.3.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (>= 3.91.0, < 4.0.0)

- <a name="requirement_random"></a> [random](#requirement\_random) (>= 3.6.0, < 4.0.0)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (>= 3.91.0, < 4.0.0)

- <a name="provider_random"></a> [random](#provider\_random) (>= 3.6.0, < 4.0.0)

## Resources

The following resources are used by this module:

- [azurerm_management_lock.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) (resource)
- [azurerm_mysql_flexible_database.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_database) (resource)
- [azurerm_mysql_flexible_server.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server) (resource)
- [azurerm_mysql_flexible_server_active_directory_administrator.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server_active_directory_administrator) (resource)
- [azurerm_mysql_flexible_server_firewall_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server_firewall_rule) (resource)
- [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) (resource)
- [azurerm_private_endpoint_application_security_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint_application_security_group_association) (resource)
- [azurerm_resource_group_template_deployment.telemetry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_template_deployment) (resource)
- [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) (resource)
- [random_id.telem](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) (resource)
- [azurerm_resource_group.parent](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) (data source)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_name"></a> [name](#input\_name)

Description: The name of the resource.

Type: `string`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: The resource group where the resources will be deployed.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_active_directory_administrator"></a> [active\_directory\_administrator](#input\_active\_directory\_administrator)

Description: - `identity_id` - (Required) The resource ID of the identity used for AAD Authentication.
- `login` - (Required) The login name of the principal to set as the server administrator.
- `object_id` - (Required) The ID of the principal to set as the server administrator. For a managed identity, this should be the Client ID of the identity.
- `tenant_id` - (Required) The Azure Tenant ID.

---
`timeouts` block supports the following:
- `create` - (Defaults to 30 minutes) Used when creating the MySQL Flexible Server Active Directory Administrator.
- `read` - (Defaults to 5 minutes) Used when retrieving the MySQL Flexible Server Active Directory Administrator.
- `update` - (Defaults to 30 minutes) Used when updating the MySQL Flexible Server Active Directory Administrator.
- `delete` - (Defaults to 30 minutes) Used when deleting the MySQL Flexible Server Active Directory Administrator.

Type:

```hcl
object({
    login     = optional(string)
    object_id = optional(string)
    tenant_id = optional(string)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  })
```

Default: `{}`

### <a name="input_administrator_login"></a> [administrator\_login](#input\_administrator\_login)

Description: (Optional) The Administrator login for the MySQL Flexible Server. Required when `create_mode` is `Default`. Changing this forces a new MySQL Flexible Server to be created.

Type: `string`

Default: `null`

### <a name="input_administrator_password"></a> [administrator\_password](#input\_administrator\_password)

Description: (Optional) The Password associated with the `administrator_login` for the MySQL Flexible Server. Required when `create_mode` is `Default`.

Type: `string`

Default: `null`

### <a name="input_backup_retention_days"></a> [backup\_retention\_days](#input\_backup\_retention\_days)

Description: (Optional) The backup retention days for the MySQL Flexible Server. Possible values are between `1` and `35` days. Defaults to `7`.

Type: `number`

Default: `null`

### <a name="input_create_mode"></a> [create\_mode](#input\_create\_mode)

Description: (Optional)The creation mode which can be used to restore or replicate existing servers. Possible values are `Default`, `PointInTimeRestore`, `GeoRestore`, and `Replica`. Changing this forces a new MySQL Flexible Server to be created.

Type: `string`

Default: `null`

### <a name="input_customer_managed_key"></a> [customer\_managed\_key](#input\_customer\_managed\_key)

Description: - `geo_backup_key_vault_key_id` - (Optional) The ID of the geo backup Key Vault Key. It can't cross region and need Customer Managed Key in same region as geo backup.
- `geo_backup_user_assigned_identity_id` - (Optional) The geo backup user managed identity id for a Customer Managed Key. Should be added with `identity_ids`. It can't cross region and need identity in same region as geo backup.
- `key_vault_key_id` - (Optional) The ID of the Key Vault Key.
- `primary_user_assigned_identity_id` - (Optional) Specifies the primary user managed identity id for a Customer Managed Key. Should be added with `identity_ids`.

Type:

```hcl
object({
    geo_backup_key_vault_key_id          = optional(string)
    geo_backup_user_assigned_identity_id = optional(string)
    key_vault_key_id                     = optional(string)
    primary_user_assigned_identity_id    = optional(string)
  })
```

Default: `null`

### <a name="input_databases"></a> [databases](#input\_databases)

Description: - `charset` - (Required) Specifies the Charset for the MySQL Database, which needs [to be a valid MySQL Charset](https://dev.mysql.com/doc/refman/5.7/en/charset-charsets.html). Changing this forces a new resource to be created.
- `collation` - (Required) Specifies the Collation for the MySQL Database, which needs [to be a valid MySQL Collation](https://dev.mysql.com/doc/refman/5.7/en/charset-mysql.html). Changing this forces a new resource to be created.
- `name` - (Required) Specifies the name of the MySQL Database, which needs [to be a valid MySQL identifier](https://dev.mysql.com/doc/refman/5.7/en/identifiers.html). Changing this forces a new resource to be created.

---
`timeouts` block supports the following:
- `create` - (Defaults to 60 minutes) Used when creating the MySQL Database.
- `delete` - (Defaults to 60 minutes) Used when deleting the MySQL Database.
- `read` - (Defaults to 5 minutes) Used when retrieving the MySQL Database.

Type:

```hcl
map(object({
    charset   = string
    collation = string
    name      = string
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
    }))
  }))
```

Default: `{}`

### <a name="input_delegated_subnet_id"></a> [delegated\_subnet\_id](#input\_delegated\_subnet\_id)

Description: (Optional) The ID of the virtual network subnet to create the MySQL Flexible Server. Changing this forces a new MySQL Flexible Server to be created.

Type: `string`

Default: `null`

### <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings)

Description: A map of diagnostic settings to create on the Key Vault. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

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

Type:

```hcl
map(object({
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
```

Default: `{}`

### <a name="input_enable_telemetry"></a> [enable\_telemetry](#input\_enable\_telemetry)

Description: This variable controls whether or not telemetry is enabled for the module.  
For more information see <https://aka.ms/avm/telemetryinfo>.  
If it is set to false, then no telemetry will be collected.

Type: `bool`

Default: `true`

### <a name="input_firewall_rules"></a> [firewall\_rules](#input\_firewall\_rules)

Description: - `end_ip_address` - (Required) Specifies the End IP Address associated with this Firewall Rule.
- `start_ip_address` - (Required) Specifies the Start IP Address associated with this Firewall Rule.

---
`timeouts` block supports the following:
- `create` - (Defaults to 30 minutes) Used when creating the MySQL Firewall Rule.
- `delete` - (Defaults to 30 minutes) Used when deleting the MySQL Firewall Rule.
- `read` - (Defaults to 5 minutes) Used when retrieving the MySQL Firewall Rule.
- `update` - (Defaults to 30 minutes) Used when updating the MySQL Firewall Rule.

Type:

```hcl
map(object({
    end_ip_address   = string
    start_ip_address = string
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
```

Default: `{}`

### <a name="input_geo_redundant_backup_enabled"></a> [geo\_redundant\_backup\_enabled](#input\_geo\_redundant\_backup\_enabled)

Description: (Optional) Should geo redundant backup enabled? Defaults to `false`. Changing this forces a new MySQL Flexible Server to be created.

Type: `bool`

Default: `null`

### <a name="input_high_availability"></a> [high\_availability](#input\_high\_availability)

Description: - `mode` - (Required) The high availability mode for the MySQL Flexible Server. Possibles values are `SameZone` and `ZoneRedundant`.
- `standby_availability_zone` - (Optional) Specifies the Availability Zone in which the standby Flexible Server should be located. Possible values are `1`, `2` and `3`.

Type:

```hcl
object({
    mode                      = string
    standby_availability_zone = optional(string)
  })
```

Default: `null`

### <a name="input_identity"></a> [identity](#input\_identity)

Description: - `identity_ids` - (Required) A list of User Assigned Managed Identity IDs to be assigned to this MySQL Flexible Server.
- `type` - (Required) Specifies the type of Managed Service Identity that should be configured on this MySQL Flexible Server. The only possible value is `UserAssigned`.

Type:

```hcl
object({
    identity_ids = set(string)
    type         = string
  })
```

Default: `null`

### <a name="input_location"></a> [location](#input\_location)

Description: Azure region where the resource should be deployed.  If null, the location will be inferred from the resource group location.

Type: `string`

Default: `null`

### <a name="input_lock"></a> [lock](#input\_lock)

Description: The lock level to apply. Default is `None`. Possible values are `None`, `CanNotDelete`, and `ReadOnly`.

Type:

```hcl
object({
    name = optional(string, null)
    kind = optional(string, "None")
  })
```

Default: `{}`

### <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window)

Description: - `day_of_week` - (Optional) The day of week for maintenance window. Defaults to `0`.
- `start_hour` - (Optional) The start hour for maintenance window. Defaults to `0`.
- `start_minute` - (Optional) The start minute for maintenance window. Defaults to `0`.

Type:

```hcl
object({
    day_of_week  = optional(number)
    start_hour   = optional(number)
    start_minute = optional(number)
  })
```

Default: `null`

### <a name="input_managed_identities"></a> [managed\_identities](#input\_managed\_identities)

Description: Managed identities to be created for the resource.

Type:

```hcl
object({
    system_assigned            = optional(bool, false)
    user_assigned_resource_ids = optional(set(string), [])
  })
```

Default: `{}`

### <a name="input_mysql_version"></a> [mysql\_version](#input\_mysql\_version)

Description: (Optional) The version of the MySQL Flexible Server to use. Possible values are `5.7`, and `8.0.21`. Changing this forces a new MySQL Flexible Server to be created.

Type: `string`

Default: `null`

### <a name="input_point_in_time_restore_time_in_utc"></a> [point\_in\_time\_restore\_time\_in\_utc](#input\_point\_in\_time\_restore\_time\_in\_utc)

Description: (Optional) The point in time to restore from `creation_source_server_id` when `create_mode` is `PointInTimeRestore`. Changing this forces a new MySQL Flexible Server to be created.

Type: `string`

Default: `null`

### <a name="input_private_dns_zone_id"></a> [private\_dns\_zone\_id](#input\_private\_dns\_zone\_id)

Description: (Optional) The ID of the private DNS zone to create the MySQL Flexible Server. Changing this forces a new MySQL Flexible Server to be created.

Type: `string`

Default: `null`

### <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints)

Description: A map of private endpoints to create on this resource. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

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

Type:

```hcl
map(object({
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
```

Default: `{}`

### <a name="input_replication_role"></a> [replication\_role](#input\_replication\_role)

Description: (Optional) The replication role. Possible value is `None`.

Type: `string`

Default: `null`

### <a name="input_role_assignments"></a> [role\_assignments](#input\_role\_assignments)

Description: A map of role assignments to create on this resource. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `role_definition_id_or_name` - The ID or name of the role definition to assign to the principal.
- `principal_id` - The ID of the principal to assign the role to.
- `description` - The description of the role assignment.
- `skip_service_principal_aad_check` - If set to true, skips the Azure Active Directory check for the service principal in the tenant. Defaults to false.
- `condition` - The condition which will be used to scope the role assignment.
- `condition_version` - The version of the condition syntax. Valid values are '2.0'.

> Note: only set `skip_service_principal_aad_check` to true if you are assigning a role to a service principal.

Type:

```hcl
map(object({
    role_definition_id_or_name             = string
    principal_id                           = string
    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    delegated_managed_identity_resource_id = optional(string, null)
  }))
```

Default: `{}`

### <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name)

Description: (Optional) The SKU Name for the MySQL Flexible Server.

Type: `string`

Default: `null`

### <a name="input_source_server_id"></a> [source\_server\_id](#input\_source\_server\_id)

Description: (Optional)The resource ID of the source MySQL Flexible Server to be restored. Required when `create_mode` is `PointInTimeRestore`, `GeoRestore`, and `Replica`. Changing this forces a new MySQL Flexible Server to be created.

Type: `string`

Default: `null`

### <a name="input_storage"></a> [storage](#input\_storage)

Description: - `auto_grow_enabled` - (Optional) Should Storage Auto Grow be enabled? Defaults to `true`.
- `io_scaling_enabled` - (Optional) Should IOPS be scaled automatically? If `true`, `iops` can not be set. Defaults to `false`.
- `iops` - (Optional) The storage IOPS for the MySQL Flexible Server. Possible values are between `360` and `20000`.
- `size_gb` - (Optional) The max storage allowed for the MySQL Flexible Server. Possible values are between `20` and `16384`.

Type:

```hcl
object({
    auto_grow_enabled  = optional(bool)
    io_scaling_enabled = optional(bool)
    iops               = optional(number)
    size_gb            = optional(number)
  })
```

Default: `null`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: (Optional) A mapping of tags which should be assigned to the MySQL Flexible Server.

Type: `map(any)`

Default: `{}`

### <a name="input_timeouts"></a> [timeouts](#input\_timeouts)

Description: - `create` - (Defaults to 1 hour) Used when creating the MySQL Flexible Server.
- `delete` - (Defaults to 1 hour) Used when deleting the MySQL Flexible Server.
- `read` - (Defaults to 5 minutes) Used when retrieving the MySQL Flexible Server.
- `update` - (Defaults to 1 hour) Used when updating the MySQL Flexible Server.

Type:

```hcl
object({
    create = optional(string)
    delete = optional(string)
    read   = optional(string)
    update = optional(string)
  })
```

Default: `null`

### <a name="input_zone"></a> [zone](#input\_zone)

Description: (Optional) Specifies the Availability Zone in which this MySQL Flexible Server should be located. Possible values are `1`, `2` and `3`.

Type: `string`

Default: `null`

## Outputs

The following outputs are exported:

### <a name="output_id"></a> [id](#output\_id)

Description: The ID of the resoure

### <a name="output_name"></a> [name](#output\_name)

Description: The name of the rresource

### <a name="output_private_endpoints"></a> [private\_endpoints](#output\_private\_endpoints)

Description: A map of private endpoints. The map key is the supplied input to var.private\_endpoints. The map value is the entire azurerm\_private\_endpoint resource.

### <a name="output_resource"></a> [resource](#output\_resource)

Description: This is the full output for the resource.

## Modules

No modules.

<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->