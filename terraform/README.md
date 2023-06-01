# Terraform Docs

We're using a GitHub action to automatically run Terraform Docs each time a pull request is created.  This will keep our Terraform documentation up-to-date as we build out our environemnt(s).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.0, <2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.58.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.5.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.58.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Resources

| Name | Type |
|------|------|
| [azurerm_container_app.acadapr](https://registry.terraform.io/providers/hashicorp/azurerm/3.58.0/docs/resources/container_app) | resource |
| [azurerm_container_app_environment.acadapr](https://registry.terraform.io/providers/hashicorp/azurerm/3.58.0/docs/resources/container_app_environment) | resource |
| [azurerm_container_app_environment_dapr_component.acadapr](https://registry.terraform.io/providers/hashicorp/azurerm/3.58.0/docs/resources/container_app_environment_dapr_component) | resource |
| [azurerm_container_registry.acadapr](https://registry.terraform.io/providers/hashicorp/azurerm/3.58.0/docs/resources/container_registry) | resource |
| [azurerm_key_vault.acadapr](https://registry.terraform.io/providers/hashicorp/azurerm/3.58.0/docs/resources/key_vault) | resource |
| [azurerm_key_vault_secret.aca-pass](https://registry.terraform.io/providers/hashicorp/azurerm/3.58.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.aca-url](https://registry.terraform.io/providers/hashicorp/azurerm/3.58.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.aca-user](https://registry.terraform.io/providers/hashicorp/azurerm/3.58.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.psql-pass](https://registry.terraform.io/providers/hashicorp/azurerm/3.58.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.psql-user](https://registry.terraform.io/providers/hashicorp/azurerm/3.58.0/docs/resources/key_vault_secret) | resource |
| [azurerm_log_analytics_workspace.acadapr](https://registry.terraform.io/providers/hashicorp/azurerm/3.58.0/docs/resources/log_analytics_workspace) | resource |
| [azurerm_postgresql_flexible_server.acadapr](https://registry.terraform.io/providers/hashicorp/azurerm/3.58.0/docs/resources/postgresql_flexible_server) | resource |
| [azurerm_postgresql_flexible_server_database.acadapr](https://registry.terraform.io/providers/hashicorp/azurerm/3.58.0/docs/resources/postgresql_flexible_server_database) | resource |
| [azurerm_resource_group.baseRG](https://registry.terraform.io/providers/hashicorp/azurerm/3.58.0/docs/resources/resource_group) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/3.5.1/docs/resources/password) | resource |
| [random_uuid.acadapr](https://registry.terraform.io/providers/hashicorp/random/3.5.1/docs/resources/uuid) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.58.0/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_projectName"></a> [projectName](#input\_projectName) | Provide a project name. This will be used for the base Resource Group and can be used for future resources. | `string` | n/a | yes |
<!-- END_TF_DOCS -->

# References

 * [Terraform](https://developer.hashicorp.com/terraform/intro)
 * [Terraform Docs](https://terraform-docs.io)
 * [Terraform Docs Github Action](https://github.com/terraform-docs/gh-actions)
