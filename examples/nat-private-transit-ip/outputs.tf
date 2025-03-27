output "transit_ip_id" {
  description = "The ID of the transit IP"

  value = module.nat_private_transit_ip.transit_ip_id
}
