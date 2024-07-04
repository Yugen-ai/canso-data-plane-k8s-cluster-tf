<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_efs_file_system.fs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource |
| [aws_efs_mount_target.alpha1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_efs_mount_target.alpha2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_security_group.nfs_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc.my_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_efs_name"></a> [efs\_name](#input\_efs\_name) | Name for the AWS EFS file system | `string` | n/a | yes |
| <a name="input_efs_sg_name"></a> [efs\_sg\_name](#input\_efs\_sg\_name) | Name of EFS sg | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | enter region name | `string` | n/a | yes |
| <a name="input_subnet_id_alpha1"></a> [subnet\_id\_alpha1](#input\_subnet\_id\_alpha1) | Subnet ID for aws\_efs\_mount\_target.alpha1 | `string` | n/a | yes |
| <a name="input_subnet_id_alpha2"></a> [subnet\_id\_alpha2](#input\_subnet\_id\_alpha2) | Subnet ID for aws\_efs\_mount\_target.alpha2 | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of the VPC to filter | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
<!-- END_TF_DOCS -->