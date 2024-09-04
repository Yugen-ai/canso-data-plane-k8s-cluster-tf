region            = "us-east-1"
iam_policy_name   = "canso-dplane-v1-external-secrets-policy"
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
            "Resource": ["arn:aws:secretsmanager:us-east-1:605134474715:secret:*"]
        }
    ]
}
EOF
iam_policy_tags = {
  Name       = "canso-dplane-v1-external-secrets-policy"
  Managed_by = "terraform"
}

############################### 
## IAM Irsa Role
###############################

create_role = true

role_name   = "canso-dplane-v1-external-secrets-irsa-role"
name_prefix = "canso-dplane-v1-external-secrets-irsa-role"

cluster_service_accounts = {
  "canso-dplane-v1" = ["external-secrets:external-secrets-sa", "default:ext-rol-sa"]
}

tags = {
  Name       = "canso-dplane-v1-external-secrets-irsa-role"
  Managed_by = "terraform"
}
