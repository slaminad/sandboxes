package awsecsbyovpc

import (
	_ "embed"

	cft "github.com/nuonco/sandboxes/pkg/sandboxes/cloudformation"
)

//go:embed cloudformation-template.yaml
var cloudformationTemplate string

//go:embed cloudformation-template-delegation.yaml
var cloudformationDelegationTemplate string

var CloudformationTemplates = cft.New(
	cloudformationTemplate,
	cloudformationDelegationTemplate,
	ProvisionPermissions,
	DeprovisionPermissions,
)
