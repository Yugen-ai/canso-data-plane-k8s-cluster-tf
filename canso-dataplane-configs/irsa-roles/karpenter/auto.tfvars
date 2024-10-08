region            = "ap-south-1"
iam_policy_name   = "canso-dataplane-karpenter-prod-policy"
iam_policy_policy = <<EOF
{
    "Statement": [
        {
            "Action": [
                "ssm:GetParameter",
                "iam:PassRole",
                "ec2:RunInstances",
                "ec2:DescribeSubnets",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeLaunchTemplates",
                "ec2:DescribeInstances",
                "ec2:DescribeInstanceTypes",
                "ec2:DescribeInstanceTypeOfferings",
                "ec2:DescribeAvailabilityZones",
                "ec2:DeleteLaunchTemplate",
                "ec2:CreateTags",
                "ec2:CreateLaunchTemplate",
                "ec2:CreateFleet",
                "pricing:*",
                "ec2:TerminateInstances",
                "ec2:DeleteLaunchTemplate",
                "ec2:RunInstances",
                "eks:DescribeCluster",
                "iam:PassRole",
                "ec2:DescribeSpotPriceHistory",
                "ec2:DescribeImages",
                "iam:GetInstanceProfile",
                "iam:CreateInstanceProfile",
                "iam:AddRoleToInstanceProfile",
                "iam:ListInstanceProfileTags",
                "iam:ListInstanceProfilesForRole",
                "iam:ListInstanceProfiles",
                "iam:RemoveRoleFromInstanceProfile",
                "iam:DeleteInstanceProfile",
                "iam:TagInstanceProfile",
                "iam:UntagInstanceProfile"
            ],
            "Effect": "Allow",
            "Resource": "*",
            "Sid": "Karpenter"
        },
        {
            "Action": "ec2:TerminateInstances",
            "Condition": {
                "StringLike": {
                    "ec2:ResourceTag/Name": "*karpenter*"
                }
            },
            "Effect": "Allow",
            "Resource": "*",
            "Sid": "ConditionalEC2Termination"
        }
    ],
    "Version": "2012-10-17"
}
EOF
iam_policy_tags = {
  Name       = "canso-dataplane-karpenter-prod-policy"
  Managed_by = "terraform"
}

############################### 
## IAM Irsa Role
###############################

create_role = true

role_name   = "canso-dataplane-karpenter-prod-irsa-role"
name_prefix = "canso-dataplane-karpenter-prod-irsa-role"

cluster_service_accounts = {
  "canso-dataplane-cluster" = ["karpenter:karpenter"]
}

tags = {
  Name       = "canso-dataplane-karpenter-prod-irsa-role"
  Managed_by = "terraform"
}
