module "sandbox" {
  source  = "nuonco/ecs-byovpc-sandbox/aws"
  version = "1.2.2"

  prefix_override      = var.prefix_override
  vpc_id               = var.vpc_id
  nuon_id              = var.nuon_id
  region               = var.region
  public_root_domain   = var.public_root_domain
  internal_root_domain = var.internal_root_domain
  tags                 = var.tags
  private_subnet_ids   = var.private_subnet_ids
  public_subnet_ids    = var.public_subnet_ids
  runner_install_role  = var.runner_install_role
}
