############################### 
## AWS IAM Roles
###############################

resource "aws_iam_role" "demo" {
  name = var.cluster_role_name

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

############################### 
## AWS IAM Role Policy
###############################

resource "aws_iam_role_policy_attachment" "demo-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.demo.name
}

############################### 
## AWS EKS Cluster
###############################

resource "aws_eks_cluster" "demo" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.demo.arn
  version  = var.k8s_version

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
  ]
  tags = var.eks_cluster_tags


  vpc_config {

    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    public_access_cidrs = [
      "0.0.0.0/0",
    ]
    security_group_ids = [aws_security_group.cluster_sg.id]
    subnet_ids         = var.subnet_ids

  }
  depends_on = [aws_iam_role_policy_attachment.demo-AmazonEKSClusterPolicy, aws_security_group.cluster_sg]
}

resource "aws_security_group" "cluster_sg" {
  name        = var.cluster_sg_name
  description = "cluster security group"
  vpc_id      = var.vpc_id
  tags        = var.cluster_sg_tags

  dynamic "ingress" {
    for_each = var.vpc_ingress_rules
    content {
      description     = ingress.value.description
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      cidr_blocks     = ingress.value.cidr_blocks
      security_groups = ingress.value.security_groups
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group_rule" "additional_rules" {
  depends_on = [aws_eks_cluster.demo]
  count      = length(var.additional_security_group_rules)

  type                     = var.additional_security_group_rules[count.index].type
  from_port                = var.additional_security_group_rules[count.index].from_port
  to_port                  = var.additional_security_group_rules[count.index].to_port
  protocol                 = var.additional_security_group_rules[count.index].protocol
  security_group_id        = aws_eks_cluster.demo.vpc_config[0].cluster_security_group_id
  source_security_group_id = var.additional_security_group_rules[count.index].source_security_group_id
  description              = lookup(var.additional_security_group_rules[count.index], "description", null)
}

############################### 
## IAM Roles for Nodes
###############################

resource "aws_iam_role" "nodes" {
  name = var.eks_node_role_name

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

############################### 
## IAM Role Policies
###############################

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.nodes.name
}

############################### 
## EKS Node Group
###############################

resource "aws_eks_node_group" "general" {
  ami_type        = var.general_ami_type
  capacity_type   = var.general_capacity_type
  cluster_name    = var.eks_cluster_name
  disk_size       = var.general_ng_disk_size
  instance_types  = var.general_ng_instance_types
  labels          = var.general_ng_labels
  node_group_name = var.general_ng_node_group_name
  node_role_arn   = aws_iam_role.nodes.arn

  subnet_ids = var.subnet_ids
  tags       = var.general_ng_tags
  version    = var.general_ng_k8s_version

  scaling_config {
    desired_size = var.general_ng_desired_size
    max_size     = var.general_ng_max_size
    min_size     = var.general_ng_min_size
  }

  depends_on = [
    aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.nodes-AmazonSSMManagedInstanceCore,
    aws_eks_cluster.demo
  ]
}

############################### 
## IAM OpenID Connect
###############################

resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.demo.identity[0].oidc[0].issuer
  depends_on      = [aws_eks_cluster.demo]
}

############################### 
## AWS Auth (Users & Roles) 
############################### 

resource "kubernetes_config_map_v1_data" "aws-auth" {
  data = {
    "mapRoles" = var.map_role_string_admin
    "mapUsers" = join("", [for user in var.iam_users_list : format(var.map_user_string_admin, user)])
  }

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
  force      = true
  depends_on = [aws_eks_cluster.demo, aws_eks_node_group.general]
}
