package test

import (
  "os"
  "testing"
  "github.com/gruntwork-io/terratest/modules/terraform"
)

// this test adds security group and ssh key, but overrides vpc and subnet
// this is a typical experience when vpc and subnet is managed by a different group
// thus generating only unshared or "personal" objects
func TestPersonal(t *testing.T) {
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
    TerraformDir: "../examples/personal",
    Vars: tfvars,
  })

  defer terraform.Destroy(t, terraformOptions)
  terraform.InitAndApply(t, terraformOptions)
}
