region            = "ap-south-1"
iam_policy_name   = "devagent-dataplane-policy"
iam_policy_policy = <<EOF
{
	"Statement": [
		{
			"Sid": "Statement1",
			"Effect": "Allow",
			"Action": [
				"sqs:*"
			],
			"Resource": [
				"*"
			]
		}
	],
	"Version": "2012-10-17"
}
EOF
iam_policy_tags = {
  Name       = "devagent-dataplane-policy"
  Managed_by = "terraform"
}

############################### 
## IAM Irsa Role
###############################

create_role = true

role_name   = "devagent-dataplane-irsa-role"
name_prefix = "devagent-dataplane-irsa-role"

cluster_service_accounts = {
  "canso-dataplane-cluster" = ["airflow:yp-agent-developer-agent"]
}

tags = {
  Name       = "devagent-dataplane-irsa-role"
  Managed_by = "terraform"
}
