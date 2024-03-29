# AWS Access Module

This module provides the basic necessities for connecting to EC2 servers.

This is a "Core Module", it shouldn't contain any nested "independent modules". Please see [terraform.md](./terraform.md) for more information.

## Requirements

### AWS Access

The first step to using the AWS modules is having an AWS account, [here](https://docs.aws.amazon.com/accounts/latest/reference/manage-acct-creating.html) is a document describing this process.
You will need an API access key id and API secret key, you can get the API keys [following this tutorial](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html#Using_CreateAccessKey).

The Terraform AWS provider uses the AWS Go SDK, which allows the use of either environment variables or config files for authentication.
https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html#cli-configure-files-settings

You do not need the AWS cli to generate the files, just place them in the proper place and Terraform will find and read them.
The tests expect three variables to exist in your environment: EMAIL, PUBLIC_SSH_KEY, and AWS_OWNER.
These help the tests set you as the owner on the testing infra and generate the proper key.
AWS_USERNAME is also used by the .envrc file to determine the path to your aws config,
  the normal place is ~/.config/aws/username/rc, but if you have more than one account you need to tell it which one to use.
AWS_USERNAME replaced the path with the user you set it to (ex. if AWS_USERNAME=bob, then it will look in ~/.config/aws/bob/rc).

### Nix

These modules use Nix the OS agnostic package manager to install and manage local package dependencies,
 install Nix and source the .envrc to enter the environment.
The .envrc will load a Nix development environment (a Nix shell), using the flake.nix file.
You can easily add or remove dependencies by updating that file, the flake.lock is a lock file to cache dependencies.
After loading the Nix shell, Nix will source the .envrc, setting all of the environment variables as necessary.

## Local State

The specific use case for the exaple mmodules here is temporary infrastructure for testing purposes.
With that in mind it is not expected that the user will manage the resources as a team,
  therefore the state files are all stored locally.
If you would like to store the state files remotely, add a terraform backend file (`*.name.tfbackend`) to your implementation module.
https://www.terraform.io/language/settings/backends/configuration#file

## Override Tests

You may want to test this code with slightly different parameters for your environment.
Check out [Terraform override files](https://developer.hashicorp.com/terraform/language/files/override) as a clean way to modify the inputs without accidentally committing any personalized code.
