# AWS-Access 

This module provides the basic necessities for provisioning and connecting to EC2 servers.

## Requirements

### AWS Access

The first step to using the AWS modules is having an AWS account.
You will need an API access key id and API secret key.
Once you have an account, you can get the API keys following this tutorial: 
https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html#Using_CreateAccessKey

At this time I have no plans to automate management of:
- IAM roles
- User accounts
- Root accounts
- API Access keys

The Terraform AWS provider uses the AWS Go SDK, which allows the use of either environment variables or config files for authentication.
https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html#cli-configure-files-settings

You do not need the AWS cli to generate the files, just place them in the proper place and Terraform will find and read them.

### Terraform Access

These modules assume you have Terraform >= v1.0 installed on the system where you would like to run them.
https://learn.hashicorp.com/tutorials/terraform/install-cli

### Local State

The specific use case for the modules here is temporary infrastructure for testing purposes.
With that in mind it is not expected that the user will manage the resources as a team,
  therefore the state files are all stored locally.
If you would like to store the state files remotely, add a terraform backend file (`*.name.tfbackend`) to your implementation module.
https://www.terraform.io/language/settings/backends/configuration#file
