<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eks_cluster.demo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_eks_node_group.general](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [aws_iam_openid_connect_provider.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_role.demo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.nodes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.demo-AmazonEKSClusterPolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.nodes-AmazonSSMManagedInstanceCore](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.cluster_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [kubernetes_config_map_v1_data.aws-auth](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map_v1_data) | resource |
| [aws_eks_cluster_auth.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |
| [tls_certificate.eks](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_type"></a> [ami\_type](#input\_ami\_type) | ami\_type | `string` | n/a | yes |
| <a name="input_capacity_type"></a> [capacity\_type](#input\_capacity\_type) | capacity\_type | `string` | n/a | yes |
| <a name="input_cluster_role_name"></a> [cluster\_role\_name](#input\_cluster\_role\_name) | cluster\_role\_name | `string` | n/a | yes |
| <a name="input_cluster_sg_name"></a> [cluster\_sg\_name](#input\_cluster\_sg\_name) | cluster\_sg\_name | `string` | n/a | yes |
| <a name="input_cluster_sg_tags"></a> [cluster\_sg\_tags](#input\_cluster\_sg\_tags) | cluster\_sg\_tags | `map(string)` | n/a | yes |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | eks\_cluster\_name | `string` | n/a | yes |
| <a name="input_eks_cluster_tags"></a> [eks\_cluster\_tags](#input\_eks\_cluster\_tags) | eks cluster tags | `map(string)` | n/a | yes |
| <a name="input_eks_node_role_name"></a> [eks\_node\_role\_name](#input\_eks\_node\_role\_name) | eks\_node\_role\_names | `string` | n/a | yes |
| <a name="input_endpoint_private_access"></a> [endpoint\_private\_access](#input\_endpoint\_private\_access) | endpoint\_private\_access | `string` | n/a | yes |
| <a name="input_endpoint_public_access"></a> [endpoint\_public\_access](#input\_endpoint\_public\_access) | endpoint\_public\_access | `string` | n/a | yes |
| <a name="input_general_ami_type"></a> [general\_ami\_type](#input\_general\_ami\_type) | general\_ami\_type | `string` | n/a | yes |
| <a name="input_general_capacity_type"></a> [general\_capacity\_type](#input\_general\_capacity\_type) | general\_capacity\_type | `string` | n/a | yes |
| <a name="input_general_ng_desired_size"></a> [general\_ng\_desired\_size](#input\_general\_ng\_desired\_size) | general\_ng\_desired\_size | `string` | n/a | yes |
| <a name="input_general_ng_disk_size"></a> [general\_ng\_disk\_size](#input\_general\_ng\_disk\_size) | general\_ng\_disk\_size | `string` | n/a | yes |
| <a name="input_general_ng_instance_types"></a> [general\_ng\_instance\_types](#input\_general\_ng\_instance\_types) | n/a | `list(string)` | `[]` | no |
| <a name="input_general_ng_k8s_version"></a> [general\_ng\_k8s\_version](#input\_general\_ng\_k8s\_version) | general\_ng\_k8s\_version | `string` | n/a | yes |
| <a name="input_general_ng_labels"></a> [general\_ng\_labels](#input\_general\_ng\_labels) | n/a | `map(string)` | `{}` | no |
| <a name="input_general_ng_max_size"></a> [general\_ng\_max\_size](#input\_general\_ng\_max\_size) | general\_ng\_max\_size | `string` | n/a | yes |
| <a name="input_general_ng_min_size"></a> [general\_ng\_min\_size](#input\_general\_ng\_min\_size) | general\_ng\_min\_size | `string` | n/a | yes |
| <a name="input_general_ng_node_group_name"></a> [general\_ng\_node\_group\_name](#input\_general\_ng\_node\_group\_name) | n/a | `any` | n/a | yes |
| <a name="input_general_ng_tags"></a> [general\_ng\_tags](#input\_general\_ng\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_iam_users_list"></a> [iam\_users\_list](#input\_iam\_users\_list) | List of users for admin access to cluster | `list(string)` | n/a | yes |
| <a name="input_k8s_version"></a> [k8s\_version](#input\_k8s\_version) | k8s\_version | `string` | n/a | yes |
| <a name="input_map_role_string_admin"></a> [map\_role\_string\_admin](#input\_map\_role\_string\_admin) | map\_role\_string\_admin | `string` | n/a | yes |
| <a name="input_map_user_string_admin"></a> [map\_user\_string\_admin](#input\_map\_user\_string\_admin) | map\_user\_string\_admin | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | region name | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | subnet\_ids | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | vpc\_id | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->