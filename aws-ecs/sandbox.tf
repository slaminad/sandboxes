module "sandbox" {
  source  = "nuonco/ecs-sandbox/aws"
  version = "1.1.1"

  prefix_override = var.prefix_override

  nuon_id                                = var.nuon_id
  region                                 = var.region
  assume_role_arn                        = var.assume_role_arn
  public_root_domain                     = var.public_root_domain
  internal_root_domain                   = var.internal_root_domain
  nuon_runner_install_trust_iam_role_arn = var.nuon_runner_install_trust_iam_role_arn
  tags                                   = var.tags
}
