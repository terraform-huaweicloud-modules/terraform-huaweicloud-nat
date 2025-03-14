# Public NAT gateway

Configuration in this directory creates a small type public NAT gateway.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan -var-file=variables.json
$ terraform apply -var-file=variables.json
```

Run `terraform destroy -var-file=variables.json` when you don't need these resources.

## Requirements

| Name | Version |
|------|---------|
| Terraform | >= 1.3.0 |
| Huaweicloud Provider | >= 1.73.0 |

## Modules

<!-- markdownlint-disable MD013 -->
| Name | Source | Version |
|------|--------|---------|
| vpc_network | [terraform-huaweicloud-vpc](https://github.com/terraform-huaweicloud-modules/terraform-huaweicloud-vpc) | v1.2.0 |
| nat_gateway | [../../modules/nat-gateway](../../modules/nat-gateway/README.md) | N/A |
<!-- markdownlint-enable MD013 -->

## Resources

| Name | Type |
|------|------|
| data.huaweicloud_availability_zones.this | data source |

## Inputs

<!-- markdownlint-disable MD013 -->
| Name | Description | Value |
|------|-------------|-------|
| region_name | The region where the resources are located | `"cn-north-4"` |
| enterprise_project_id | Used to specify whether the resource is created under the enterprise project (this parameter is only valid for enterprise users) | `"0"` |
| vpc_name | The name of the VPC resource | `"VPC-Test"` |
| vpc_cidr | The CIDR block of the VPC resource | `"172.16.0.0/24"` |
| subnets_configuration | The configuration for the subnet resources to which the VPC belongs | <pre>[<br>  {<br>    "name": "VPC-Subnet-Test",<br>    "cidr": "172.16.0.0/24",<br>    "ipv6_enabled": false,<br>    "dhcp_enabled": false<br>  }<br>]</pre> |
| gateway_name | The name of the public NAT gateway | `"NAT-GW-Test"` |
| gateway_specification | The specification of the public NAT gateway | `"1"` |
<!-- markdownlint-enable MD013 -->

## Outputs

| Name | Description |
|------|-------------|
| gateway_id | The ID of the public NAT gateway |
