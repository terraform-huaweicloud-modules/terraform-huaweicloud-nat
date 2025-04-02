# Private NAT gateway

Configuration in this directory creates a small type private NAT gateway.

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
| nat_private_gateway | [../../modules/nat-private-gateway](../../modules/nat-private-gateway/README.md) | N/A |
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
| vpc_cidr | The CIDR block of the VPC resource | `"192.168.0.0/24"` |
| subnets_configuration | The configuration for the subnet resources to which the VPC belongs | <pre>[<br>  {<br>    name: "VPC-Subnet-Test",<br>    cidr: "192.168.0.0/24",<br>    ipv6_enabled: false,<br>    dhcp_enabled: false<br>  }<br>]</pre> |
| private_gateway_name | The name of the private NAT gateway | `"NAT-Private-Gateway-Test"` |
| private_gateway_specification | The specification of the public NAT gateway | `"Small"` |
<!-- markdownlint-enable MD013 -->

## Outputs

| Name | Description |
|------|-------------|
| private_gateway_id | The ID of the private NAT gateway |
