# Public NAT gateway with an SNAT rule to access the EIP network

Configuration in this directory creates these resource:

+ A VPC
+ A subnet under the VPC
+ A public NAT gateway with the small type
+ An SNAT rule under the NAT gateway to access the EIP

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
| eip_publicip | [terraform-huaweicloud-vpc](https://github.com/terraform-huaweicloud-modules/terraform-huaweicloud-eip/modules/eip-publicip) | N/A |
| nat_gateway | [../../modules/nat-public-gateway](../../modules/nat-public-gateway/README.md) | N/A |
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
| subnets_configuration | The configuration for the subnet resources to which the VPC belongs | <pre>[<br>  {<br>    name: "VPC-Subnet-Test",<br>    cidr: "172.16.0.0/24",<br>    ipv6_enabled: false,<br>    dhcp_enabled: false<br>  }<br>]</pre> |
| eip_publicip_configuration | The configuration for the elastic IP | <pre>[<br>  {<br>    type: "5_bgp",<br>    ip_version: "4"<br>  }<br>]</pre> |
| eip_bandwidth_configuration | The bandwidth configuration for the elastic IP | <pre>[<br>  {<br>    share_type: "PER",<br>    name: "EIP-Bandwidth-Test",<br>    size: 5<br>  }<br>]</pre> |
| eip_name | The name of the elastic IP | `"EIP-IPv4-PublicIP-Test"` |
| gateway_name | The name of the public NAT gateway | `"NAT-GW-Test"` |
| gateway_specification | The specification of the public NAT gateway | `"1"` |
<!-- markdownlint-enable MD013 -->

## Outputs

| Name | Description |
|------|-------------|
| gateway_id | The ID of the public NAT gateway |
| snat_rules_configuration | The SNAT rule info under the public NAT gateway |
