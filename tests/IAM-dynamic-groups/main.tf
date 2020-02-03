# Copyright (c) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


locals {
  dynamic_groups_config = {
    default_compartment_id = var.compartment_id
    default_defined_tags   = {}
    default_freeform_tags  = null
    dynamic_groups = {
      dynamic_group_1 = {
        compartment_id = null
        description    = "Test Dynamic Group 1"
        instance_ids   = ["ocid1.instance.oc1.phx.atestinstance1"]
        defined_tags   = {}
        freeform_tags  = {}
      }
      dynamic_group_2 = {
        compartment_id = null
        description    = "Test Dynamic Group 2"
        instance_ids   = ["ocid1.instance.oc1.phx.testinstance2", "ocid1.instance.oc1.phx.testinstance3"]
        defined_tags   = {}
        freeform_tags  = null
      }
    }
  }
}

module "oci_iam_dynamic_groups" {

  source = "../../"

  providers = {
    oci.oci_home = "oci.home"
  }
  dynamic_groups_config = local.dynamic_groups_config



}

