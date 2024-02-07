resource "aws_iam_policy" "provision" {
  name   = "${var.prefix}-nuon-${var.sandbox}-provision"
  policy = file("${path.module}/../${var.sandbox}/artifacts/provision.json")
}
