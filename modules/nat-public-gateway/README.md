# Public NAT Gateway management

Manages the public NAT gateway resource.

## Notes

If you want to manage an existing public NAT gateway using Terraform (otherwise why are you reading this?) you need to
import this resource like this:

```bash
$ terraform import module.nat-gateway.huaweicloud_nat_gateway.this[0] "gateway_id"

module.nat-gateway.huaweicloud_nat_gateway.this[0]: Importing from ID "gateway_id"...
module.nat-gateway.huaweicloud_nat_gateway.this[0]: Import complete!
  Imported huaweicloud_nat_gateway (ID: gateway_id)
module.nat-gateway.huaweicloud_nat_gateway.this[0]: Refreshing state... (ID: gateway_id)

Import successful!
```

Before manage NAT resources, the access key (AK, the corresponding environment name is `HW_ACCESS_KEY`) and the secret key (SK, the corresponding environment name is `HW_SECRET_KEY`) should be configured.

Refer to this [document](https://support.huaweicloud.com/intl/en-us/devg-apisign/api-sign-provide-aksk.html) for AK/SK information obtain.

## Contributing

Report issues/questions/feature requests in the [issues](https://github.com/terraform-huaweicloud-modules/terraform-huaweicloud-nat/issues/new)
section.

Full contributing [guidelines are covered here](../../github/how_to_contribute.md).

## Requirements

| Name | Version |
|------|---------|
| Terraform | >= 1.3.0 |
| Huaweicloud Provider | >= 1.73.0 |

## Modules

No module.

## Resources

| Name | Type |
|------|------|
| huaweicloud_nat_gateway.this | resource |
| huaweicloud_nat_snat_rule.this | resource |
| huaweicloud_nat_dnat_rule.this | resource |

## Inputs

<!-- markdownlint-disable MD013 -->
| Name | Description | Type | Default | Required |
|------|-------------|------|:-------:|:--------:|
| enterprise_project_id | Used to specify whether the resource is created under the enterprise project (this parameter is only valid for enterprise users) | `string` | `""` | N |
| is_gateway_create | Controls whether a public NAT gateway should be created | `bool` | `true` | N |
| gateway_vpc_id | The ID of the VPC to which the public NAT gateway belongs | `string` | `""` | Y (Unless is_gateway_create is specified as false) |
| gateway_subnet_id | The subnet ID of the downstream interface (the next hop of the DVR) of the public NAT gateway | `string` | `""` | Y (Unless is_gateway_create is specified as false) |
| gateway_name | The name of the public NAT gateway | `string` | `""` | Y (Unless is_gateway_create is specified as false) |
| gateway_specification | The specification of the public NAT gateway | `string` | `""` | Y (Unless is_gateway_create is specified as false) |
| gateway_description | The description of the public NAT gateway | `string` | `""` | N |
| gateway_ngport_ip_address | The IP address used for the NG port of the NAT gateway | `string` | `""` | N |
| gateway_tags | The key/value pairs to associate with the public NAT gateway | <pre>map(string)</pre> | <pre>{}</pre> | N |
| gateway_charging_mode | The charging mode of the public NAT gateway | `string` | `""` | N |
| gateway_period_unit | The charging period unit of the public NAT gateway | `string` | `""` | N |
| gateway_period | The charging period number of the public NAT gateway | `string` | `""` | N |
| gateway_auto_renew | Whether auto-renew function of the public NAT gateway is enabled | `bool` | `null` | N |
| dnat_rules_configuration | The configuration for the DNAT rule resources to which the public NAT gateway belongs | <pre>list(object({<br>  dnat_rule_gateway_id                  = optional(string, "")<br>  dnat_rule_eip_id                      = optional(string, "")<br>  dnat_rule_global_eip_id               = optional(string, "")<br>  dnat_rule_protocol                    = optional(string, "")<br>  dnat_rule_internal_service_port       = optional(number, null)<br>  dnat_rule_external_service_port       = optional(number, null)<br>  dnat_rule_internal_service_port_range = optional(string, "")<br>  dnat_rule_external_service_port_range = optional(string, "")<br>  dnat_rule_port_id                     = optional(string, "")<br>  dnat_rule_private_ip                  = optional(string, "")<br>  dnat_rule_description                 = optional(string, "")<br>}))</pre> | <pre>[]</pre> |
| snat_rules_configuration | The configuration for the SNAT rule resources to which the public NAT gateway belongs | <pre>list(object({<br>  snat_rule_gateway_id    = optional(string, "")<br>  snat_rule_eip_id        = optional(string, "")<br>  snat_rule_global_eip_id = optional(string, "")<br>  snat_rule_subnet_id     = optional(string, "")<br>  snat_rule_cidr          = optional(string, "")<br>  snat_rule_source_type   = optional(number, null)<br>  snat_rule_description   = optional(string, "")<br>}))</pre> | <pre>[]</pre> | N |
<!-- markdownlint-enable MD013 -->

## Outputs

| Name | Description |
|------|-------------|
| gateway_id | The ID of the public NAT gateway |
