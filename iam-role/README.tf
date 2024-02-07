# IAM-Role Module

This modules provisions an IAM role for sandbox, granting access to create Nuon installs.

Please read more in our [docs](https://docs.nuon.co/guides/install-access-permissions).

## Usage

You can use the following module invocation in any Terraform project:

```hcl
module "iam-role" {
  source = "github.com/nuonco/sandboxes//iam-role"

  sandbox = "aws-ecs"
  prefix = "iam-role-prefix"
}
```
