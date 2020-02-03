# Copyright (c) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


# Dynamic Groups Variable
variable "dynamic_groups_config" {
  type = object({
    default_compartment_id = string,
    default_defined_tags   = map(string),
    default_freeform_tags  = map(string),
    dynamic_groups = map(object({
      compartment_id = string,
      description    = string,
      instance_ids   = list(string),
      defined_tags   = map(string),
      freeform_tags  = map(string)
    }))
  })
  description = "Parameters to provision zero, one or multiple dynamic groups"
}