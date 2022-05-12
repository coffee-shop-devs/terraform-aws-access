# this test generates no objects, but finds all objects
module "TestOverride" {
    source                  = "../../"
    vpc_name                = "default"
    subnet_name             = "default"
    ssh_key_name            = "default"
    security_group_name     = "default"
    vpc_override            = true
    subnet_override         = true
    ssh_key_override        = true
    security_group_override = true
}
