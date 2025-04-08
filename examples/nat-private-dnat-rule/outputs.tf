output "security_group_id" {
  description = "The ID of the security group to which the ECS instance belongs"

  value = module.vpc_security_group.security_group_id
}

output "ecs_instance_id" {
  description = "The ID of the ECS instance"

  value = module.ecs_instance.instance_id
}

output "ecs_instance_private_ip" {
  description = "The private IP of the ECS instance"

  value = try(module.ecs_instance.instance_networks[0].fixed_ip_v4, "")
}

output "private_gateway_id" {
  description = "The ID of the private NAT gateway"

  value = module.nat_private_gateway.private_gateway_id
}

output "transit_ip_id" {
  description = "The ID of the transit IP"

  value = module.nat_private_gateway.transit_ip_id
}

output "dnat_rules_configuration" {
  description = "The basic configuration list of the SNAT rules"

  value = module.nat_private_gateway.private_dnat_rules_configuration
}
