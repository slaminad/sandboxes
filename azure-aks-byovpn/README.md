# Azure AKS BYOVPN

Azure sandbox that provisions an AKS cluster in an existing VPN:

## Usage

Use this in your BYOC app with a `vpc_id` input and the `azure-ask` runner type.

```toml
version = "v1"

[inputs]
[[inputs.input]]
name = "vpc_id"
description = "The VPC to install the app in"
sensitive = false
display_name = "VPC ID"
required = true

[sandbox]
terraform_version = "1.5.4"
[sandbox.public_repo]
repo = "nuonco/sandboxes"
directory = "azure-aks-byovpn"
branch = "main"
[[sandbox.var]]
name = "vpc_id"
value = "{{.nuon.install.inputs.vpc_id}}"

[runner]
runner_type = "azure-aks"
```

## Testing

This sandbox can be tested outside of `nuon` by following these steps:

1. Ensure you have an Azure account setup and `az` installed
1. [Create Service Principal Credentials](https://learn.microsoft.com/en-us/azure/aks/learn/quick-kubernetes-deploy-terraform?tabs=bash#create-a-service-principal)
1. Create a `terraform.tfvars` with the correct variable inputs
