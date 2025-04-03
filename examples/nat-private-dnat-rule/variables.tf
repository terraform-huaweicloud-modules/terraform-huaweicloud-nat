######################################################################
# Public configurations
######################################################################

variable "region_name" {
  type        = string
  description = "The region where the resources are located"
}

variable "enterprise_project_id" {
  type        = string
  description = "Used to specify whether the resource is created under the enterprise project (this parameter is only valid for enterprise users)"
}

######################################################################
# Configurations of VPC resource and related resources
######################################################################

variable "vpc_network_configurations" {
  type = list(object({
    vpc_name = string
    vpc_cidr = string

    subnets_configuration =list(object({
      name = string
      cidr = string
    }))
  }))

  description = "The configuration VPCs and subnets to which the private NAT gateway or transit IP belongs"
}

variable "security_group_name" {
  type        = string
  description = "The name of the security group to which the ECS instance belongs"
}

######################################################################
# Configurations of ECS resource and related resources
######################################################################

variable "instance_flavor_cpu_core_count" {
  type        = number
  description = "The CPU core number of the ECS instance flavor to be queried"
}

variable "instance_flavor_memory_size" {
  type        = number
  description = "The memory size of the ECS instance flavor to be queried"
}

variable "instance_image_os_type" {
  type        = string
  description = "The OS type of the IMS image to be queried that the ECS instance used"
}

variable "instance_image_architecture" {
  type        = string
  description = "The architecture of the IMS image to be queried that the ECS instance used"
}

variable "instance_name" {
  type        = string
  description = "The name of the ECS instance"
}

variable "instance_disks_configuration" {
  type = list(object({
    is_system_disk = bool
    name           = optional(string, "")
    type           = string
    size           = number
  }))

  description = "The disks configuration to attach to the ECS instance"
}

######################################################################
# Configurations of NAT private gateway resource and related resources
######################################################################

variable "private_gateway_name" {
  description = "The name of the private NAT gateway"

  type = string
}

variable "private_gateway_specification" {
  description = "The specification of the private NAT gateway"

  type = string
}

variable "private_dnat_rules_configuration" {
  type = list(object({
    protocol              = optional(string, "")
    internal_service_port = optional(number, null)
    transit_service_port  = optional(number, null)
  }))

  description = "The protocol and port configuration for the private DNAT rule"
}
