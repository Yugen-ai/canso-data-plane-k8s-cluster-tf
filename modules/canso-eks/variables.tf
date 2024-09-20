variable "region" {
  description = "region name"
  type        = string
}

variable "cluster_role_name" {
  description = "cluster_role_name"
  type        = string
}

variable "eks_cluster_name" {
  description = "eks_cluster_name"
  type        = string
}

variable "eks_cluster_tags" {
  description = "eks cluster tags"
  type        = map(string)
}

variable "endpoint_private_access" {
  description = "endpoint_private_access"
  type        = string
}

variable "endpoint_public_access" {
  description = "endpoint_public_access"
  type        = string
}

variable "subnet_ids" {
  description = "subnet_ids"
  type        = list(string)
}

variable "cluster_sg_name" {
  description = "cluster_sg_name"
  type        = string
}

variable "vpc_id" {
  description = "vpc_id"
  type        = string
}

variable "cluster_sg_tags" {
  description = "cluster_sg_tags"
  type        = map(string)
}

variable "k8s_version" {
  description = "k8s_version"
  type        = string
}

variable "eks_node_role_name" {
  description = "eks_node_role_names"
  type        = string
}

variable "ami_type" {
  description = "ami_type"
  type        = string
}

variable "capacity_type" {
  description = "capacity_type"
  type        = string
}

variable "general_ng_disk_size" {
  description = "general_ng_disk_size"
  type        = string
}

variable "general_ng_instance_types" {
  type    = list(string)
  default = []
}

variable "general_ng_labels" {
  type    = map(string)
  default = {}
}

variable "general_ng_node_group_name" {}

variable "general_ng_tags" {
  type    = map(string)
  default = {}
}

variable "general_ng_k8s_version" {
  description = "general_ng_k8s_version"
  type        = string
}

variable "general_ng_desired_size" {
  description = "general_ng_desired_size"
  type        = string
}

variable "general_ng_max_size" {
  description = "general_ng_max_size"
  type        = string
}

variable "general_ng_min_size" {
  description = "general_ng_min_size"
  type        = string

}

variable "general_ami_type" {
  description = "general_ami_type"
  type        = string
}

variable "general_capacity_type" {
  description = "general_capacity_type"
  type        = string

}

variable "iam_users_list" {
  type        = list(string)
  description = "List of users for admin access to cluster"
}

variable "map_user_string_admin" {
  type        = string
  description = "map_user_string_admin"
  #default = ""
}

variable "map_role_string_admin" {
  description = "map_role_string_admin"
  type        = string
  #default = ""
}

#### Security group rules

variable "vpc_ingress_rules" {
  description = "List of ingress rules"
  type = list(object({
    description     = string
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = list(string)
    security_groups = list(string)
  }))
  default = []
}


variable "additional_security_group_rules" {
  description = "List of additional security group rules to create for other security groups"
  type = list(object({
    type                     = string
    from_port                = number
    to_port                  = number
    protocol                 = string
    source_security_group_id = string
    description              = optional(string)
  }))
  default = []
}

