output "gateway_id" {
  description = "The ID of the public NAT gateway"

  value = try(huaweicloud_nat_gateway.this[0].id, "")
}

output "dnat_rules_configuration" {
  description = "The basic configuration list of the DNAT rules"

  value = try([for o in huaweicloud_nat_snat_rule.this : {
    "id": o.id,
    "floating_ip_address": o.floating_ip_address,
    "global_eip_address": o.global_eip_address,
    "status": o.status,
  }], [])
}

output "snat_rules_configuration" {
  description = "The basic configuration list of the SNAT rules"

  value = try([for o in huaweicloud_nat_snat_rule.this : {
    "id": o.id,
    "floating_ip_address": o.floating_ip_address,
    "global_eip_address": o.global_eip_address,
    "status": o.status,
  }], [])
}
