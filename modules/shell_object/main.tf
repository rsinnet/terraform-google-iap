/*
 * Run a shell command that outputs JSON and return the result as an object.
 */

terraform {
  required_version = ">= 0.14"
  required_providers {
    shell = {
      source  = "scottwinkler/shell"
      version = "~> 1.7.7"
    }
  }
}

variable "command" {
  type        = string
  description = "The command to execute, which returns a valid JSON string."
}
variable "sensitive" {
  type        = bool
  default     = true
  description = "If false, also return the output via object_nonsensitive."
}

locals {
  read_json_object = <<EOF
echo "{\"json\": $(%s | jq -Rs . -)}"
EOF
}

data "shell_script" "default" {
  lifecycle_commands {
    read = format(local.read_json_object, var.command)
  }
}
locals {
  object = jsondecode(data.shell_script.default.output["json"])
}

output "object_nonsensitive" {
  sensitive   = false
  value       = var.sensitive ? null : local.object
  description = "A non-sensitive object read from the output. This field exists for the purpose of propagating the object as non-sensitive. This really only affects the way this object is displayed in certain situations. This field is only populated if the input variable `sensitive` is set to false."
}

output "object" {
  sensitive   = true
  value       = local.object
  description = "An object read from the command output treated as sensitive. This field is always populated regardless of the value of the input variable `sensitive`."
}
