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
  "canso-dataplane-cluster" = ["spark-streaming-jobs:spark-operator-spark", "spark-streaming-ml-jobs:spark-operator-spark"]
  # TODO - Question re `spark-operator-spark` - To be resolved before PR merge.
  # Namespace - https://github.com/Yugen-ai/canso-helm-charts/blob/a912ebd652a4d2869738c3a166a77c45e6659f6f/canso-data-plane/canso-aws-eks-superchart/templates/aws/spark-operator.yaml#L6
  # Namespace - https://github.com/Yugen-ai/canso-helm-charts/blob/a912ebd652a4d2869738c3a166a77c45e6659f6f/canso-data-plane/canso-aws-eks-superchart/templates/aws/spark-operator.yaml#L17
  # SA from Spark Operator - https://github.com/kubeflow/spark-operator/blob/b8c901397c042dbaaa8ff5ab15d16181b4a325e7/charts/spark-operator-chart/templates/_helpers.tpl#L57-L66
}

tags = {
  Name       = "canso-dataplane-spark-s3-irsa-role"
  Managed_by = "terraform"
}
