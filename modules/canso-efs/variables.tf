variable "vpc_name" {
  description = "Name of the VPC to filter"
  type        = string
}

variable "region" {
  type        = string
  description = "enter region name"
}

variable "subnet_id_alpha1" {
  description = "Subnet ID for aws_efs_mount_target.alpha1"
  type        = string
}

variable "subnet_id_alpha2" {
  description = "Subnet ID for aws_efs_mount_target.alpha2"
  type        = string
}

variable "efs_name" {
  description = "Name for the AWS EFS file system"
  type        = string
}

variable "efs_sg_name" {
  description = "Name of EFS sg"
  type        = string
}
