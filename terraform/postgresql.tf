resource "random_password" "password" {
  length           = 30
  special          = false
}

resource "azurerm_key_vault_secret" "psql-user" {
  name         = "psql-user"
  value        = "dapr_user"
  key_vault_id = azurerm_key_vault.acadapr.id
}

resource "azurerm_key_vault_secret" "psql-pass" {
  name         = "psql-pass"
  value        = random_password.password.result
  key_vault_id = azurerm_key_vault.acadapr.id
}

resource "azurerm_postgresql_flexible_server" "acadapr" {
  name                   = "acadapr-psql"
  resource_group_name    = azurerm_resource_group.baseRG.name
  location               = azurerm_resource_group.baseRG.location
  version                = "14"
  administrator_login    = azurerm_key_vault_secret.psql-user.value
  administrator_password = random_password.password.result
  zone                   = "2"

  storage_mb = 32768

  sku_name   = "B_Standard_B1ms"
}

resource "azurerm_postgresql_flexible_server_database" "acadapr" {
  name      = "acadapr-db"
  server_id = azurerm_postgresql_flexible_server.acadapr.id
  collation = "en_US.utf8"
  charset   = "utf8"
}