provider "huaweicloud" {
  region = var.region_name
}

data "huaweicloud_availability_zones" "this" {}

module "vpc_network" {
  source = "github.com/terraform-huaweicloud-modules/terraform-huaweicloud-vpc?ref=v1.2.0"

  enterprise_project_id = var.enterprise_project_id

  availability_zone = try(data.huaweicloud_availability_zones.this.names[0], "")

  vpc_name              = var.vpc_name
  vpc_cidr              = var.vpc_cidr
  subnets_configuration = var.subnets_configuration

  is_security_group_create = false
}

module "nat_private_gateway" {
  source = "../../modules/nat-private-gateway"

  enterprise_project_id = var.enterprise_project_id

  private_gateway_subnet_id     = try(element(module.vpc_network.subnet_ids, 0), "")
  private_gateway_name          = var.private_gateway_name
  private_gateway_specification = var.private_gateway_specification

  is_transit_ip_create = false
}
