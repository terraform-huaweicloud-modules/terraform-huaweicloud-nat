######################################################################
# Public configurations
######################################################################

variable "enterprise_project_id" {
  description = "Used to specify whether the resource is created under the enterprise project (this parameter is only valid for enterprise users)"

  type        = string
  default     = ""
}

######################################################################
# Configurations of NAT public gateway resource and related resources
######################################################################

variable "is_gateway_create" {
  description = "Controls whether a public NAT gateway should be created"

  type     = bool
  default  = true
  nullable = false
}

variable "gateway_vpc_id" {
  description = "The ID of the VPC to which the public NAT gateway belongs"

  type    = string
  default = ""
}

variable "gateway_subnet_id" {
  description = "The subnet ID of the downstream interface (the next hop of the DVR) of the public NAT gateway"

  type    = string
  default = ""
}

variable "gateway_name" {
  description = "The name of the public NAT gateway"

  type    = string
  default = ""
}

variable "gateway_specification" {
  description = "The specification of the public NAT gateway"

  type    = string
  default = ""
}

variable "gateway_description" {
  description = "The description of the public NAT gateway"

  type    = string
  default = ""
}

variable "gateway_ngport_ip_address" {
  description = "The IP address used for the NG port of the NAT gateway"

  type    = string
  default = ""
}

variable "gateway_tags" {
  description = "The key/value pairs to associate with the public NAT gateway"

  type    = map(string)
  default = {}
}

variable "gateway_charging_mode" {
  description = "The charging mode of the public NAT gateway"

  type    = string
  default = ""
}

variable "gateway_period_unit" {
  description = "The charging period unit of the public NAT gateway"

  type    = string
  default = ""
}

variable "gateway_period" {
  description = "The charging period number of the public NAT gateway"

  type    = string
  default = ""
}

variable "gateway_auto_renew" {
  description = "Whether auto-renew function of the public NAT gateway is enabled"

  type    = bool
  default = null
}

variable "dnat_rules_configuration" {
  description = "The configuration for the DNAT rule resources to which the public NAT gateway belongs"

  type = list(object({
    gateway_id                  = optional(string, "")
    floating_ip_id              = optional(string, "")
    global_eip_id               = optional(string, "")
    protocol                    = optional(string, "")
    internal_service_port       = optional(number, null)
    external_service_port       = optional(number, null)
    internal_service_port_range = optional(string, "")
    external_service_port_range = optional(string, "")
    port_id                     = optional(string, "")
    private_ip                  = optional(string, "")
    description                 = optional(string, "")
  }))
  default  = []
  nullable = false
}

variable "snat_rules_configuration" {
  description = "The configuration for the SNAT rule resources to which the public NAT gateway belongs"

  type = list(object({
    gateway_id     = optional(string, "")
    floating_ip_id = optional(string, "")
    global_eip_id  = optional(string, "")
    subnet_id      = optional(string, "")
    cidr           = optional(string, "")
    source_type    = optional(number, null)
    description    = optional(string, "")
  }))
  default  = []
  nullable = false
}
