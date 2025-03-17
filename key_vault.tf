ephemeral "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "example" {
  name                      = "ephemeral-key-vault"
  location                  = azurerm_resource_group.example.location
  resource_group_name       = azurerm_resource_group.example.name
  tenant_id                 = data.azurerm_client_config.current.tenant_id
  sku_name                  = "standard"
  enable_rbac_authorization = true
}

resource "azurerm_role_assignment" "secret_officer" {
  scope                = azurerm_key_vault.example.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_key_vault_secret" "example" {
  name             = "password"
  value_wo         = ephemeral.random_password.password.result
  value_wo_version = 1
  key_vault_id     = azurerm_key_vault.example.id
  depends_on       = [azurerm_role_assignment.secret_officer]
}
