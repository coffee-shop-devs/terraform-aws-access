package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"os"
	"testing"
)

// this test adds security group and subnet, but overrides vpc and ssh key
// this is a typical experience when you want to start a new project in a new subnet,
//
//	and the vpc is outside of your control
func TestProject(t *testing.T) {
	t.Parallel()
	var my_email string = os.Getenv("EMAIL")
	var my_ssh_key string = os.Getenv("PUBLIC_SSH_KEY")
	var my_cidr string = os.Getenv("TEST_CIDR")

	var tfvars = map[string]interface{}{
		"email":   my_email,
		"ssh_key": my_ssh_key,
		"cidr":    my_cidr,
	}

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/project",
		Vars:         tfvars,
	})

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)
}
