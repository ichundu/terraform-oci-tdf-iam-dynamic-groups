# Copyright (c) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.




locals {

  #################
  # Dynamic Groups
  #################
  # default values

  default_dynamic_group = {
    compartment_id = null
    description    = "OCI Dynamic Group created with the OCI Core IAM Dymanic Groups Module"
    instance_ocids = []
    name           = "OCI-Dynamic-Group"
    defined_tags   = {}
    freeform_tags  = {}
  }
}

resource "oci_identity_dynamic_group" "dynamic_groups" {
  for_each = var.dynamic_groups_config != null ? (var.dynamic_groups_config.dynamic_groups != null ? var.dynamic_groups_config.dynamic_groups : {}) : {}
  #Required
  compartment_id = each.value.compartment_id != null ? each.value.compartment_id : (var.dynamic_groups_config.default_compartment_id != null ? var.dynamic_groups_config.default_compartment_id : local.default_dynamic_group.compartment_id)
  description    = each.value.description != null ? each.value.description : local.default_dynamic_group.description
  matching_rule  = length(each.value.instance_ids) > 0 ? "${format("%s %s %s", "any {", join(", ", formatlist("ALL {instance.id ='%s'}", each.value.instance_ids)), "}")}" : ""
  name           = each.key

  #Optional
  defined_tags  = each.value.defined_tags != null ? each.value.defined_tags : (var.dynamic_groups_config.default_defined_tags != null ? var.dynamic_groups_config.default_defined_tags : local.default_dynamic_group.defined_tags)
  freeform_tags = each.value.freeform_tags != null ? each.value.freeform_tags : (var.dynamic_groups_config.default_freeform_tags != null ? var.dynamic_groups_config.default_freeform_tags : local.default_dynamic_group.freeform_tags)
}



