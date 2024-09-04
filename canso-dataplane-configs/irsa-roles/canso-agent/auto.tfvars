region            = "us-east-1"
iam_policy_name   = "canso-dplane-v1-devagent-policy"
iam_policy_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Resource": "arn:aws:iam::010928226648:role/CansoCrossAccountSQSAccessRole"
        }
    ]
}
EOF
iam_policy_tags = {
  Name       = "canso-dplane-v1-devagent-policy"
  Managed_by = "terraform"
}

############################### 
## IAM Irsa Role
###############################

create_role = true

role_name   = "canso-dplane-v1-devagent-irsa-role"
name_prefix = "canso-dplane-v1-devagent-irsa-role"

cluster_service_accounts = {
  "canso-dplane-v1" = ["canso-dataplane:canso-agent"]
}

tags = {
  Name       = "canso-dplane-v1-devagent-irsa-role"
  Managed_by = "terraform"
}
