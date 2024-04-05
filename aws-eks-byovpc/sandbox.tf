module "sandbox" {
  source  = "nuonco/eks-byovpc-sandbox/aws"
  version = "1.0.5"

  vpc_id                = var.vpc_id
  install_name          = var.install_name
  cluster_name          = var.cluster_name
  eks_version           = var.eks_version
  min_size              = var.min_size
  max_size              = var.max_size
  desired_size          = var.desired_size
  default_instance_type = var.default_instance_type
  admin_access_role_arn = var.admin_access_role_arn
  additional_tags       = var.additional_tags

  nuon_id                           = var.nuon_id
  region                            = var.region
  assume_role_arn                   = var.assume_role_arn
  external_access_role_arns         = var.external_access_role_arns
  waypoint_odr_namespace            = var.waypoint_odr_namespace
  waypoint_odr_service_account_name = var.waypoint_odr_service_account_name
  public_root_domain                = var.public_root_domain
  internal_root_domain              = var.internal_root_domain
  tags                              = var.tags

  # Need to explicitly pass in providers, because of no_tags provider.
  providers = {
    aws         = aws
    aws.no_tags = aws.no_tags
    helm        = helm
    kubectl     = kubectl
    kubernetes  = kubernetes
  }
}
