resource "aws_iam_policy" "deprovision" {
  name   = "${var.prefix}-nuon-${var.sandbox}-deprovision"
  policy = file("${path.module}/../${var.sandbox}/artifacts/deprovision.json")
}
