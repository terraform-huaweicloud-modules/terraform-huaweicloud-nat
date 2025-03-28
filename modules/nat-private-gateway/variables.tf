######################################################################
# Public configurations
######################################################################

variable "enterprise_project_id" {
  description = "Used to specify whether the resource is created under the enterprise project (this parameter is only valid for enterprise users)"

  type    = string
  default = ""
}

######################################################################
# Configurations of NAT private gateway resource
######################################################################

variable "is_private_gateway_create" {
  description = "Controls whether a private NAT gateway should be created"

  type     = bool
  default  = true
  nullable = false
}

variable "private_gateway_subnet_id" {
  description = "The network ID of the subnet to which the private NAT gateway belongs"

  type    = string
  default = ""
}

variable "private_gateway_name" {
  description = "The name of the private NAT gateway"

  type    = string
  default = ""
}

variable "private_gateway_specification" {
  description = "The specification of the private NAT gateway"

  type    = string
  default = ""
}

variable "private_gateway_description" {
  description = "The description of the private NAT gateway"

  type    = string
  default = ""
}

variable "private_gateway_tags" {
  description = "The key/value pairs to associate with the private NAT gateway"

  type    = map(string)
  default = {}
}

######################################################################
# Configurations of NAT transit IP resource
######################################################################

variable "is_transit_ip_create" {
  description = "Controls whether a transit IP should be created"

  type     = bool
  default  = true
  nullable = false
}

variable "transit_ip_subnet_id" {
  description = "The transit subnet ID to which the transit IP belongs"

  type    = string
  default = ""
}

variable "transit_ip_ip_address" {
  description = "The IP address of the transit subnet"

  type    = string
  default = ""
}

variable "transit_ip_tags" {
  description = "The key/value pairs to associate with the transit IP"

  type    = map(string)
  default = {}
}

######################################################################
# Configurations of NAT private DNAT rule resources
######################################################################

variable "private_dnat_rules_configuration" {
  description = "The configuration for the private DNAT rule resources associate with the private NAT gateway"

  type = list(object({
    gateway_id            = optional(string, "")
    transit_ip_id         = optional(string, "")
    transit_service_port  = optional(number, null)
    protocol              = optional(string, "")
    backend_interface_id  = optional(string, "")
    backend_private_ip    = optional(string, "")
    internal_service_port = optional(number, null)
    description           = optional(string, "")
  }))
  default  = []
  nullable = false
}

######################################################################
# Configurations of NAT private SNAT rule resources
######################################################################

variable "private_snat_rules_configuration" {
  description = "The configuration for the private SNAT rule resources associate with the private NAT gateway"

  type = list(object({
    gateway_id    = optional(string, "")
    transit_ip_id = optional(string, "")
    cidr          = optional(string, "")
    subnet_id     = optional(string, "")
    description   = optional(string, "")
  }))
  default  = []
  nullable = false
}
