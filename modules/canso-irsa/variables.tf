############################### 
## AWS IAM Policy
###############################

variable "create_policy" {
  description = "Whether to create the IAM policy"
  type        = bool
  default     = true
}

variable "iam_policy_name" {
  description = "The name of the policy"
  type        = string
  default     = ""
}

variable "iam_policy_path" {
  description = "The path of the policy in IAM"
  type        = string
  default     = "/"
}

variable "iam_policy_description" {
  description = "The description of the policy"
  type        = string
  default     = "IAM Policy"
}

variable "iam_policy_policy" {
  description = "The path of the policy in IAM (tpl file)"
  type        = string
  default     = ""
}

variable "iam_policy_tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

############################### 
## Irsa Role
###############################

variable "create_role" {
  description = "Whether to create a role"
  type        = bool
  default     = true
}

variable "role_name" {
  description = "Name of IAM role"
  type        = string
  default     = null
}

variable "role_path" {
  description = "Path of IAM role"
  type        = string
  default     = "/"
}

variable "role_permissions_boundary_arn" {
  description = "Permissions boundary ARN to use for IAM role"
  type        = string
  default     = ""
}

variable "role_description" {
  description = "IAM Role description"
  type        = string
  default     = ""
}

variable "role_name_prefix" {
  description = "IAM role name prefix"
  type        = string
  default     = null
}

variable "cluster_service_accounts" {
  description = "EKS cluster and k8s ServiceAccount pairs. Each EKS cluster can have multiple k8s ServiceAccount. See README for details"
  type        = map(list(string))
  default     = {}
}

variable "tags" {
  description = "A map of tags to add the the IAM role"
  type        = map(any)
  default     = {}
}

variable "force_detach_policies" {
  description = "Whether policies should be detached from this role when destroying"
  type        = bool
  default     = false
}

variable "max_session_duration" {
  description = "Maximum CLI/API session duration in seconds between 3600 and 43200"
  type        = number
  default     = 43200
}

variable "create_instance_profile" {
  description = "IAM create_instance_profile"
  type        = bool
  default     = false
}

variable "aws_iam_role_policy" {
  description = "IAM role policy name"
  type        = string
  default     = ""
}

variable "policy" {
  description = "The JSON policy for the IAM role"
  type        = string
  default     = ""
}

variable "create_aws_iam_role_policy" {
  description = "IAM role policy name"
  type        = bool
  default     = false
}

variable "statements" {
  description = "List of IAM statements composing the policy."
  type        = list(object({ actions = list(string), resources = list(string) }))
  default     = []
}

variable "region" {
  description = "region name"
  type        = string
}

variable "managed_policy_arns" {
  description = "Set of managed IAM policy ARNs to attach to the IAM role"
  type        = list(string)
  default     = []
}

variable "dynamic_policy" {
  description = "Whether to use dynamic_policy in the IAM policy"
  type        = bool
  default     = false
}

variable "eks_node_role_arn" {
  description = "ARN of the IAM role associated with the EKS nodes"
  type        = string
  default     = ""
}
