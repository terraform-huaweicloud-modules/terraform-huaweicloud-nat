provider "huaweicloud" {
  region = var.region_name
}

resource "random_password" "this" {
  length           = 16
  special          = true
  min_numeric      = 1
  min_special      = 1
  min_lower        = 1
  min_upper        = 1
  override_special = "!#"
}

data "huaweicloud_availability_zones" "this" {}

module "vpc_network" {
  for_each = { for index, config in var.vpc_network_configurations : index => config }

  source = "github.com/terraform-huaweicloud-modules/terraform-huaweicloud-vpc?ref=v1.2.0"

  enterprise_project_id = var.enterprise_project_id
  availability_zone     = try(data.huaweicloud_availability_zones.this.names[0], "")

  vpc_name              = each.value.vpc_name
  vpc_cidr              = each.value.vpc_cidr
  subnets_configuration = each.value.subnets_configuration

  is_security_group_create = false
}

module "vpc_security_group" {
  source = "github.com/terraform-huaweicloud-modules/terraform-huaweicloud-vpc?ref=v1.2.0"

  is_vpc_create = false

  security_group_name = var.security_group_name
}

module "ecs_instance" {
  source = "github.com/terraform-huaweicloud-modules/terraform-huaweicloud-ecs"

  enterprise_project_id = var.enterprise_project_id
  availability_zone     = try(data.huaweicloud_availability_zones.this.names[0], "")

  instance_flavor_cpu_core_count = var.instance_flavor_cpu_core_count
  instance_flavor_memory_size    = var.instance_flavor_memory_size
  instance_image_os_type         = var.instance_image_os_type
  instance_image_architecture    = var.instance_image_architecture
  instance_name                  = var.instance_name

  instance_admin_pass         = random_password.this.result
  instance_security_group_ids = [module.vpc_security_group.security_group_id]

  use_inside_data_disks_configuration = true
  instance_disks_configuration        = var.instance_disks_configuration

  instance_networks_configuration = try(module.vpc_network[0].subnet_ids[0], "") != "" ? [
    {
      uuid = module.vpc_network[0].subnet_ids[0]
    }
  ] : []
}

module "nat_private_gateway" {
  source = "../../modules/nat-private-gateway"

  enterprise_project_id = var.enterprise_project_id

  private_gateway_subnet_id     = try(element(module.vpc_network[0].subnet_ids, 0), "")
  private_gateway_name          = var.private_gateway_name
  private_gateway_specification = var.private_gateway_specification

  transit_ip_subnet_id = try(element(module.vpc_network[1].subnet_ids, 0), "")
  
  private_dnat_rules_configuration = [ for v in var.private_dnat_rules_configuration :
    {
      backend_interface_id  = try(module.ecs_instance.instance_networks[0].port, "")
      protocol              = v.protocol
      internal_service_port = v.internal_service_port
      transit_service_port  = v.transit_service_port
    }
  ]
}
