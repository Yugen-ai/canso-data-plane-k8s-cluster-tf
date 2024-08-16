variable "region" {
  description = "region name"
  type        = string
}

variable "buckets" {
  description = "List of S3 bucket names"
  type        = list(string)
}

variable "bucket_acl" {
  description = "ACL for the S3 bucket"
  type        = string
  default     = "private"
}

variable "force_destroy" {
  description = "Force destroy the S3 bucket and its contents when destroying the Terraform resource"
  type        = bool
  default     = false
}

variable "versioning_enabled" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
  default     = true
}

variable "lifecycle_rule_enabled" {
  description = "Enable lifecycle rule for the S3 bucket"
  type        = bool
  default     = true
}

variable "transition_days" {
  description = "Number of days before objects are transitioned to the specified storage class"
  type        = number
  default     = 120
}

variable "transition_storage_class" {
  description = "Storage class to transition objects to"
  type        = string
  default     = "GLACIER"
}

variable "expiration_days" {
  description = "Number of days before objects are expired (deleted)"
  type        = number
  default     = 365
}

variable "tenant_name" {
  description = "Unique name for the tenant"
  type        = string
}
