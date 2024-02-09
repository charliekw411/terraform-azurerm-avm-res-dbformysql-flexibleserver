terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.91.0, < 4.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.0, < 4.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

# This ensures we have unique CAF compliant names for our resources.
module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.0"
}

# This is required for resource modules
resource "azurerm_resource_group" "this" {
  name     = module.naming.resource_group.name_unique
  location = "AustraliaEast"
}

# A vnet & subnet is required for the private endpoint.
resource "azurerm_virtual_network" "this" {
  name                = module.naming.virtual_network.name_unique
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = ["192.168.0.0/24"]
}

resource "azurerm_subnet" "this" {
  name                 = module.naming.subnet.name_unique
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["192.168.0.0/24"]
}

resource "azurerm_private_dns_zone" "this" {
  name                = "privatelink.mysql.database.azure.com"
  resource_group_name = azurerm_resource_group.this.name
}

resource "random_password" "admin_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

module "mysql_server" {
  source = "../../"
  # source             = "Azure/avm-<res/ptn>-<name>/azurerm"
  # ...
  enable_telemetry       = var.enable_telemetry # see variables.tf
  name                   = module.naming.mysql_server.name_unique
  resource_group_name    = azurerm_resource_group.this.name
  administrator_login    = "mysqladmin"
  administrator_password = random_password.admin_password.result
  sku_name               = "GP_Standard_D2ds_v4"

  private_endpoints = {
    primary = {
      private_dns_zone_resource_ids = [azurerm_private_dns_zone.this.id]
      subnet_resource_id            = azurerm_subnet.this.id
    }
  }
}

check "dns" {
  data "azurerm_private_dns_a_record" "assertion" {
    name                = module.naming.mysql_server.name_unique
    zone_name           = "privatelink.mysql.database.azure.com"
    resource_group_name = azurerm_resource_group.this.name
  }
  assert {
    condition     = one(data.azurerm_private_dns_a_record.assertion.records) == one(module.mysql_server.private_endpoints["primary"].private_service_connection).private_ip_address
    error_message = "The private DNS A record for the private endpoint is not correct."
  }
}
