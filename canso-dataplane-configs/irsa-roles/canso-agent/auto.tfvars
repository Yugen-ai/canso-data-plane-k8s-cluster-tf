region            = "ap-south-1"
iam_policy_name   = "devagent-dataplane-policy"
iam_policy_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Resource": "arn:aws:iam::<control-plane-account-id>:role/CrossAccountSQSAccessRoleYugen"
        }
    ]
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
  "canso-dataplane-cluster" = ["canso-dataplane:canso-agent"]
}

tags = {
  Name       = "devagent-dataplane-irsa-role"
  Managed_by = "terraform"
}
