region            = "us-east-1"
iam_policy_name   = "canso-dplane-v1-efs-csi-policy"
iam_policy_policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "Statement1",
			"Effect": "Allow",
			"Action": [
				"elasticfilesystem:*"
			],
			"Resource": [
				"*"
			]
		}
	]
}
EOF
iam_policy_tags = {
  Name       = "canso-dplane-v1-efs-csi-policy"
  Managed_by = "terraform"
}

############################### 
## IAM IRSA Role
###############################

create_role = true

role_name   = "canso-dplane-v1-efs-csi-irsa-role"
name_prefix = "canso-dataplane-efs-csi-irsa-role"

cluster_service_accounts = {
  "canso-dplane-v1" = ["kube-system:efs-csi-driver-sa", "efs-driver:efs-csi-driver-sa"]
}

tags = {
  Name       = "canso-dplane-v1-efs-csi-irsa-role"
  Managed_by = "terraform"
}
