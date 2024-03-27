output "runner" {
  value = {
    odr_iam_role_arn = module.sandbox.runner.odr_iam_role_arn
  }
}

output "cluster" {
  // NOTE: these are declared here -
  // https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest?tab=outputs
  value = {
    arn                        = module.sandbox.cluster.arn
    certificate_authority_data = module.sandbox.cluster.certificate_authority_data
    endpoint                   = module.sandbox.cluster.endpoint
    name                       = module.sandbox.cluster.name
    platform_version           = module.sandbox.cluster.platform_version
    status                     = module.sandbox.cluster.status
    oidc_issuer_url            = module.sandbox.cluster.oidc_issuer_url
    cluster_security_group_id  = module.sandbox.cluster.cluster_security_group_id
    node_security_group_id     = module.sandbox.cluster.node_security_group_id
  }
}

output "vpc" {
  // NOTE: these are declared here -
  // https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest?tab=outputs
  value = {
    name = module.sandbox.vpc.name
    id   = module.sandbox.vpc.id
    cidr = module.sandbox.vpc.cidr
    azs  = module.sandbox.vpc.azs

    private_subnet_cidr_blocks = module.sandbox.vpc.private_subnet_cidr_blocks
    private_subnet_ids         = module.sandbox.vpc.private_subnet_ids
    public_subnet_cidr_blocks  = module.sandbox.vpc.public_subnet_cidr_blocks
    public_subnet_ids          = module.sandbox.vpc.public_subnet_ids
    default_security_group_id  = module.sandbox.vpc.default_security_group_id
  }
}

output "account" {
  value = {
    id     = module.sandbox.account.id
    region = module.sandbox.account.region
  }
}

output "ecr" {
  value = {
    repository_url  = module.sandbox.ecr.repository_url
    repository_arn  = module.sandbox.ecr.repository_arn
    repository_name = module.sandbox.ecr.repository_name
    registry_id     = module.sandbox.ecr.registry_id
    registry_url    = module.sandbox.ecr.registry_url
  }
}

output "public_domain" {
  value = {
    nameservers = module.sandbox.public_domain.nameservers
    name        = module.sandbox.public_domain.name
    zone_id     = module.sandbox.public_domain.zone_id
  }
}

output "internal_domain" {
  value = {
    nameservers = module.sandbox.internal_domain.nameservers
    name        = module.sandbox.internal_domain.name
    zone_id     = module.sandbox.internal_domain.zone_id
  }
}
