region            = "ap-south-1"
cluster_role_name = "canso-dataplane-cluster-role"
eks_cluster_name  = "canso-dataplane-cluster"
eks_cluster_tags = {
  Name = "canso-dataplane-cluster"
}
endpoint_private_access = true
endpoint_public_access  = true

subnet_ids = [
  "subnet-xxxxxxxxxxxxxxxxx",
  "subnet-xxxxxxxxxxxxxxxxx"
]
cluster_sg_name = "canso-dataplane-cluster-cluster-sg"
vpc_id          = "vpc-xxxxxxxxxxxxxxxxx"
cluster_sg_tags = {
  Name = "canso-dataplane-cluster-cluster-sg"
}
k8s_version           = "1.29"
alb_security_group_id = "sg-xxxxxxxxxxxxxxxxxx"

####################### node group general #################
eks_node_role_name         = "canso-dataplane-cluster-node-role"
ami_type                   = "AL2_x86_64"
capacity_type              = "ON_DEMAND"
general_ng_disk_size       = 30
general_ng_instance_types  = ["t3.medium"]
general_ng_labels          = { "role" = "general" }
general_ng_node_group_name = "general"



general_ng_tags         = { "Environment" = "prod", "Name" = "general" }
general_ng_k8s_version  = "1.29"
general_ng_desired_size = 6
general_ng_max_size     = 7
general_ng_min_size     = 1
general_ami_type        = "AL2_x86_64"
general_capacity_type   = "ON_DEMAND"

############ aws auth config map ##################


map_user_string_admin = <<EOF
- userarn: %s
  username: admin
  groups:
    - system:masters
EOF

map_role_string_admin = <<EOF
- groups:
  - system:bootstrappers
  - system:nodes
  rolearn: arn:aws:iam::<account_id>:role/<role_name>
  username: system:node:{{EC2PrivateDNSName}}
EOF


iam_users_list = [
  "arn:aws:iam::<account_id>:user/<username1>",
  "arn:aws:iam::<account_id>:user/<username2>"
]
