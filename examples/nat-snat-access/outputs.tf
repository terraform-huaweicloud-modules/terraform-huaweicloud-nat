output "gateway_id" {
  description = "The ID of the public NAT gateway"

  value = module.nat_gateway.gateway_id
}

output "snat_rules_configuration" {
  description = "The basic configuration list of the SNAT rules"

  value = module.nat_gateway.snat_rules_configuration
}
