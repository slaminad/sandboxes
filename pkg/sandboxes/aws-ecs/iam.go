package awsecs

import perms "github.com/nuonco/sandboxes/pkg/sandboxes/permissions"

// provision role permissions specific to this sandbox
var ProvisionPermissions = append([]string{
	"application-autoscaling:*",
	"acm:DescribeCertificate",
	"acm:RequestCertificate",
	"acm:ListTagsForCertificate",
	"acm:AddTagsToCertificate",
	"ec2:DescribeAddressesAttribute",
	"ec2:CreateNetworkAclEntry",
	"ec2:DeleteNetworkAclEntry",
	"ecs:CreateCapacityProvider",
	"ecs:DescribeCapacityProviders",
	"ecs:CreateCluster",
	"ecs:PutClusterCapacityProviders",
	"ecs:DescribeClusters",
	"ecs:TagResource",
	"ecs:CreateService",
	"ecs:DeleteService",
	"ecs:UpdateService",
	"ecs:DescribeServices",
	"ecs:ListServices",
	"ecs:ListTagsForResource",
	"ecs:DeregisterTaskDefinition",
	"ecs:DescribeTaskDefinition",
	"ecs:RegisterTaskDefinition",
	"ecs:ListTaskDefinitions",
	"elasticloadbalancing:CreateLoadBalancer",
	"elasticloadbalancing:DeleteLoadBalancer",
	"elasticloadbalancing:DescribeLoadBalancerAttributes",
	"elasticloadbalancing:ModifyLoadBalancerAttributes",
	"elasticloadbalancing:DescribeLoadBalancers",
	"elasticloadbalancing:AddTags",
	"elasticloadbalancing:DescribeTags",
	"elasticloadbalancing:CreateTargetGroup",
	"elasticloadbalancing:DescribeTargetGroupAttributes",
	"elasticloadbalancing:ModifyTargetGroupAttributes",
	"elasticloadbalancing:DescribeTargetGroups",
	"kms:CreateGrant",
	"logs:ListTagsForResource",
	"rds:CreateDBSubnetGroup",
	"rds:DeleteDBSubnetGroup",
	"rds:DescribeDBSubnetGroups",
	"rds:ListTagsForResource",
	"rds:AddTagsToResource",
	"servicediscovery:CreateHttpNamespace",
	"servicediscovery:GetOperation",
}, perms.BaseProvisionPermissions...)

// Full provision rol policy for this sandbox
var ProvisionPolicy = perms.Policy{
	Version: "2012-10-17",
	Statement: []perms.Statement{
		{
			Effect:   "Allow",
			Resource: "*",
			Action:   ProvisionPermissions,
		},
	},
}

// deprovision role permissions specific to this sandbox
var DeprovisionPermissions = append([]string{
	"application-autoscaling:*",
	"ec2:DescribeAddressesAttribute",
	"ec2:DeleteNetworkAclEntry",
	"ecs:DeleteCapacityProvider",
	"ecs:DescribeCapacityProviders",
	"ecs:DeleteCluster",
	"ecs:DescribeClusters",
	"ecs:UntagResource",
	"ecs:DeleteService",
	"ecs:UpdateService",
	"ecs:DescribeServices",
	"ecs:ListServices",
	"ecs:ListTagsForResource",
	"ecs:DeregisterTaskDefinition",
	"ecs:DescribeTaskDefinition",
	"ecs:ListTaskDefinitions",
	"logs:ListTagsForResource",
	"rds:DeleteDBSubnetGroup",
	"rds:DescribeDBSubnetGroups",
	"rds:ListTagsForResource",
}, perms.BaseDeprovisionPermissions...)

// Full deprovision role policy for this sandbox
var DeprovisionPolicy = perms.Policy{
	Version: "2012-10-17",
	Statement: []perms.Statement{
		{
			Effect:   "Allow",
			Resource: "*",
			Action:   DeprovisionPermissions,
		},
	},
}
