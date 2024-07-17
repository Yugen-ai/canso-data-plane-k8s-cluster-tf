region            = "ap-south-1"
iam_policy_name   = "airflow-canso-dataplane-policy"
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
  Name       = "airflow-canso-dataplane-policy"
  Managed_by = "terraform"
}

############################### 
## IAM Irsa Role
###############################

create_role = true

role_name   = "airflow-canso-dataplane-irsa-role"
name_prefix = "airflow-canso-dataplane-irsa-role"

cluster_service_accounts = {
  "canso-dataplane-cluster" = ["airflow:airflow-sa", "canso-airflow-jobs:airflow-jobs-sa", "canso-airflow-jobs:default"]
  # Namespace airflow - https://github.com/Yugen-ai/canso-helm-charts/blob/a912ebd652a4d2869738c3a166a77c45e6659f6f/canso-data-plane/canso-aws-eks-superchart/values.yaml#L427
  # Namespace canso-airflow-jobs - https://github.com/Yugen-ai/canso-helm-charts/blob/a912ebd652a4d2869738c3a166a77c45e6659f6f/canso-data-plane/canso-aws-eks-superchart/values.yaml#L306
  # SA from Airflow - https://github.com/Yugen-ai/canso-helm-charts/blob/a912ebd652a4d2869738c3a166a77c45e6659f6f/canso-data-plane/canso-aws-eks-superchart/values.yaml#L312
  # SA from canso-airflow-jobs - https://github.com/Yugen-ai/canso-helm-charts/blob/a912ebd652a4d2869738c3a166a77c45e6659f6f/canso-data-plane/canso-aws-eks-superchart/templates/aws/canso-airflow-jobs.yaml#L45
}

tags = {
  Name       = "airflow-canso-dataplane-irsa-role"
  Managed_by = "terraform"
}
