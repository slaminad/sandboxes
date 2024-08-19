locals {
  prefix         = (var.prefix_override != "" ? var.prefix_override : var.nuon_id)
  install_region = var.region
  tags           = merge({ nuon_id = var.nuon_id }, var.tags)
  nuon_id        = var.nuon_id
  cluster_name   = (var.prefix_override != "" ? var.prefix_override : var.nuon_id)
}

variable "prefix_override" {
  type        = string
  description = "The resource prefix to override, otherwise defaults to the nuon install id"
  default     = ""
}

variable "vpc_id" {
  type        = string
  description = "The ID of VPC to deploy the ECS cluster to"
}

variable "private_subnet_ids" {
  type        = string
  default     = ""
  description = "Comma-separated string of IDs of the subnets to create private resources in."
}

variable "public_subnet_ids" {
  type        = string
  default     = ""
  description = "Comma-separated string of IDs of the subnets to create public resources in."
}

variable "nuon_id" {
  type        = string
  description = "The nuon id for this install. Used for naming purposes."
}

variable "tags" {
  type        = map(any)
  description = "List of custom tags to add to the install resources. Used for taxonomic purposes."
}

variable "region" {
  type        = string
  description = "The region to launch the cluster in"
}

// NOTE: if you would like to create an internal load balancer, with TLS, you will have to use the public domain.
variable "internal_root_domain" {
  type        = string
  description = "internal root domain."
}

variable "public_root_domain" {
  type        = string
  description = "public root domain."
}

variable "assume_role_arn" {
  type        = string
  description = "The ARN of the AWS IAM Role to assume during provisioning of the sandbox. Will be set by Nuon during the install provision process."
}

variable "nuon_runner_install_trust_iam_role_arn" {
  type        = string
  description = "The ARN of the AWS IAM Role to grant Nuon access to install the ECS Fargate runner. Will be set by Nuon during the install provision process."
}
