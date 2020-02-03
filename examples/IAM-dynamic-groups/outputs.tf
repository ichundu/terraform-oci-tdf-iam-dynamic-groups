# Copyright (c) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


#########################
## Dynamic Groups
#########################

output "dynamic_groups" {
  description = "dynamic_groups:"
  value       = module.oci_iam_dynamic_groups.dynamic_groups
}