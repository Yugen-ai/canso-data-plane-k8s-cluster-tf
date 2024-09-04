region            = "us-east-1"
iam_policy_name   = "canso-dplane-v1-airflow-policy"
iam_policy_policy = <<EOF
{
	"Statement": [
		{
			"Action": [
				"s3:*"
			],
			"Effect": "Allow",
			"Resource": [
				"arn:aws:s3:::*",
				"arn:aws:s3:::*/*"
			],
			"Sid": "Statement1"
		}
	],
	"Version": "2012-10-17"
}
EOF
iam_policy_tags = {
  Name       = "canso-dplane-v1-airflow-policy"
  Managed_by = "terraform"
}

############################### 
## IAM Irsa Role
###############################

create_role = true

role_name   = "canso-dplane-v1-airflow-irsa-role"
name_prefix = "canso-dplane-v1-airflow-irsa-role"

cluster_service_accounts = {
  "canso-dplane-v1" = ["airflow:airflow-sa", "canso-airflow-jobs:airflow-jobs-sa", "canso-airflow-jobs:default"]
  # Namespace airflow - https://github.com/Yugen-ai/canso-helm-charts/blob/a912ebd652a4d2869738c3a166a77c45e6659f6f/canso-data-plane/canso-aws-eks-superchart/values.yaml#L427
  # Namespace canso-airflow-jobs - https://github.com/Yugen-ai/canso-helm-charts/blob/a912ebd652a4d2869738c3a166a77c45e6659f6f/canso-data-plane/canso-aws-eks-superchart/values.yaml#L306
  # SA from Airflow - https://github.com/Yugen-ai/canso-helm-charts/blob/a912ebd652a4d2869738c3a166a77c45e6659f6f/canso-data-plane/canso-aws-eks-superchart/values.yaml#L312
  # SA from canso-airflow-jobs - https://github.com/Yugen-ai/canso-helm-charts/blob/a912ebd652a4d2869738c3a166a77c45e6659f6f/canso-data-plane/canso-aws-eks-superchart/templates/aws/canso-airflow-jobs.yaml#L45
}

tags = {
  Name       = "canso-dplane-v1-airflow-irsa-role"
  Managed_by = "terraform"
}
