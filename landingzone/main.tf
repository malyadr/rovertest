provider "azurerm" {
  features {}
}
data  "azurerm_client_config"  "current"  {}
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_key_vault" "storage_key_vault" {
  name                        = var.key_name
  location                    = azurerm_resource_group.example.location
  resource_group_name         = azurerm_resource_group.example.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = var.keysku_name 
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create",
      "Delete",
      "Get",
      "List",
      "Purge",
      "Recover",
      "Update",
      "GetRotationPolicy",
      "SetRotationPolicy"
    ] 
    secret_permissions = [
      "Set",
      "List",
      "Get",
      "Delete",
      "Purge",
      "Recover"
    ]
 } 
}
resource "azurerm_key_vault_key" "example" {
  name         = var.keyvault_name
  key_vault_id = azurerm_key_vault.storage_key_vault.id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["encrypt", "decrypt", "sign", "verify"]
}
resource "azurerm_storage_account" "storage_account" {
  name                     = var.Storage_name
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = var.sku_name
  account_replication_type = var.replication_type

  taging = {
    name = "malyadri"
  }

} 

resource "azurerm_storage_container" "blob_container" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = var.container_access 
} 

resource "azurerm_storage_blob" "example" {
  name                   = "terraform.tfstate"
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = azurerm_storage_container.blob_container.name
  type                   = "Block"
  source                 = "./terraform.tfstate"
}

resource "azurerm_storage_encryption_scope" "blob_encryption" {
    storage_account_id = azurerm_storage_account.storage_account.id
    name = "default"
    source = "Microsoft.Storage"
    }
