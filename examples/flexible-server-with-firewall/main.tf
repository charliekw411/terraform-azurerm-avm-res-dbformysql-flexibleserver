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
  version = ">= 0.4.0"
}

# This is required for resource modules
resource "azurerm_resource_group" "this" {
  name     = module.naming.resource_group.name_unique
  location = "AustraliaEast"
}

resource "random_password" "admin_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# This is the module call
# Do not specify location here due to the randomization above.
# Leaving location as `null` will cause the module to use the resource group location
# with a data source.
module "mysql_server_with_firewall" {
  source = "../../"
  # source             = "Azure/avm-<res/ptn>-<name>/azurerm"
  # ...
  enable_telemetry       = var.enable_telemetry # see variables.tf
  name                   = module.naming.mysql_server.name_unique
  resource_group_name    = azurerm_resource_group.this.name
  administrator_login    = "mysqladmin"
  administrator_password = random_password.admin_password.result
  sku_name               = "GP_Standard_D2ds_v4"
  firewall_rules = {
    single_ip = {
      start_ip_address = "40.112.8.12"
      end_ip_address   = "40.112.8.12"
    }
    ip_range = {
      start_ip_address = "40.112.0.0"
      end_ip_address   = "40.112.255.255"
    }
    access_azure = {
      start_ip_address = "0.0.0.0"
      end_ip_address   = "0.0.0.0"
    }
  }
}
