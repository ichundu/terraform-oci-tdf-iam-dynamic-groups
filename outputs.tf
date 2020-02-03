# Copyright (c) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


#########################
## Dynamic Groups
#########################
output "dynamic_groups" {
  description = "The returned resource attributes for the Dynamic Groups."
  value = {
    for x in oci_identity_dynamic_group.dynamic_groups :
    x.name => { name = x.name,
      compartment_id = x.compartment_id
      defined_tags   = x.defined_tags
      description    = x.description
      freeform_tags  = x.freeform_tags
      id             = x.id
      matching_rule  = x.matching_rule
      state          = x.state
      time_created   = x.time_created
    }
  }
}

