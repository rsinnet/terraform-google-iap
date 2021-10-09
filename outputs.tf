output "brand_names" {
  value       = local.brand_names
  description = "A list of all brand names in the project."
}

output "brands" {
  value = {
    for b in module.brands.object_nonsensitive :
    b["name"] => {
      application_title = b["applicationTitle"]
      org_internal_only = b["orgInternalOnly"]
      support_email     = b["supportEmail"]
      clients = [
        for c in module.data_nonsensitive[b["name"]].object_nonsensitive :
        {
          display_name = c["displayName"]
          name         = c["name"]
        }
      ]
    }
  }
  description = "The brands and their clients for the current project. A project can only have one brand (though it might have none)."
}

output "client_names" {
  value       = local.client_names
  description = "Names of all clients in the project."
}

output "client_secrets" {
  value       = local.client_secrets
  sensitive   = true
  description = "A map of client names to secrets."
}

output "clients" {
  value       = local.clients
  sensitive   = true
  description = "A map of client names to clients."
}
