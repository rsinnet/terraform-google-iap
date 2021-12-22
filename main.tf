/*
 * Access IAP brand and client information.
 */
terraform {
  required_version = ">= 0.14"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.87.0"
    }
    shell = {
      source  = "scottwinkler/shell"
      version = ">= 1.7.7"
    }
  }
}

locals {
  remove_secrets = "jq -r 'del(.[][\"secret\"])'"
  gcloud         = "gcloud alpha iap --format=json --project=${var.project_id}"
}

module "brands" {
  source    = "./modules/shell_object"
  sensitive = false
  command   = "${local.gcloud} oauth-brands list"
}
locals {
  brands      = module.brands.object_nonsensitive
  brand_names = local.brands[*]["name"]
}

module "data_nonsensitive" {
  for_each  = toset(local.brand_names)
  source    = "./modules/shell_object"
  sensitive = false
  command   = "${local.gcloud} oauth-clients list ${each.key} | ${local.remove_secrets}"
}
locals {
  client_names = flatten([
    for b in local.brand_names :
    [
      for name in module.data_nonsensitive[b].object_nonsensitive[*].name :
      regex("identityAwareProxyClients/(.*)$", name)
    ]
  ])
}

module "clients" {
  for_each  = toset(local.brand_names)
  source    = "./modules/shell_object"
  sensitive = true
  command   = "${local.gcloud} oauth-clients list ${each.key}"
}
locals {
  client_kvps = flatten([
    for b in local.brand_names : [
      for c in module.clients[b].object : [
        {
          key   = regex("identityAwareProxyClients/(.*)$", c.name)[0]
          value = c
        }
      ]
    ]
  ])
  clients        = { for kvp in local.client_kvps : kvp.key => kvp.value }
  client_secrets = { for name, client in local.clients : name => client.secret }
}
