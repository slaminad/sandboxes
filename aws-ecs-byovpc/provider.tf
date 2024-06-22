provider "aws" {
  region = local.install_region

  default_tags {
    tags = local.tags
  }
}
