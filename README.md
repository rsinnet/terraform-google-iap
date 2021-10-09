# Terraform Google IAP Module

<!-- BEGIN_TF_DOCS -->
Access IAP brand and client information.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 3.87.0 |
| <a name="requirement_shell"></a> [shell](#requirement\_shell) | ~> 1.7.7 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_brands"></a> [brands](#module\_brands) | ./modules/shell_object | n/a |
| <a name="module_clients"></a> [clients](#module\_clients) | ./modules/shell_object | n/a |
| <a name="module_data_nonsensitive"></a> [data\_nonsensitive](#module\_data\_nonsensitive) | ./modules/shell_object | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project from which to extract IAP data. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_brand_names"></a> [brand\_names](#output\_brand\_names) | A list of all brand names in the project. |
| <a name="output_brands"></a> [brands](#output\_brands) | The brands and their clients for the current project. A project can only have one brand (though it might have none). |
| <a name="output_client_names"></a> [client\_names](#output\_client\_names) | Names of all clients in the project. |
| <a name="output_client_secrets"></a> [client\_secrets](#output\_client\_secrets) | A map of client names to secrets. |
| <a name="output_clients"></a> [clients](#output\_clients) | A map of client names to clients. |
<!-- END_TF_DOCS -->
