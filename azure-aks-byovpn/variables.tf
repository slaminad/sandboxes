variable "network_name" {
  type        = string
  description = "The name of the Azure Virtual Network to provision the AKS cluster in."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Azure Resource Group the Virtual Network is in."
}

variable "subnet_name" {
  type        = string
  description = "The name of the Vnet Subnet to provision the AKS cluster in."
}

variable "nuon_id" {
  type        = string
  description = "The nuon id for this install. Used for naming purposes."
}

variable "location" {
  type        = string
  description = "The location to launch the cluster in"
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

variable "cluster_version" {
  type        = string
  description = "The Kubernetes version to use for the EKS cluster."
  default     = "1.28"
}

variable "vm_size" {
  type        = string
  default     = "Standard_D2_v2"
  description = "The image size"
}

variable "node_count" {
  type        = number
  default     = 2
  description = "The minimum number of nodes in the managed node pool."
}
