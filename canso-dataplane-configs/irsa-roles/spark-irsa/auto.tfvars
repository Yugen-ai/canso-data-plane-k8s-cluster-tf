region            = "ap-south-1"
iam_policy_name   = "canso-dataplane-spark-s3-irsa-policy"
iam_policy_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "s3-object-lambda:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
iam_policy_tags = {
  Name       = "canso-dataplane-spark-s3-irsa-policy"
  Managed_by = "terraform"
}

############################### 
## IAM Irsa Role
###############################

create_role = true

role_name   = "canso-dataplane-spark-s3-irsa-role"
name_prefix = "canso-dataplane-spark-s3-irsa-role"

cluster_service_accounts = {
  "canso-dataplane-cluster" = ["streaming-jobs:spark-operator-spark"]
}

tags = {
  Name       = "canso-dataplane-spark-s3-irsa-role"
  Managed_by = "terraform"
}
