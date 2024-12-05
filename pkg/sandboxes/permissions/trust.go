package permissions

type Principal struct {
	AWS string `json:"AWS" yaml:"AWS"`
}

type Statement struct {
	Sid       string     `json:"Sid" yaml:"Sid,omitempty"`
	Effect    string     `json:"Effect" yaml:"Effect"`
	Principal *Principal `json:"Principal,omitempty" yaml:"Principal,omitempty"`
	Resource  string     `json:"Resource,omitempty" yaml:"Resource,omitempty"`
	Action    []string   `json:"Action" yaml:"Action"`
}

type Policy struct {
	Version   string      `json:"Version"`
	Statement []Statement `json:"Statement"`
}

// The default trust policy to allow cross-account roles to be assumed.
var TrustPolicy = Policy{
	Version: "2012-10-17",
	Statement: []Statement{
		{
			Sid:    "",
			Effect: "Allow",
			Principal: &Principal{
				AWS: "arn:aws:iam::676549690856:root",
			},
			Action: []string{"sts:AssumeRole"},
		},
		{
			Sid:    "",
			Effect: "Allow",
			Principal: &Principal{
				AWS: "arn:aws:iam::007754799877:root",
			},
			Action: []string{"sts:AssumeRole"},
		},
		{
			Sid:    "",
			Effect: "Allow",
			Principal: &Principal{
				AWS: "arn:aws:iam::814326426574:root",
			},
			Action: []string{"sts:AssumeRole"},
		},
		{
			Sid:    "",
			Effect: "Allow",
			Principal: &Principal{
				AWS: "arn:aws:iam::766121324316:root",
			},
			Action: []string{"sts:AssumeRole"},
		},
	},
}

// This is the preferred method for accessing the default trust policy.
// It returns the default trust policy.
func GetTrustPolicy() Policy {
	return TrustPolicy
}
