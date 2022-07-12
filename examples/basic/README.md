# Basic Example

This example requires an email address, your local IP address, and the content of your public ssh key.

You can get your local IP address from `curl ipinfo.io/ip`.
The email address provided will be used to label the resources provided.
The contents of the **public** ssh key will be used to generate a 'keypair' object in AWS which will be available for EC2 instances to include for ssh access.

In this example as many reasonable defaults as possible were provided, but the above information is too private to include even in example data.

This example has been validated using [Terratest](https://terratest.gruntwork.io/), a Go sdk and test suite for Terraform.
