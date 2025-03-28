output "private_gateway_id" {
  description = "The ID of the private NAT gateway"

  value = module.nat_private_gateway.private_gateway_id
}
