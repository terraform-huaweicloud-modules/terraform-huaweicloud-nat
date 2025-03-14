provider "huaweicloud" {
  region = var.region_name
}

data "huaweicloud_availability_zones" "this" {}

module "nat_network" {
  source = "github.com/terraform-huaweicloud-modules/terraform-huaweicloud-vpc?ref=v1.2.0"

  enterprise_project_id = var.enterprise_project_id

  availability_zone = data.huaweicloud_availability_zones.this.names[0]

  vpc_name              = var.vpc_name
  vpc_cidr              = var.vpc_cidr
  subnets_configuration = var.subnets_configuration

  is_security_group_create = false
}

module "eip_publicip" {
  source = "github.com/terraform-huaweicloud-modules/terraform-huaweicloud-eip/modules/eip-publicip"

  enterprise_project_id = var.enterprise_project_id

  eip_publicip_configuration  = var.eip_publicip_configuration
  eip_bandwidth_configuration = var.eip_bandwidth_configuration
  eip_name                    = var.eip_name
}

module "nat_gateway" {
  source = "../../modules/nat-public-gateway"

  enterprise_project_id = var.enterprise_project_id

  gateway_vpc_id        = module.nat_network.vpc_id
  gateway_subnet_id     = try(element(module.nat_network.subnet_ids, 0), "")
  gateway_name          = var.gateway_name
  gateway_specification = var.gateway_specification

  snat_rules_configuration = [
    {
      floating_ip_id = module.eip_publicip.eip_id
      subnet_id      = try(element(module.nat_network.subnet_ids, 0), "")
    }
  ]
}
