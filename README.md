# Sandboxes

Builtin sandboxes for Nuon apps.

## Background

Each `nuon` app comprises of a sandbox (the base layer, infrastructure such as cluster, VPC and more) and components (application infra and services). Sandboxes are managed using `terraform`, and are both cloud agnostic and customizable.

This repository exposes our built-in sandboxes, which you can use from within our [terraform provider](https://registry.terraform.io/providers/nuonco/nuon/latest/docs).

## Using these sandboxes

You can use the sandboxes in this repo with the following terraform config:

```hcl
resource "nuon_app_sandbox" "main" {
  app_id = nuon_app.main.id
  terraform_version = "v1.6.3"

  public_repo = {
    repo = "nuonco/sandboxes"
    branch = "main"
    directory = "aws-eks"
  }

  input {
    name = "eks_version"
    value = "v1.27.8"
  }
}
```
You can pass any SHA for `branch`, including a git commit sha, or tag.

We also publish these sandboxes internally, and they can be referenced using the built-in data source:
```hcl
data "nuon_builtin_sandbox" "main" {
  name = "aws-eks"
}

resource "nuon_app_sandbox" "main" {
  app_id = nuon_app.main.id
  builtin_sandbox_release_id = data.nuon_builtin_sandbox.main.sandbox_release.id
  terraform_version = "v1.6.3"

  input {
    name = "eks_version"
    value = "v1.27.8"
  }
}

```

## Forking and customizing

To customize a sandbox here, simply:

1. Fork this repo, and make it private if desired
1. Make sure your Github organization is connected to Nuon from our [dashboard](https://app.nuon.co), and is returned when running `nuon org list-connected-repos`.
1. Update `app_sandbox` to reference your sandbox:

```hcl
resource "nuon_app_sandbox" "main" {
  app_id = nuon_app.main.id
  terraform_version = "v1.6.3"

  connected_repo = {
    repo = "powertoolsdev/mono"
    branch = "main"
    directory = "sandboxes/aws-eks"
  }

  input {
    name = "eks_version"
    value = "v1.27.8"
  }
}
```

## Sandboxes

### `aws-eks`

The standard Nuon sandbox, that creates a new EKS cluster to provision an app.

```hcl
resource "nuon_app_sandbox" "main" {
  app_id = nuon_app.main.id
  terraform_version = "v1.6.3"

  public_repo = {
    repo = "nuonco/sandboxes"
    branch = "main"
    directory = "aws-eks"
  }

  input {
    name = "eks_version"
    value = "1.28"
  }
}
```

### `aws-eks-byovpc`

Provisions an EKS cluster into an existing VPC.

```hcl
resource "nuon_app_sandbox" "main" {
  app_id = nuon_app.main.id
  terraform_version = "v1.6.3"

  public_repo = {
    repo = "nuonco/sandboxes"
    branch = "main"
    directory = "aws-eks-byovpc"
  }

  input {
    name  = "install_name"
    value = "my_install"
  }

  input {
    name  = "vpc_id"
    value = "vpc-123"
  }

  input {
    name  = "eks_version"
    value = "1.28"
  }
}
```

### `aws-ecs`

Creates a new VPC and an ECS Fargate cluster.

```hcl
resource "nuon_app_sandbox" "main" {
  app_id = nuon_app.main.id
  terraform_version = "v1.6.3"

  public_repo = {
    repo = "nuonco/sandboxes"
    branch = "main"
    directory = "aws-ecs"
  }
}
```

### `aws-ecs-byovpc`

Creates an AWS Fargate cluster in an existing VPC.

```hcl
resource "nuon_app_sandbox" "main" {
  app_id = nuon_app.main.id
  terraform_version = "v1.6.3"

  public_repo = {
    repo = "nuonco/sandboxes"
    branch = "main"
    directory = "aws-ecs-byovpc"
  }

  input {
    name  = "vpc_id"
    value = "vpc-123"
  }
}
```

### `azure-aks`

Creates a new VPN and an AKS cluster.

```hcl
resource "nuon_app_sandbox" "main" {
  app_id = nuon_app.main.id
  terraform_version = "v1.6.3"

  public_repo = {
    repo = "nuonco/sandboxes"
    branch = "main"
    directory = "azure-aks"
  }
}
```

### `azure-aks-byovpc`

Creates an AKS cluster in an existing VPN.

```hcl
resource "nuon_app_sandbox" "main" {
  app_id = nuon_app.main.id
  terraform_version = "v1.6.3"

  public_repo = {
    repo = "nuonco/sandboxes"
    branch = "main"
    directory = "azure-aks-byovpc"
  }

  input {
    name  = "resource_group_name"
    value = "my-resource-group"
  }

  input {
    name  = "network_name"
    value = "my-network"
  }

  input {
    name  = "subnet_name"
    value = "my-subnet"
  }
}
```

## Inputs

Any value that is added as an `input` is accessible as a terraform variable. For instance, if your `app_sandbox` has the following input defined:

```hcl
resource "nuon_app_sandbox" "main" {
  app_id = nuon_app.main.id
  terraform_version = "v1.6.3"

  connected_repo = {
    repo = "your-org/sandboxes"
    branch = "main"
    directory = "default"
  }

  input {
    name = "tf_var"
    value = "value"
  }
}
```

Then, your sandbox can reference the input using a terraform variable:

```hcl
variable "tf_var" {
  description = "set as an app sandbox input"
  type        = string
}
```
