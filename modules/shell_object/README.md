# Terraform Shell Object Module

<!-- BEGIN_TF_DOCS -->
Run a shell command that outputs JSON and return the result as an object.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_shell"></a> [shell](#requirement\_shell) | ~> 1.7.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_shell"></a> [shell](#provider\_shell) | 1.7.7 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [shell_script.default](https://registry.terraform.io/providers/scottwinkler/shell/latest/docs/data-sources/script) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_command"></a> [command](#input\_command) | The command to execute, which returns a valid JSON string. | `string` | n/a | yes |
| <a name="input_sensitive"></a> [sensitive](#input\_sensitive) | If false, also return the output via object\_nonsensitive. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_object"></a> [object](#output\_object) | An object read from the command output treated as sensitive. This field is always populated regardless of the value of the input variable `sensitive`. |
| <a name="output_object_nonsensitive"></a> [object\_nonsensitive](#output\_object\_nonsensitive) | A non-sensitive object read from the output. This field exists for the purpose of propagating the object as non-sensitive. This really only affects the way this object is displayed in certain situations. This field is only populated if the input variable `sensitive` is set to false. |
<!-- END_TF_DOCS -->
