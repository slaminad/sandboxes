package awseksbyovpc

import perms "github.com/nuonco/sandboxes/pkg/sandboxes/permissions"

// provision role permissions specific to this sandbox
var ProvisionPermissions = append([]string{
	"eks:CreateAddon",
	"eks:DescribeAddon",
	"eks:DescribeAddonConfiguration",
	"eks:DescribeAddonVersions",
	"eks:ListAddons",
	"eks:CreateCluster",
	"eks:DescribeCluster",
	"eks:CreateNodegroup",
	"eks:DescribeNodegroup",
	"eks:UpdateNodegroupVersion",
	"eks:TagResource",
	"eks:ListTagsForResource",
	"eks:DescribeUpdate",
	"logs:ListTagsForResource",
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
	"eks:DeleteAddon",
	"eks:DeleteCluster",
	"eks:DescribeCluster",
	"eks:DeleteNodegroup",
	"eks:DescribeNodegroup",
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
