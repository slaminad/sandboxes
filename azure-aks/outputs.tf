output "runner" {
  value = {
    id           = module.sandbox.runner.id
    tenant_id    = module.sandbox.runner.tenant_id
    client_id    = module.sandbox.runner.client_id
    principal_id = module.sandbox.runner.principal_id
  }
}

output "vpn" {
  value = {
    name       = module.sandbox.vpn.name
    subnet_ids = module.sandbox.vpn.subnet_ids
  }
}

output "public_domain" {
  value = {
    nameservers = module.sandbox.public_domain.nameservers
    name        = module.sandbox.public_domain.name
    id          = module.sandbox.public_domain.id
  }
}

output "internal_domain" {
  value = {
    nameservers = module.sandbox.internal_domain.nameservers
    name        = module.sandbox.internal_domain.name
    id          = module.sandbox.internal_domain.id
  }
}

output "account" {
  value = {
    "location"            = module.sandbox.account.location
    "subscription_id"     = module.sandbox.account.subscription_id
    "client_id"           = module.sandbox.account.client_id
    "resource_group_name" = module.sandbox.account.resource_group_name
  }
}

output "acr" {
  value = {
    id           = module.sandbox.acr.id
    login_server = module.sandbox.acr.login_server
    token_id     = module.sandbox.acr.token_id
    password     = module.sandbox.acr.password
  }
}

output "cluster" {
  value = {
    "id"                     = module.sandbox.cluster.id
    "name"                   = module.sandbox.cluster.name
    "client_certificate"     = module.sandbox.cluster.client_certificate
    "client_key"             = module.sandbox.cluster.client_key
    "cluster_ca_certificate" = module.sandbox.cluster.cluster_ca_certificate
    "cluster_fqdn"           = module.sandbox.cluster.cluster_fqdn
    "oidc_issuer_url"        = module.sandbox.cluster.oidc_issuer_url
    "location"               = module.sandbox.cluster.location
    "kube_config_raw"        = module.sandbox.cluster.kube_config_raw
    "kube_admin_config_raw"  = module.sandbox.cluster.kube_admin_config_raw
  }
}
