locals {
  iam_role_name   = "${var.prefix}-nuon-${var.sandbox}-access"
}

module "iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = ">= 5.1.0"

  create_role = true
  role_name   = local.iam_role_name

  allow_self_assume_role   = true
  custom_role_trust_policy        = file("${path.module}/../${var.sandbox}/artifacts/trust.json")
  create_custom_role_trust_policy = true
  custom_role_policy_arns = [
    aws_iam_policy.deprovision.arn,
    aws_iam_policy.provision.arn
  ]
}
