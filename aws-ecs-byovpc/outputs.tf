output "runner" {
  value = {
    runner_iam_role_arn  = module.sandbox.runner.runner_iam_role_arn
    odr_iam_role_arn     = module.sandbox.runner.odr_iam_role_arn
    install_iam_role_arn = module.sandbox.runner.install_iam_role_arn
  }
}

output "ecs_cluster" {
  value = {
    arn  = module.sandbox.ecs_cluster.arn
    id   = module.sandbox.ecs_cluster.id
    name = module.sandbox.ecs_cluster.name
  }
}

output "vpc" {
  value = {
    name = module.sandbox.vpc.name
    id   = module.sandbox.vpc.id
    cidr = module.sandbox.vpc.cidr
    azs  = module.sandbox.vpc.azs

    private_subnet_cidr_blocks = module.sandbox.vpc.private_subnet_cidr_blocks
    private_subnet_ids         = module.sandbox.vpc.private_subnet_ids

    public_subnet_cidr_blocks = module.sandbox.vpc.public_subnet_cidr_blocks
    public_subnet_ids         = module.sandbox.vpc.public_subnet_ids

    default_security_group_id  = module.sandbox.vpc.default_security_group_id
    default_security_group_arn = module.sandbox.vpc.default_security_group_arn
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
