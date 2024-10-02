package awseksbyovpc

import perms "github.com/nuonco/sandboxes/pkg/sandboxes/permissions"

// provision role permissions specific to this sandbox
var ProvisionPermissions = append([]string{
	"eks:CreateAddon",
	"eks:CreateCluster",
	"eks:CreateNodegroup",
	"eks:DescribeAddon",
	"eks:DescribeAddonConfiguration",
	"eks:DescribeAddonVersions",
	"eks:DescribeCluster",
	"eks:DescribeNodegroup",
	"eks:DescribeUpdate",
	"eks:ListAddons",
	"eks:ListTagsForResource",
	"eks:TagResource",
	"eks:UpdateNodegroupVersion",
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
	"eks:DeleteNodegroup",
	"eks:DescribeCluster",
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
