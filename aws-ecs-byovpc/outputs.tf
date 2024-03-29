output "runner" {
  value = module.sandbox.runner
}

output "ecs_cluster" {
  value = module.sandbox.ecs_cluster
}

output "vpc" {
  value = module.sandbox.vpc
}

output "account" {
  value = module.sandbox.account
}

output "ecr" {
  value = module.sandbox.ecr
}

output "public_domain" {
  value = module.sandbox.public_domain
}

output "internal_domain" {
  value = module.sandbox.internal_domain
}
