package test

import (
  "testing"
  "os"
  "github.com/gruntwork-io/terratest/modules/terraform"
)

// this test generates all objects, no overrides
func TestBasic(t *testing.T) {
  t.Parallel()

  var my_ip string      = os.Getenv("IP")
  var my_email string   = os.Getenv("EMAIL")
  var my_ssh_key string = os.Getenv("PUBLIC_SSH_KEY")

  var tfvars = map[string]interface{}{
    "ip":       my_ip,
    "email":    my_email,
    "ssh_key":  my_ssh_key,
  }

  terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
    TerraformDir: "../examples/basic",
    Vars: tfvars,
  })

  defer terraform.Destroy(t, terraformOptions)
  terraform.InitAndApply(t, terraformOptions)
}
