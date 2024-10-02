package awseksbyovpc

import (
	"fmt"

	"github.com/go-playground/validator/v10"
	"github.com/mitchellh/mapstructure"
	"github.com/nuonco/sandboxes/pkg/sandboxes"
	"google.golang.org/protobuf/types/known/structpb"
)

type ClusterOutputs struct {
	ARN                      string `mapstructure:"arn"`
	CertificateAuthorityData string `mapstructure:"certificate_authority_data"`
	Endpoint                 string `mapstructure:"endpoint"`
	Name                     string `mapstructure:"name"`
	PlatformVersion          string `mapstructure:"platform_version"`
	Status                   string `mapstructure:"status"`
}

type RunnerOutputs struct {
	// eks outputs
	DefaultIAMRoleARN string `mapstructure:"default_iam_role_arn"`

	// ecs runner outputs
	Type              string `mapstructure:"type"`
	RunnerIAMRoleARN  string `mapstructure:"runner_iam_role_arn"`
	ODRIAMRoleARN     string `mapstructure:"odr_iam_role_arn"`
	InstallIAMRoleARN string `mapstructure:"install_iam_role_arn"`
}

type TerraformOutputs struct {
	// domain outputs
	PublicDomain   sandboxes.DomainOutputs `mapstructure:"public_domain"`
	InternalDomain sandboxes.DomainOutputs `mapstructure:"internal_domain"`
	Cluster        ClusterOutputs          `mapstructure:"cluster"`
	ECR            sandboxes.ECROutputs    `mapstructure:"ecr"`
	VPC            sandboxes.VPCOutputs    `mapstructure:"vpc"`
	Runner         RunnerOutputs           `mapstructure:"runner"`
}

func (t *TerraformOutputs) Validate() error {
	validate := validator.New()
	return validate.Struct(t)
}

func ParseTerraformOutputs(outputs *structpb.Struct) (TerraformOutputs, error) {
	m := outputs.AsMap()

	var tfOutputs TerraformOutputs
	if err := mapstructure.Decode(m, &tfOutputs); err != nil {
		return tfOutputs, fmt.Errorf("invalid terraform outputs: %w", err)
	}

	err := tfOutputs.Validate()
	if err != nil {
		return tfOutputs, fmt.Errorf("terraform output error: %w", err)
	}

	return tfOutputs, nil
}
