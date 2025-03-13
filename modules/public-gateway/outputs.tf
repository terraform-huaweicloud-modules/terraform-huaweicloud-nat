output "gateway_id" {
  description = "The ID of the public NAT gateway"

  value = try(huaweicloud_nat_gateway.this[0].id, "")
}
