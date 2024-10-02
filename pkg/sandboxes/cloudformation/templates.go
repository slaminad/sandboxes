package cloudformation

import (
	"bytes"
	"log"
	"text/template"
	"time"

	perms "github.com/nuonco/sandboxes/pkg/sandboxes/permissions"

	"github.com/Masterminds/sprig"
	"gopkg.in/yaml.v2"
)

type CloudFormationTemplate struct {
	templateString           string
	delegationTemplateString string

	// for template
	GeneratedOn                  string
	ProvisionPolicyPermissions   []string
	DeprovisionPolicyPermissions []string
	TrustPolicy                  string // rendered yaml; not always present.
}

// Render default cloudformation template for an aws sandbox.
// Returns a buffer so the content can be written to the desired location.
func (cft *CloudFormationTemplate) RenderCloudformationTemplate() (*bytes.Buffer, error) {
	trustPolicy, err := yaml.Marshal(perms.TrustPolicy.Statement)
	if err != nil {
		log.Fatal(err)
	}
	cft.TrustPolicy = string(trustPolicy)

	buf := &bytes.Buffer{}
	tmpl, err := template.New("cloudformation-template.yaml").Funcs(sprig.FuncMap()).Parse(cft.templateString)
	if err != nil {
		log.Fatal(err)
	}
	err = tmpl.Execute(buf, cft)
	if err != nil {
		log.Fatal(err)
	}

	return buf, nil
}

// Render default cloudformation template with delegation for an aws sandbox.
// Returns a buffer so the content can be written to the desired location.
func (cft *CloudFormationTemplate) RenderCloudformationDelegationTemplate() (*bytes.Buffer, error) {
	buf := &bytes.Buffer{}
	tmpl, err := template.New("cloudformation-template-delegation.yaml").Parse(cft.delegationTemplateString)
	if err != nil {
		log.Fatal(err)
	}
	err = tmpl.Execute(buf, cft)
	if err != nil {
		log.Fatal(err)
	}

	return buf, nil
}

func New(templateString string, delegationTemplateString string, provisionPerms []string, deprovisionPerms []string) CloudFormationTemplate {
	return CloudFormationTemplate{
		templateString:               templateString,
		delegationTemplateString:     delegationTemplateString,
		ProvisionPolicyPermissions:   provisionPerms,
		DeprovisionPolicyPermissions: deprovisionPerms,
		GeneratedOn:                  time.Now().String(),
	}
}
