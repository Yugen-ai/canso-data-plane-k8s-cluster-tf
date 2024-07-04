region            = "ap-south-1"
iam_policy_name   = "canso-dataplane-external-secrets-prod-policy"
iam_policy_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "secretsmanager:GetResourcePolicy",
                "secretsmanager:GetSecretValue",
                "secretsmanager:DescribeSecret",
                "secretsmanager:ListSecretVersionIds",
                "secretsmanager:ListSecrets"
            ],
            "Resource": [
                "arn:aws:secretsmanager:us-east-1:637423587367:secret:*",
                "arn:aws:secretsmanager:ap-south-1:637423587367:secret:*"
            ]
        }
    ]
}
EOF
iam_policy_tags = {
  Name       = "canso-dataplane-external-secrets-prod-policy"
  Managed_by = "terraform"
}

############################### 
## IAM Irsa Role
###############################

create_role = true

role_name   = "canso-dataplane-external-secrets-prod-irsa-role"
name_prefix = "canso-dataplane-external-secrets-prod-irsa-role"

cluster_service_accounts = {
  "canso-dataplane-cluster" = ["external-secrets:external-secrets-sa", "default:ext-rol-sa"]
}

tags = {
  Name       = "canso-dataplane-external-secrets-prod-irsa-role"
  Managed_by = "terraform"
}
