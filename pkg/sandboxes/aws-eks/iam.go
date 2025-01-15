package awseks

import perms "github.com/nuonco/sandboxes/pkg/sandboxes/permissions"

// provision role permissions specific to this sandbox
var ProvisionPermissions = append([]string{
	"ec2:DescribeAddressesAttribute",
	"ec2:CreateNetworkAclEntry",
	"ecr:UntagResource",
	"eks:ListAccessEntries",
	"eks:CreateAccessEntry",
	"eks:DescribeAccessEntry",
	"eks:UpdateAccessEntry",
	"eks:AssociateAccessPolicy",
	"eks:DisassociateAccessPolicy",
	"eks:CreateAddon",
	"eks:DescribeAddon",
	"eks:UpdateAddon",
	"eks:DescribeAddonConfiguration",
	"eks:DescribeAddonVersions",
	"eks:ListAddons",
	"eks:ListAssociatedAccessPolicies",
	"eks:CreateCluster",
	"eks:DescribeCluster",
	"eks:UpdateClusterVersion",
	"eks:CreateNodegroup",
	"eks:DescribeNodegroup",
	"eks:UpdateNodegroupConfig",
	"eks:UpdateNodegroupVersion",
	"eks:TagResource",
	"eks:UntagResource",
	"eks:ListTagsForResource",
	"eks:DescribeUpdate",
	"iam:UntagPolicy",
	"iam:UntagRole",
	"kms:UntagResource",
	"logs:UntagResource",
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
	"ec2:DeleteNetworkAclEntry",
	"ecr:UntagResource",
	"eks:ListAccessEntries",
	"eks:DeleteAccessEntry",
	"eks:DescribeAccessEntry",
	"eks:UpdateAccessEntry",
	"eks:DisassociateAccessPolicy",
	"eks:DeleteAddon",
	"eks:DescribeAddon",
	"eks:ListAddons",
	"eks:ListAssociatedAccessPolicies",
	"eks:DeleteCluster",
	"eks:DescribeCluster",
	"eks:UpdateClusterVersion",
	"eks:DeleteNodegroup",
	"eks:DescribeNodegroup",
	"eks:UntagResource",
	"eks:ListTagsForResource",
	"iam:UntagPolicy",
	"iam:UntagRole",
	"kms:UntagResource",
	"logs:UntagResource",
	"logs:ListTagsForResource",
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
