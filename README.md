# Sandboxes

Terraform projects that make it easy to use the Nuon managed sandboxes.

Each of our sandboxes is published as a Terraform module. In order to use one, you would need to create a Terraform project that imports the sandbox you want to use, and sets up the required providers and S3 backend. To save you the hassle, this repo provides a ready-to-use Terraform project for each sandbox that we manage.

## Using a Sandbox

To use one of our managed sandboxes without additional setup, simply add a sandbox config to your app that references this repo. For example, to use the `aws-eks` sandbox:

```hcl
resource "nuon_app_sandbox" "main" {
  app_id = nuon_app.main.id
  terraform_version = "v1.6.3"

  public_repo = {
    repo = "nuonco/sandboxes"
    directory = "aws-eks"
    branch = "main"
  }
}
```

The `branch` attribute will accept any valid Git ref, including a commit sha or tag.

Reference the documentation for each sandbox module for detailed usage examples.

- [AWS EKS](https://registry.terraform.io/modules/nuonco/eks-sandbox/aws/latest)
- [AWS EKS BYOVPC](https://registry.terraform.io/modules/nuonco/eks-byovpc-sandbox/aws/latest)
- [AWS ECS](https://registry.terraform.io/modules/nuonco/ecs-sandbox/aws/latest)
- [AWS ECS BYOVPC](https://registry.terraform.io/modules/nuonco/ecs-byovpc-sandbox/aws/latest)
- [Azure AKS](https://registry.terraform.io/modules/nuonco/aks-sandbox/azure/latest)
- [Azure AKS BYOVPN](https://registry.terraform.io/modules/nuonco/aks-byovpn-sandbox/azure/latest)
