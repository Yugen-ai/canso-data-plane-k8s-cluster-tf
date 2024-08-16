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
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.s3_bucket_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_lifecycle_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_versioning.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_acl"></a> [bucket\_acl](#input\_bucket\_acl) | ACL for the S3 bucket | `string` | `"private"` | no |
| <a name="input_buckets"></a> [buckets](#input\_buckets) | List of S3 bucket names | `list(string)` | n/a | yes |
| <a name="input_expiration_days"></a> [expiration\_days](#input\_expiration\_days) | Number of days before objects are expired (deleted) | `number` | `365` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Force destroy the S3 bucket and its contents when destroying the Terraform resource | `bool` | `false` | no |
| <a name="input_lifecycle_rule_enabled"></a> [lifecycle\_rule\_enabled](#input\_lifecycle\_rule\_enabled) | Enable lifecycle rule for the S3 bucket | `bool` | `true` | no |
| <a name="input_region"></a> [region](#input\_region) | region name | `string` | n/a | yes |
| <a name="input_tenant_name"></a> [tenant\_name](#input\_tenant\_name) | Unique name for the tenant | `string` | n/a | yes |
| <a name="input_transition_days"></a> [transition\_days](#input\_transition\_days) | Number of days before objects are transitioned to the specified storage class | `number` | `120` | no |
| <a name="input_transition_storage_class"></a> [transition\_storage\_class](#input\_transition\_storage\_class) | Storage class to transition objects to | `string` | `"GLACIER"` | no |
| <a name="input_versioning_enabled"></a> [versioning\_enabled](#input\_versioning\_enabled) | Enable versioning for the S3 bucket | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_s3_buckets_info"></a> [s3\_buckets\_info](#output\_s3\_buckets\_info) | n/a |
<!-- END_TF_DOCS -->