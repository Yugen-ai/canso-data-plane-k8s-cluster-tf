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
| [aws_db_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_kms_secrets.creds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_secrets) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_creds_path"></a> [db\_creds\_path](#input\_db\_creds\_path) | Path to the encrypted DB credentials file | `string` | n/a | yes |
| <a name="input_db_instance_allocated_storage"></a> [db\_instance\_allocated\_storage](#input\_db\_instance\_allocated\_storage) | The amount of allocated storage for the RDS instance | `number` | n/a | yes |
| <a name="input_db_instance_auto_minor_version_upgrade"></a> [db\_instance\_auto\_minor\_version\_upgrade](#input\_db\_instance\_auto\_minor\_version\_upgrade) | Specifies whether minor engine upgrades are applied automatically to the DB instance during the maintenance window | `bool` | n/a | yes |
| <a name="input_db_instance_db_name"></a> [db\_instance\_db\_name](#input\_db\_instance\_db\_name) | The name of the initial database to be created when the DB instance is created | `string` | n/a | yes |
| <a name="input_db_instance_db_subnet_group_name"></a> [db\_instance\_db\_subnet\_group\_name](#input\_db\_instance\_db\_subnet\_group\_name) | The name of the DB subnet group to associate with this DB instance | `string` | n/a | yes |
| <a name="input_db_instance_delete_automated_backups"></a> [db\_instance\_delete\_automated\_backups](#input\_db\_instance\_delete\_automated\_backups) | Specifies whether to remove automated backups immediately after the DB instance is deleted | `bool` | n/a | yes |
| <a name="input_db_instance_deletion_protection"></a> [db\_instance\_deletion\_protection](#input\_db\_instance\_deletion\_protection) | Specifies whether this resource should have deletion protection enabled | `bool` | n/a | yes |
| <a name="input_db_instance_engine"></a> [db\_instance\_engine](#input\_db\_instance\_engine) | The name of the database engine to be used for this DB instance | `string` | n/a | yes |
| <a name="input_db_instance_engine_version"></a> [db\_instance\_engine\_version](#input\_db\_instance\_engine\_version) | The version number of the database engine to use | `string` | n/a | yes |
| <a name="input_db_instance_identifier"></a> [db\_instance\_identifier](#input\_db\_instance\_identifier) | The name of the RDS instance | `string` | n/a | yes |
| <a name="input_db_instance_instance_class"></a> [db\_instance\_instance\_class](#input\_db\_instance\_instance\_class) | The DB instance class to use | `string` | n/a | yes |
| <a name="input_db_instance_kms_key_id"></a> [db\_instance\_kms\_key\_id](#input\_db\_instance\_kms\_key\_id) | The ARN of the KMS key used to encrypt data in the DB instance | `string` | n/a | yes |
| <a name="input_db_instance_license_model"></a> [db\_instance\_license\_model](#input\_db\_instance\_license\_model) | The license model for the DB instance | `string` | n/a | yes |
| <a name="input_db_instance_multi_az"></a> [db\_instance\_multi\_az](#input\_db\_instance\_multi\_az) | Specifies whether the DB instance is a multiple Availability Zone deployment | `bool` | n/a | yes |
| <a name="input_db_instance_parameter_group_name"></a> [db\_instance\_parameter\_group\_name](#input\_db\_instance\_parameter\_group\_name) | The name of the DB parameter group to associate with this DB instance | `string` | n/a | yes |
| <a name="input_db_instance_port"></a> [db\_instance\_port](#input\_db\_instance\_port) | The port on which the DB accepts connections | `number` | n/a | yes |
| <a name="input_db_instance_storage_encrypted"></a> [db\_instance\_storage\_encrypted](#input\_db\_instance\_storage\_encrypted) | Specifies whether the DB instance is encrypted | `bool` | n/a | yes |
| <a name="input_db_instance_storage_type"></a> [db\_instance\_storage\_type](#input\_db\_instance\_storage\_type) | Specifies the storage type to be associated with the DB instance | `string` | n/a | yes |
| <a name="input_db_instance_tags"></a> [db\_instance\_tags](#input\_db\_instance\_tags) | A mapping of tags to assign to the resource | `map(string)` | n/a | yes |
| <a name="input_db_instance_vpc_security_group_ids"></a> [db\_instance\_vpc\_security\_group\_ids](#input\_db\_instance\_vpc\_security\_group\_ids) | A list of VPC security group IDs to associate with this DB instance | `list(string)` | n/a | yes |
| <a name="input_enable_subnet_group"></a> [enable\_subnet\_group](#input\_enable\_subnet\_group) | Flag to enable or disable the creation of DB subnet group | `bool` | n/a | yes |
| <a name="input_parameter_group_create"></a> [parameter\_group\_create](#input\_parameter\_group\_create) | Whether to create this resource or not? | `bool` | `true` | no |
| <a name="input_parameter_group_description"></a> [parameter\_group\_description](#input\_parameter\_group\_description) | The description of the DB parameter group | `string` | `null` | no |
| <a name="input_parameter_group_family"></a> [parameter\_group\_family](#input\_parameter\_group\_family) | The family of the DB parameter group | `string` | `null` | no |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | The name of the DB parameter group | `string` | `""` | no |
| <a name="input_parameter_group_parameters"></a> [parameter\_group\_parameters](#input\_parameter\_group\_parameters) | A list of DB parameter maps to apply | `list(map(string))` | `[]` | no |
| <a name="input_parameter_group_tags"></a> [parameter\_group\_tags](#input\_parameter\_group\_tags) | A mapping of tags to assign to the resource | `map(string)` | `{}` | no |
| <a name="input_region"></a> [region](#input\_region) | provider region | `string` | n/a | yes |
| <a name="input_security_group_create"></a> [security\_group\_create](#input\_security\_group\_create) | Whether to create this resource or not? | `bool` | `true` | no |
| <a name="input_security_group_description"></a> [security\_group\_description](#input\_security\_group\_description) | Description of the AWS security group | `string` | n/a | yes |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Name of the AWS security group | `string` | n/a | yes |
| <a name="input_security_group_tags"></a> [security\_group\_tags](#input\_security\_group\_tags) | Tags for the AWS security group | `map(string)` | n/a | yes |
| <a name="input_subnet_group_name"></a> [subnet\_group\_name](#input\_subnet\_group\_name) | Name of the DB subnet group | `string` | n/a | yes |
| <a name="input_subnet_group_tags"></a> [subnet\_group\_tags](#input\_subnet\_group\_tags) | Tags for the DB subnet group | `map(string)` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnet IDs for the DB subnet group | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC where the security group will be created | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->