# Private NAT Gateway management

Manages the private NAT gateway resource.

## Notes

### How to import resources in the module structure

If you want to manage an existing private NAT gateway using Terraform (otherwise why are you reading this?) you need to
make sure that the corresponding module script has been defined in your `.tf` file, like this:

```hcl
# Manages a private NAT gateway.
module "nat_private_gateway" {
  source = "github.com/terraform-huaweicloud-modules/terraform-huaweicloud-nat/modules/nat-private-gateway"

  ...
}
```

Then, execute the following command to import the corresponding resource into the management of the `.tfstate` file.

```bash
$ terraform import module.nat_private_gateway.huaweicloud_nat_private_gateway.this[0] "private_gateway_id"

module.nat_private_gateway.huaweicloud_nat_private_gateway.this[0]: Importing from ID "private_gateway_id"...
module.nat_private_gateway.huaweicloud_nat_private_gateway.this[0]: Import complete!
  Imported huaweicloud_nat_private_gateway (ID: private_gateway_id)
module.nat_private_gateway.huaweicloud_nat_private_gateway.this[0]: Refreshing state... (ID: private_gateway_id)

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

### What should we do before deploy this module example

Before manage NAT resources, the access key (AK, the corresponding environment name is `HW_ACCESS_KEY`) and the secret key (SK, the corresponding environment name is `HW_SECRET_KEY`) should be configured.

For the linux VM, you can configure the corresponding environment variables with the following commands:

```bash
$ export HW_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXX
$ export HW_SECRET_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

Refer to this [document](https://support.huaweicloud.com/intl/en-us/devg-apisign/api-sign-provide-aksk.html) for AK/SK information obtain.

## Contributing

Report issues/questions/feature requests in the [issues](https://github.com/terraform-huaweicloud-modules/terraform-huaweicloud-nat/issues/new)
section.

Full contributing [guidelines are covered here](../../.github/how_to_contribute.md).

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
| huaweicloud_nat_private_gateway.this | resource |
| huaweicloud_nat_private_transit_ip.this | resource |
| huaweicloud_nat_private_snat_rule.this | resource |
| huaweicloud_nat_private_dnat_rule.this | resource |

## Inputs

<!-- markdownlint-disable MD013 -->
| Name | Description | Type | Default | Required |
|------|-------------|------|:-------:|:--------:|
| enterprise_project_id | Used to specify whether the resource is created under the enterprise project (this parameter is only valid for enterprise users) | `string` | `""` | N |
| is_private_gateway_create | Controls whether a private NAT gateway should be created | `bool` | `true` | N |
| private_gateway_subnet_id | The network ID of the subnet to which the private NAT gateway belongs | `string` | `""` | Y (Unless is_private_gateway_create is specified as false) |
| private_gateway_name | The name of the private NAT gateway | `string` | `""` | Y (Unless is_private_gateway_create is specified as false) |
| private_gateway_specification | The specification of the private NAT gateway | `string` | `""` | Y (Unless is_private_gateway_create is specified as false) |
| private_gateway_description | The description of the private NAT gateway | `string` | `""` | N |
| private_gateway_tags | The key/value pairs to associate with the private NAT gateway | <pre>map(string)</pre> | <pre>{}</pre> | N |
| is_transit_ip_create | Controls whether a transit IP should be created | `bool` | `true` | N |
| transit_ip_subnet_id | The transit subnet ID to which the transit IP belongs | `string` | `""` | Y (Unless is_transit_ip_create is specified as false) |
| transit_ip_ip_address | The IP address of the transit subnet | `string` | `""` | N |
| transit_ip_tags | The key/value pairs to associate with the transit IP | <pre>map(string)</pre> | <pre>{}</pre> | N |
| private_dnat_rules_configuration | The configuration for the private DNAT rule resources associate with the private NAT gateway | <pre>list(object({<br>  gateway_id            = optional(string, "")<br>  transit_ip_id         = optional(string, "")<br>  transit_service_port  = optional(number, null)<br>  protocol              = optional(string, "")<br>  backend_interface_id  = optional(string, "")<br>  backend_private_ip    = optional(string, "")<br>  internal_service_port = optional(number, null)<br>  description           = optional(string, "")<br>}))</pre> | <pre>[]</pre> | N |
| private_snat_rules_configuration | The configuration for the private SNAT rule resources associate with the private NAT gateway | <pre>list(object({<br>  gateway_id    = optional(string, "")<br>  transit_ip_id = optional(string, "")<br>  cidr          = optional(string, "")<br>  subnet_id     = optional(string, "")<br>  description   = optional(string, "")<br>}))</pre> | <pre>[]</pre> | N |
<!-- markdownlint-enable MD013 -->

## Outputs

| Name | Description |
|------|-------------|
| private_gateway_id | The ID of the private NAT gateway |
| transit_ip_id | The ID of the transit IP |
| private_dnat_rules_configuration | The basic configuration list of the private DNAT rules |
| private_snat_rules_configuration | The basic configuration list of the private SNAT rules |
