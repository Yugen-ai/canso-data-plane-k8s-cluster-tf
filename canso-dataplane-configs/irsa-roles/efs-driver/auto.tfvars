region            = "ap-south-1"
iam_policy_name   = "canso-dataplane-efs-csi-prod-policy"
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
  Name       = "canso-dataplane-efs-csi-prod-policy"
  Managed_by = "terraform"
}

############################### 
## IAM Irsa Role
###############################

create_role = true

role_name   = "canso-dataplane-efs-csi-prod-irsa-role"
name_prefix = "canso-dataplane-efs-csi-prod-irsa-role"

cluster_service_accounts = {
  "canso-dataplane-cluster" = ["kube-system:efs-csi-driver-sa", "efs-driver:efs-csi-driver-sa"]
}

tags = {
  Name       = "canso-dataplane-efs-csi-prod-irsa-role"
  Managed_by = "terraform"
}
