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
  "canso-dataplane-cluster" = ["airflow:ml-agents-dataplane", "airflow-jobs:airflow-jobs-sa", "airflow-jobs:default"]
}

tags = {
  Name       = "airflow-canso-dataplane-irsa-role"
  Managed_by = "terraform"
}
