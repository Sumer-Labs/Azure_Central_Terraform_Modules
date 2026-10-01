variable "name" {
  description = "Name of the Virtual Network."
  type        = string
}

variable "location" {
  description = "Azure region where the Virtual Network will be created."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group where the Virtual Network will be created."
  type        = string
}

variable "address_space" {
  description = "Address spaces for the Virtual Network."
  type        = list(string)

  validation {
    condition     = length(var.address_space) > 0
    error_message = "At least one VNet address space must be provided."
  }
}

variable "subnets" {
  description = <<-EOT
    Map of subnets to create inside the Virtual Network.

    Every subnet receives:
    - One dedicated Network Security Group.
    - One NSG-to-subnet association.

    NSG security rules are intentionally not managed
    by this module.
  EOT

  type = map(object({
    address_prefixes = list(string)
  }))

  default = {}
}

variable "tags" {
  description = "Tags applied to the Virtual Network and Network Security Groups."
  type        = map(string)
  default     = {}
}
