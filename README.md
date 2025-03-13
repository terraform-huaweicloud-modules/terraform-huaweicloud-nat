# The Terraform module of HUAWEI Cloud NAT service

What capabilities does the current module provide:

+ Flexible NAT resource combination (through multiple NAT sub-modules)
+ Abundant example references, one-click deployment of NAT resources.

## Notes

If you want to manage NAT resources using Terraform module (via this repository), you need to make the following
declaration in the `source` of the script.

```hcl
# Use the latest version.
module "nat_public_gateway" {
  source = "github.com/terraform-huaweicloud-modules/terraform-huaweicloud-nat/modules/nat-public-gateway"

  ...
}
```

## Contributing

Report issues/questions/feature requests in the [issues](https://github.com/terraform-huaweicloud-modules/terraform-huaweicloud-nat/issues/new)
section.

Full contributing [guidelines are covered here](.github/how_to_contribute.md).

## Requirements

| Name | Version |
|------|---------|
| Terraform | >= 1.3.0 |
| Huaweicloud Provider | >= 1.73.0 |

## Modules

No module.

## Resources

No resource.

## Inputs

No input.

## Outputs

No output.
