resource "huaweicloud_nat_gateway" "this" {
  count = var.is_gateway_create ? 1 : 0

  enterprise_project_id = var.enterprise_project_id != "" ? var.enterprise_project_id : null

  vpc_id                    = var.gateway_vpc_id
  subnet_id                 = var.gateway_subnet_id
  name                      = var.gateway_name
  spec                      = var.gateway_specification
  description               = var.gateway_description != "" ? var.gateway_description : null
  ngport_ip_address         = var.gateway_ngport_ip_address != "" ? var.gateway_ngport_ip_address : null
  tags                      = var.gateway_tags

  charging_mode = var.gateway_charging_mode != "" ? var.gateway_charging_mode : null
  period_unit   = var.gateway_period_unit != "" ? var.gateway_period_unit : null
  period        = var.gateway_period != "" ? var.gateway_period : null
  auto_renew    = var.gateway_auto_renew

  lifecycle {
    precondition {
      condition     = var.gateway_vpc_id != ""
      error_message = "The gateway_vpc_id is required if the is_gateway_create is true."
    }
    precondition {
      condition     = var.gateway_subnet_id != ""
      error_message = "The gateway_subnet_id is required if the is_gateway_create is true."
    }
    precondition {
      condition     = var.gateway_name != ""
      error_message = "The gateway_name is required if the is_gateway_create is true."
    }
    precondition {
      condition     = var.gateway_specification != ""
      error_message = "The gateway_specification is required if the is_gateway_create is true."
    }
  }
}

resource "huaweicloud_nat_dnat_rule" "this" {
  count = length(var.dnat_rules_configuration)

  nat_gateway_id              = lookup(element(var.dnat_rules_configuration, count.index), "gateway_id", "") != "" ? lookup(element(var.dnat_rules_configuration,
    count.index), "gateway_id") : var.is_gateway_create ? huaweicloud_nat_gateway.this[0].id : ""
  floating_ip_id              = lookup(element(var.dnat_rules_configuration, count.index), "eip_id", "") != "" ? lookup(element(var.dnat_rules_configuration,
    count.index), "eip_id") : null
  global_eip_id               = lookup(element(var.dnat_rules_configuration, count.index), "global_eip_id", "") != "" ? lookup(element(var.dnat_rules_configuration,
    count.index), "global_eip_id") : null
  protocol                    = lookup(element(var.dnat_rules_configuration, count.index), "protocol", "") != "" ? lookup(element(var.dnat_rules_configuration,
    count.index), "protocol") : null
  internal_service_port       = lookup(element(var.dnat_rules_configuration, count.index), "internal_service_port", null)
  external_service_port       = lookup(element(var.dnat_rules_configuration, count.index), "external_service_port", null)
  internal_service_port_range = lookup(element(var.dnat_rules_configuration, count.index), "internal_service_port_range", "") != "" ? lookup(element(var.dnat_rules_configuration,
    count.index), "internal_service_port_range") : null
  external_service_port_range = lookup(element(var.dnat_rules_configuration, count.index), "external_service_port_range", "") != "" ? lookup(element(var.dnat_rules_configuration,
    count.index), "external_service_port_range") : null
  port_id                     = lookup(element(var.dnat_rules_configuration, count.index), "port_id", "") != "" ? lookup(element(var.dnat_rules_configuration,
    count.index), "port_id") : null
  private_ip                  = lookup(element(var.dnat_rules_configuration, count.index), "private_ip", "") != "" ? lookup(element(var.dnat_rules_configuration,
    count.index), "private_ip") : null
  description                 = lookup(element(var.dnat_rules_configuration, count.index), "description", "") != "" ? lookup(element(var.dnat_rules_configuration,
    count.index), "description") : null
}

resource "huaweicloud_nat_snat_rule" "this" {
  count = length(var.snat_rules_configuration)

  nat_gateway_id = lookup(element(var.snat_rules_configuration, count.index), "gateway_id", "") != "" ? lookup(element(var.dnat_rules_configuration,
    count.index), "gateway_id") : var.is_gateway_create ? huaweicloud_nat_gateway.this[0].id : ""
  floating_ip_id = lookup(element(var.snat_rules_configuration, count.index), "eip_id", "") != "" ? lookup(element(var.dnat_rules_configuration,
    count.index), "eip_id") : null
  global_eip_id  = lookup(element(var.snat_rules_configuration, count.index), "global_eip_id", "") != "" ? lookup(element(var.dnat_rules_configuration,
    count.index), "global_eip_id") : null
  subnet_id      = lookup(element(var.snat_rules_configuration, count.index), "subnet_id", "") != "" ? lookup(element(var.dnat_rules_configuration,
    count.index), "subnet_id") : null
  cidr           = lookup(element(var.snat_rules_configuration, count.index), "cidr", "") != "" ? lookup(element(var.dnat_rules_configuration,
    count.index), "cidr") : null
  source_type    = lookup(element(var.snat_rules_configuration, count.index), "source_type", null)
  description    = lookup(element(var.snat_rules_configuration, count.index), "description", "") != "" ? lookup(element(var.dnat_rules_configuration,
    count.index), "description") : null
}
