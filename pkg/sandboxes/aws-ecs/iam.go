package awsecs

import perms "github.com/nuonco/sandboxes/pkg/sandboxes/permissions"

// provision role permissions specific to this sandbox
var ProvisionPermissions = append([]string{
	"ec2:CreateNetworkAclEntry",
	"ec2:DeleteNetworkAclEntry",
	"ecs:CreateCapacityProvider",
	"ecs:CreateCluster",
	"ecs:DescribeCapacityProviders",
	"ecs:DescribeClusters",
	"ecs:ListTagsForResource",
	"ecs:PutClusterCapacityProviders",
	"ecs:TagResource",
	"rds:AddTagsToResource",
	"rds:CreateDBSubnetGroup",
	"rds:DeleteDBSubnetGroup",
	"rds:DescribeDBSubnetGroups",
	"rds:ListTagsForResource",
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
	"ecs:DeleteCapacityProvider", "ecs:DeleteCluster",
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
