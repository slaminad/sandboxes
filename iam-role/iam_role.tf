locals {
  iam_role_name     = "${var.prefix}-nuon-${var.sandbox}-access"
  sandboxes_repo    = "nuonco/sandboxes"
  artifact_base_url = "https://raw.githubusercontent.com/nuonco/sandboxes/${var.branch}/${var.sandbox}/artifacts"
}

module "iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = ">= 5.1.0"

  create_role = true
  role_name   = local.iam_role_name

  allow_self_assume_role          = true
  custom_role_trust_policy        = data.http.sandbox_trust_policy.response_body
  create_custom_role_trust_policy = true
  custom_role_policy_arns = [
    aws_iam_policy.deprovision.arn,
    aws_iam_policy.provision.arn
  ]
}
