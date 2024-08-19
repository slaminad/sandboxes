module "sandbox" {
  source  = "nuonco/aks-sandbox/azure"
  version = "1.3.11"

  location             = var.location
  nuon_id              = var.nuon_id
  internal_root_domain = var.internal_root_domain
  public_root_domain   = var.public_root_domain
  tags                 = var.tags
  cluster_name         = var.cluster_name
  cluster_version      = var.cluster_version
  vm_size              = var.vm_size
  node_count           = var.node_count
  instance_types       = var.instance_types
  username             = var.username
}
