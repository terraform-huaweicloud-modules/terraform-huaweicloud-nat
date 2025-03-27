output "private_gateway_id" {
  description = "The ID of the private NAT gateway"

  value = try(huaweicloud_nat_private_gateway.this[0].id, "")
}

output "transit_ip_id" {
  description = "The ID of the transit IP"

  value = try(huaweicloud_nat_private_transit_ip.this[0].id, "")
}

output "private_dnat_rules_configuration" {
  description = "The basic configuration list of the private DNAT rules"

  value = try([for o in huaweicloud_nat_private_dnat_rule.this : {
    "id" : o.id,
    "backend_private_ip" : o.backend_private_ip,
    "backend_type" : o.backend_type,
  }], [])
}

output "private_snat_rules_configuration" {
  description = "The basic configuration list of the private SNAT rules"

  value = try([for o in huaweicloud_nat_private_snat_rule.this : {
    "id" : o.id,
    "cidr": o.cidr,
    "transit_ip_address" : o.transit_ip_address,
  }], [])
}
