variable "prefix" {
  type = string
  description = "prefix for IAM role and policies"
}

variable "sandbox" {
  type = string
  description = "sandbox to use"
  validation {
      condition     = contains([
      "aws-ecs",
      "aws-ecs-byovpc",
      "aws-eks",
      "aws-eks-byovpc",
      ], var.sandbox)
      error_message = "${var.sandbox} is not a valid sandbox"
    }
}

variable "branch" {
  type = string
  default = "main"
  description = "branch to load permissions from"
}
