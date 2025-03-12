output "gateway_id" {
  description = "The ID of the public NAT gateway"

  value = module.nat_gateway.gateway_id
}
