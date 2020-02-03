# Oracle Cloud Infrastructure (OCI) Terraform IAM Dynamic Groups Module

## Introduction


This module assist in provisioning OCI Dynamic Groups and adding instances to those groups.
  

## Solution

This module assist in provisioning OCI Dynamic Groups and adding instances to those groups.

The module covers the following usecases:

* Creating one dynamic group and adding zero, one or multiple instances to this dynamic group.
* Creating multiple dynamic groups and adding zero, one or multiple instances to each of the dynamic groups.

Multiple combinations between the usescases above are possible/supported.

### Prerequisites
This module does not create any dependencies or prerequisites (these must be created prior to using this module):

* Mandatory(needs to exist before creating the IAM resources)
  * Required IAM construct to allow for the creation of resources

### Module inputs

#### `providers`

* This module supports custom provider. This is provided as when creating IAM resources you need to do this against the tenancy home region which might be different then the region used by the rest of your automation project.

You'll be managing those providers in the tf automation projects where you reference this module.

Example:

```
provider "oci" {
  tenancy_ocid     = "${var.tenancy_id}"
  user_ocid        = "${var.user_id}"
  fingerprint      = "${var.fingerprint}"
  private_key_path = "${var.private_key_path}"
  region           = "${var.region}"
}

```

* Bellow you can find the IAM attributes provided in the the `terraform.tfvars` file:

```
### TENANCY DETAILS

# Get this from the bottom of the OCI screen (after logging in, after Tenancy ID: heading)
tenancy_id="<tenancy OCID"
# Get this from OCI > Identity > Users (for your user account)
user_id="<user OCID>"

# the fingerprint can be gathered from your user account (OCI > Identity > Users > click your username > API Keys fingerprint (select it, copy it and paste it below))
fingerprint="<PEM key fingerprint>"
# this is the full path on your local system to the private key used for the API key pair
private_key_path="<path to the private key that matches the fingerprint above>"

# region (us-phoenix-1, ca-toronto-1, etc)
region="<your home region>"

```


#### `dynamic_groups`

* dynamic_groups input variable represents a map containing a collection of dynamic groups. Each dynamic goroup specifies the  attributes for a dynamic group, including a list of coresponding instances.


  * The automation creates the following resources with the following attributes:
    * `oci_identity_dynamic_group.dynamic_groups`:

| Attribute | Data Type | Required | Default Value | Valid Values | Description |
|---|---|---|---|---|---|
| provider | string | yes | "oci.oci_home"| string containing the name of the provider as defined by the automation that consumes this module | See the examples section in order to understand how to set the provider|
| count | number | yes | 0 | the number of resources to be created | the number of resources to be created |
| name | string | yes | "OCI-TF-Group" | string of the display name | Resource name |
| compartment\_id | string | yes | none | string of the compartment OCID | This is the OCID of the compartment |
| matching\_rule | list(string) | yes | none | a list of strings containing the OCIDs of instances to be part of this dynamic group | Ta list of strings containing the OCIDs of instances to be part of this dynamic group |
| description | string | no | N/A (no default) | The provided description |
| define\_tags | map(string) | no | N/A (no default) | The defined tags.
| freeform\_tags| map(string) | no | N/A (no default) | The freeform\_tags.



Example:

```
# Dynamic Groups Variable
dynamic_groups_config = {
  default_compartment_id = "<default_compartment_ocid>"
  default_defined_tags   = "<default_defined_tags>"
  default_freeform_tags  = "<default_freeform_tags>"
  dynamic_groups = {
    dynamic_group_1 = {
      compartment_id = "<specific_compartment_ocid>"
      description    = "Test Dynamic Group 1"
      instance_ids = ["ocid1.instance.oc1.phx.xxxxxx"]
      defined_tags   = "<specific_defined_tags>"
      freeform_tags  = "<specific_freeform_tags>"
    }
    dynamic_group_2 = {
      compartment_id = "<specific_compartment_ocid>"
      description    = "Test Dynamic Group 2"
      instance_ids = ["ocid1.instance.oc1.phx.yyyyyyy", "ocid1.instance.oc1.phx.zzzzz"]
      defined_tags   = "<specific_defined_tags>"
      freeform_tags  = "<specific_freeform_tags>"
    }
  }
}

```
The above example will create :
            * 2 dynamic groups, each dynamic group containing a list of instances

### Outputs

This module is returning 1 object and 3 objects maps:
* `dynamic_groups` - containes the details about each provisioned Dynamic Groups

## Getting Started

Several fully-functional examples have been provided in the `examples` directory.  

The scenarios covered in the examples section are:
* Creating a collection of Dynamic Groups, each Dynamic Group containing a list of instances.

## Accessing the Solution

This is a core service module that is foundational to many other resources in OCI, so there is really nothing to directly access.

## Summary

This serves as a foundational component in an OCI environment, providing the ability to provision File Storage Service instances.

## Notes/Issues


## URLs

* OCI IAM Dynamic Groups documentation: 
  * https://docs.cloud.oracle.com/iaas/Content/Identity/Tasks/managingdynamicgroups.htm

## Contributing

This project is open source. Oracle appreciates any contributions that are made by the open source community.

## Versions

This module has been developed and tested by running terraform on macOS Mojave Version 10.14.5

```
user-mac$ terraform --version
Terraform v0.12.3
+ provider.oci v3.31.0
```

## License

Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved.

Licensed under the Universal Permissive License 1.0.

See [LICENSE](LICENSE) for more details.
