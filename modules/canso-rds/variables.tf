variable "region" {
  description = "provider region"
  type        = string
}

variable "enable_subnet_group" {
  description = "Flag to enable or disable the creation of DB subnet group"
  type        = bool
}

variable "subnet_ids" {
  description = "List of subnet IDs for the DB subnet group"
  type        = list(string)
}

variable "subnet_group_name" {
  description = "Name of the DB subnet group"
  type        = string
}

variable "subnet_group_tags" {
  description = "Tags for the DB subnet group"
  type        = map(string)
}

variable "parameter_group_create" {
  description = "Whether to create this resource or not?"
  type        = bool
  default     = true
}

variable "parameter_group_name" {
  description = "The name of the DB parameter group"
  type        = string
  default     = ""
}

variable "parameter_group_description" {
  description = "The description of the DB parameter group"
  type        = string
  default     = null
}

variable "parameter_group_family" {
  description = "The family of the DB parameter group"
  type        = string
  default     = null
}

variable "parameter_group_parameters" {
  description = "A list of DB parameter maps to apply"
  type        = list(map(string))
  default     = []
}

variable "parameter_group_tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "security_group_create" {
  description = "Whether to create this resource or not?"
  type        = bool
  default     = true
}

variable "security_group_name" {
  description = "Name of the AWS security group"
  type        = string
}

variable "security_group_description" {
  description = "Description of the AWS security group"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where the security group will be created"
  type        = string
}

variable "security_group_tags" {
  description = "Tags for the AWS security group"
  type        = map(string)
}

variable "db_instance_allocated_storage" {
  description = "The amount of allocated storage for the RDS instance"
  type        = number
}

variable "db_instance_auto_minor_version_upgrade" {
  description = "Specifies whether minor engine upgrades are applied automatically to the DB instance during the maintenance window"
  type        = bool
}

variable "db_instance_db_name" {
  description = "The name of the initial database to be created when the DB instance is created"
  type        = string
}

variable "db_instance_db_subnet_group_name" {
  description = "The name of the DB subnet group to associate with this DB instance"
  type        = string
}

variable "db_instance_delete_automated_backups" {
  description = "Specifies whether to remove automated backups immediately after the DB instance is deleted"
  type        = bool
}

variable "db_instance_deletion_protection" {
  description = "Specifies whether this resource should have deletion protection enabled"
  type        = bool
}

variable "db_instance_engine" {
  description = "The name of the database engine to be used for this DB instance"
  type        = string
}

variable "db_instance_engine_version" {
  description = "The version number of the database engine to use"
  type        = string
}

variable "db_instance_identifier" {
  description = "The name of the RDS instance"
  type        = string
}

variable "db_instance_instance_class" {
  description = "The DB instance class to use"
  type        = string
}

variable "db_instance_kms_key_id" {
  description = "The ARN of the KMS key used to encrypt data in the DB instance"
  type        = string
}

variable "db_instance_license_model" {
  description = "The license model for the DB instance"
  type        = string
}

variable "db_instance_multi_az" {
  description = "Specifies whether the DB instance is a multiple Availability Zone deployment"
  type        = bool
}

variable "db_instance_parameter_group_name" {
  description = "The name of the DB parameter group to associate with this DB instance"
  type        = string
}

variable "db_instance_port" {
  description = "The port on which the DB accepts connections"
  type        = number
}

variable "db_instance_vpc_security_group_ids" {
  description = "A list of VPC security group IDs to associate with this DB instance"
  type        = list(string)
}

variable "db_instance_storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  type        = bool
}

variable "db_instance_storage_type" {
  description = "Specifies the storage type to be associated with the DB instance"
  type        = string
}

variable "db_instance_tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
}

variable "db_creds_path" {
  description = "Path to the encrypted DB credentials file"
  type        = string
}