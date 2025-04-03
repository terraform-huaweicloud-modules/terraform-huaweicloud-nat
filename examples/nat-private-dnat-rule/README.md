# Example of configuring a private DNAT rule (the backend instance is ECS)

Configuration in this directory creates a private DNAT rule associate with the ECS instance.

## Usage

To run this example you need to execute:

```bash
terraform init
terraform plan -var-file=variables.json
terraform apply -var-file=variables.json
```

Run `terraform destroy -var-file=variables.json` when you don't need these resources.

## Requirements

| Name | Version |
|------|---------|
| Terraform | >= 1.3.0 |
| Huaweicloud Provider | >= 1.73.0 |
| Random Provider | >= 3.0.0 |

## Modules

<!-- markdownlint-disable MD013 -->
| Name | Source | Version |
|------|--------|---------|
| vpc_network | [terraform-huaweicloud-vpc](https://github.com/terraform-huaweicloud-modules/terraform-huaweicloud-vpc) | v1.2.0 |
| vpc_security_group | [terraform-huaweicloud-vpc](https://github.com/terraform-huaweicloud-modules/terraform-huaweicloud-vpc) | v1.2.0 |
| ecs_instance | [terraform-huaweicloud-ecs](https://github.com/terraform-huaweicloud-modules/terraform-huaweicloud-ecs) | N/A |
| nat_private_gateway | [../../modules/nat-private-gateway](../../modules/nat-private-gateway/README.md) | N/A |
<!-- markdownlint-enable MD013 -->

## Resources

| Name | Type |
|------|------|
| random_password.this | resource |
| data.huaweicloud_availability_zones.this | data source |

## Inputs

<!-- markdownlint-disable MD013 -->
| Name | Description | Value |
|------|-------------|-------|
| region_name | The region where the resources are located | `"cn-north-4"` |
| enterprise_project_id | Used to specify whether the resource is created under the enterprise project (this parameter is only valid for enterprise users) | `"0"` |
| vpc_network_configurations | The configuration VPCs and subnets to which the private NAT gateway or transit IP belongs | <pre>[<br>  {<br>    vpc_name: "VPC-Test",<br>    vpc_cidr: "192.168.0.0/16",<br>    subnets_configuration: [<br>      {<br>        name: "Subnet-Test",<br>        cidr: "192.168.0.0/24"<br>      }<br>    ]<br>  },<br>  {<br>    vpc_name: "VPC-Transit-IP-Used",<br>    vpc_cidr: "172.16.0.0/16",<br>    subnets_configuration: [<br>      {<br>        name: "Subnet-Transit-IP-Used",<br>        cidr: "172.16.0.0/24"<br>      }<br>    ]<br>  }<br>]</pre> |
| security_group_name | The name of the security group to which the ECS instance belongs | `"Security-Group-Test"` |
| instance_flavor_cpu_core_count | The CPU core number of the ECS instance flavor to be queried | `"4"` |
| instance_flavor_memory_size | The memory size of the ECS instance flavor to be queried | `"8"` |
| instance_image_os_type | The OS type of the IMS image to be queried that the ECS instance used | `"CentOS"` |
| instance_image_architecture | The architecture of the IMS image to be queried that the ECS instance used | `"x86"` |
| instance_name | The name of the ECS instance | `"ECS-Test"` |
| instance_disks_configuration | The disks configuration to attach to the ECS instance | <pre>[<br>  {<br>    is_system_disk: true,<br>    type: "SSD",<br>    size: 40<br>  }<br>]</pre> |
| private_gateway_name | The name of the private NAT gateway | `"Private-Gateway-Test"` |
| private_gateway_specification | The specification of the public NAT gateway | `"Small"` |
| private_dnat_rules_configuration | The protocol and port configuration for the private DNAT rule | <pre>[<br>  {<br>    protocol: "tcp",<br>    internal_service_port: 8088,<br>    transit_service_port: 8088<br>  }<br>]</pre> |
<!-- markdownlint-enable MD013 -->

## Outputs

| Name | Description |
|------|-------------|
| security_group_id | The ID of the security group to which the ECS instance belongs |
| ecs_instance_id | The ID of the ECS instance |
| ecs_instance_private_ip | The private IP of the ECS instance |
| private_gateway_id | The ID of the private NAT gateway |
| transit_ip_id | The ID of the transit IP |
| dnat_rules_configuration | The basic configuration list of the SNAT rules |
