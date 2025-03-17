ephemeral "azurerm_key_vault_secret" "password" {
  name         = azurerm_key_vault_secret.example.name
  key_vault_id = azurerm_key_vault.example.id
}

resource "azurerm_mssql_server" "example" {
  name                                    = "ephemeral-example"
  resource_group_name                     = azurerm_resource_group.example.name
  location                                = azurerm_resource_group.example.location
  version                                 = "12.0"
  administrator_login                     = "aloizeau"
  administrator_login_password_wo         = ephemeral.azurerm_key_vault_secret.password.value
  administrator_login_password_wo_version = 1
  minimum_tls_version                     = "1.2"

  azuread_administrator {
    login_username = "CurrentAzureADUser"
    object_id      = data.azurerm_client_config.current.object_id
  }
}
