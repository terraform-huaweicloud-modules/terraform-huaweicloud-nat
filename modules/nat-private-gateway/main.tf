resource "huaweicloud_nat_private_gateway" "this" {
  count = var.is_private_gateway_create ? 1 : 0

  enterprise_project_id = var.enterprise_project_id != "" ? var.enterprise_project_id : null

  subnet_id   = var.private_gateway_subnet_id
  name        = var.private_gateway_name
  spec        = var.private_gateway_specification
  description = var.private_gateway_description != "" ? var.private_gateway_description : null
  tags        = var.private_gateway_tags

  lifecycle {
    precondition {
      condition     = var.private_gateway_subnet_id != ""
      error_message = "The private_gateway_subnet_id is required if the is_private_gateway_create is true."
    }
    precondition {
      condition     = var.private_gateway_name != ""
      error_message = "The private_gateway_name is required if the is_private_gateway_create is true."
    }
    precondition {
      condition     = var.private_gateway_specification != ""
      error_message = "The private_gateway_specification is required if the is_private_gateway_create is true."
    }
  }
}

resource "huaweicloud_nat_private_transit_ip" "this" {
  count = var.is_transit_ip_create ? 1 : 0

  enterprise_project_id = var.enterprise_project_id != "" ? var.enterprise_project_id : null

  subnet_id  = var.transit_ip_subnet_id
  ip_address = var.transit_ip_ip_address != "" ? var.transit_ip_ip_address : null
  tags       = var.transit_ip_tags

  lifecycle {
    precondition {
      condition     = var.transit_ip_subnet_id != ""
      error_message = "The transit_ip_subnet_id is required if the is_transit_ip_create is true."
    }
  }
}

resource "huaweicloud_nat_private_dnat_rule" "this" {
  count = length(var.private_dnat_rules_configuration)

  gateway_id            = lookup(element(var.private_dnat_rules_configuration, count.index), "gateway_id", "") != "" ? lookup(element(var.private_dnat_rules_configuration,
    count.index), "gateway_id") : var.is_private_gateway_create ? huaweicloud_nat_private_gateway.this[0].id : ""
  transit_ip_id         = lookup(element(var.private_dnat_rules_configuration, count.index), "transit_ip_id", "") != "" ? lookup(element(var.private_dnat_rules_configuration,
    count.index), "transit_ip_id") : var.is_transit_ip_create ? huaweicloud_nat_private_transit_ip.this[0].id : ""
  transit_service_port  = lookup(element(var.private_dnat_rules_configuration, count.index), "transit_service_port", null)
  protocol              = lookup(element(var.private_dnat_rules_configuration, count.index), "protocol", "") != "" ? lookup(element(var.private_dnat_rules_configuration,
    count.index), "protocol") : null
  backend_interface_id  = lookup(element(var.private_dnat_rules_configuration, count.index), "backend_interface_id", "") != "" ? lookup(element(var.private_dnat_rules_configuration,
    count.index), "backend_interface_id") : null
  backend_private_ip    = lookup(element(var.private_dnat_rules_configuration, count.index), "backend_private_ip", "") != "" ? lookup(element(var.private_dnat_rules_configuration,
    count.index), "backend_private_ip") : null
  internal_service_port = lookup(element(var.private_dnat_rules_configuration, count.index), "internal_service_port", null)
  description           = lookup(element(var.private_dnat_rules_configuration, count.index), "description", "") != "" ? lookup(element(var.private_dnat_rules_configuration,
    count.index), "description") : null
}

resource "huaweicloud_nat_private_snat_rule" "this" {
  count = length(var.private_snat_rules_configuration)

  gateway_id    = lookup(element(var.private_snat_rules_configuration, count.index), "gateway_id", "") != "" ? lookup(element(var.private_snat_rules_configuration,
    count.index), "gateway_id") : var.is_private_gateway_create ? huaweicloud_nat_private_gateway.this[0].id : ""
  transit_ip_id = lookup(element(var.private_snat_rules_configuration, count.index), "transit_ip_id", "") != "" ? lookup(element(var.private_dnat_rules_configuration,
    count.index), "transit_ip_id") : var.is_transit_ip_create ? huaweicloud_nat_private_transit_ip.this[0].id : ""
  cidr          = lookup(element(var.private_snat_rules_configuration, count.index), "cidr", "") != "" ? lookup(element(var.private_snat_rules_configuration,
    count.index), "cidr") : null
  subnet_id     = lookup(element(var.private_snat_rules_configuration, count.index), "subnet_id", "") != "" ? lookup(element(var.private_snat_rules_configuration,
    count.index), "subnet_id") : null
  description   = lookup(element(var.private_snat_rules_configuration, count.index), "description", "") != "" ? lookup(element(var.private_snat_rules_configuration,
    count.index), "description") : null
}
