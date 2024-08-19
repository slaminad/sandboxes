module "sandbox" {
  source  = "nuonco/aks-byovpn-sandbox/azure"
  version = "v1.2.16"

  network_name        = var.network_name
  resource_group_name = var.resource_group_name
  subnet_name         = var.subnet_name

  location             = var.location
  nuon_id              = var.nuon_id
  internal_root_domain = var.internal_root_domain
  public_root_domain   = var.public_root_domain
  cluster_version      = var.cluster_version
  vm_size              = var.vm_size
  node_count           = var.node_count
}
