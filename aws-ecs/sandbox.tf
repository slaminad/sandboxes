module "sandbox" {
  source  = "nuonco/ecs-sandbox/aws"
  version = "1.2.2"

  prefix_override = var.prefix_override

  nuon_id              = var.nuon_id
  region               = var.region
  public_root_domain   = var.public_root_domain
  internal_root_domain = var.internal_root_domain
  tags                 = var.tags
  runner_install_role  = var.runner_install_role
}
