resource "azurerm_log_analytics_workspace" "acadapr" {
  name                = "${var.projectName}-law"
  location            = azurerm_resource_group.baseRG.location
  resource_group_name = azurerm_resource_group.baseRG.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_registry" "acadapr" {
  name                = "${var.projectName}acr"
  resource_group_name = azurerm_resource_group.baseRG.name
  location            = azurerm_resource_group.baseRG.location
  sku                 = "Basic"
  admin_enabled       = true

}

resource "azurerm_container_app_environment" "acadapr" {
  name                       = "${var.projectName}-ace"
  location                   = azurerm_resource_group.baseRG.location
  resource_group_name        = azurerm_resource_group.baseRG.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.acadapr.id
}

resource "random_uuid" "be_app_id" {
}

resource "azurerm_container_app" "be_aca" {
  name                         = "${var.projectName}-be-aca"
  container_app_environment_id = azurerm_container_app_environment.acadapr.id
  resource_group_name          = azurerm_resource_group.baseRG.name
  revision_mode                = "Single"

  identity {
    type = "SystemAssigned"
  }

  dapr {
    app_id       = random_uuid.be_app_id.result
    app_port     = 8000
    app_protocol = "http"
  }

  ingress {
    external_enabled           = true
    target_port                = 8000
    allow_insecure_connections = false
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  template {
    container {
      name   = "${var.projectName}be"
      image  = "mcr.microsoft.com/k8se/quickstart:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
    min_replicas = 1
    max_replicas = 1
  }
}

# resource "azurerm_container_app_environment_dapr_component" "keyvault" {
#   name                         = "${var.projectName}-secrets"
#   container_app_environment_id = azurerm_container_app_environment.acadapr.id
#   component_type               = "secretstores.azure.keyvault"
#   version                      = "v1"

#   secret {
#     name  = "azureclientsecret"
#     value = "${var.client_secret}"
#   }

#   metadata {
#     name  = "vaultName"
#     value = azurerm_key_vault.acadapr.name
#   }

#   metadata {
#     name  = "azureTenantId"
#     value = data.azurerm_client_config.current.tenant_id
#   }

#   metadata {
#     name  = "azureClientId"
#     value = data.azurerm_client_config.current.client_id
#   }

#   metadata {
#     name        = "azureClientSecret"
#     secret_name = "azureclientsecret"
#   }

#   scopes = [random_uuid.be_app_id.result]

#   # depends_on = [
#   #   azurerm_postgresql_flexible_server_firewall_rule.acadapr
#   # ]
# }

resource "azurerm_container_app_environment_dapr_component" "postgresql" {
  name                         = "${var.projectName}-state"
  container_app_environment_id = azurerm_container_app_environment.acadapr.id
  component_type               = "state.postgresql"
  version                      = "v1"

  secret {
    name  = "connstring"
    value = "host=${azurerm_postgresql_flexible_server.acadapr.fqdn} user=${azurerm_key_vault_secret.psql-user.value} password=${random_password.password.result} port=5432 connect_timeout=10 database=${azurerm_postgresql_flexible_server_database.acadapr.name}"
  }

  metadata {
    name        = "connectionString"
    secret_name = "connstring"
  }

  scopes = [random_uuid.be_app_id.result]

  # depends_on = [
  #   azurerm_postgresql_flexible_server_firewall_rule.acadapr
  # ]
}

resource "azurerm_key_vault_secret" "aca-url" {
  name         = "aca-url"
  value        = azurerm_container_registry.acadapr.login_server
  key_vault_id = azurerm_key_vault.acadapr.id
}

resource "azurerm_key_vault_secret" "aca-user" {
  name         = "aca-user"
  value        = azurerm_container_registry.acadapr.admin_username
  key_vault_id = azurerm_key_vault.acadapr.id
}

resource "azurerm_key_vault_secret" "aca-pass" {
  name         = "aca-pass"
  value        = azurerm_container_registry.acadapr.admin_password
  key_vault_id = azurerm_key_vault.acadapr.id
}
