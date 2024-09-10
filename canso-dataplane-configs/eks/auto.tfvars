region            = "us-east-1"
cluster_role_name = "canso-dplane-v1-cluster-role"
eks_cluster_name  = "canso-dplane-v1"
eks_cluster_tags = {
  Name = "canso-dplane-v1"
}
endpoint_private_access = true
endpoint_public_access  = true

subnet_ids = [
  "subnet-0bb63337022e4a2bb",
  "subnet-09ab07dfe04b6edca"
]
cluster_sg_name = "canso-dplane-v1-cluster-sg"
vpc_id          = "vpc-0f19d7ecde30feacc"
cluster_sg_tags = {
  Name = "canso-dplane-v1-cluster-sg"
}
k8s_version = "1.29"

####################### node group general #################
eks_node_role_name         = "canso-dplane-v1-node-role"
ami_type                   = "AL2_x86_64"
capacity_type              = "SPOT"
general_ng_disk_size       = 30
general_ng_instance_types  = ["t3.xlarge"]
general_ng_labels          = { "role" = "general" }
general_ng_node_group_name = "general"



general_ng_tags         = { "Environment" = "canso-dplane-v1-env", "Name" = "general" }
general_ng_k8s_version  = "1.29"
general_ng_desired_size = 3
general_ng_max_size     = 6
general_ng_min_size     = 1
general_ami_type        = "AL2_x86_64"
general_capacity_type   = "SPOT"

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
  rolearn: arn:aws:iam::605134474715:role/canso-dplane-v1-node-role
  username: system:node:{{EC2PrivateDNSName}}
EOF


iam_users_list = [
  "arn:aws:sts::605134474715:assumed-role/AWSReservedSSO_CansoDevs_0a8a5dc64b55dde6/mahantesh.shivagunde@yugen.ai",
  "arn:aws:sts::605134474715:assumed-role/AWSReservedSSO_CansoDevs_0a8a5dc64b55dde6/ashish.prajapati@yugen.ai",
  "arn:aws:sts::605134474715:assumed-role/AWSReservedSSO_CansoDevs_0a8a5dc64b55dde6/sandeep.mishra@yugen.ai",
  "arn:aws:sts::605134474715:assumed-role/AWSReservedSSO_CansoDevs_0a8a5dc64b55dde6/soumanta@yugen.ai"
]
