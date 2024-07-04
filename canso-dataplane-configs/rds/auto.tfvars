############################### 
## AWS Region
###############################

region = "ap-south-1"

############################### 
## AWS Subnets
###############################

enable_subnet_group = true
subnet_ids          = ["subnet-xxxxxxxxxxxxxxxxx", "subnet-xxxxxxxxxxxxxxxxx"]
subnet_group_name   = "canso-dataplane-rds-subnet-group"
subnet_group_tags = {
  Name = "canso-dataplane-rds-subnet-group"
}


############################### 
## AWS RDS Parameter Group
###############################

parameter_group_create      = true
parameter_group_name        = "postgres16-dataplane-pg"
parameter_group_description = "postgres16 parameter group"
parameter_group_family      = "postgres16"
parameter_group_parameters  = []
parameter_group_tags = {
  Environment              = "prod"
  Department               = "platform"
  CansoDataPlane           = "True"
  CansoDataPlaneRequiredBy = "airflow"
  # Add more tags as needed
}

############################### 
## AWS RDS Security Group
###############################

security_group_create      = false
security_group_name        = "rds-security-group"
security_group_description = "rds-security-group"
vpc_id                     = "vpc-xxxxxxxxxxxxxxxxx"
security_group_tags = {
  Name = "rds-sg"
}

###############################
## AWS RDS DB Instance Details
###############################

db_instance_allocated_storage          = 30
db_instance_auto_minor_version_upgrade = true
db_instance_db_name                    = "postgres"
db_instance_db_subnet_group_name       = "canso-dataplane-rds-subnet-group"
db_instance_delete_automated_backups   = true
db_instance_deletion_protection        = false
db_instance_engine                     = "postgres"
db_instance_engine_version             = "16.2"
db_instance_identifier                 = "airflow-prod-env-ap-rds"
db_instance_instance_class             = "db.t4g.large"
db_instance_kms_key_id                 = "arn:aws:kms:ap-south-1:<ACCOUNT_ID>:key/mrk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
db_instance_license_model              = "postgresql-license"
db_instance_multi_az                   = true
db_instance_parameter_group_name       = "postgres16-dataplane-pg"
db_instance_port                       = 5432
db_instance_vpc_security_group_ids     = ["sg-xxxxxxxxxxxxxxxxx"]
db_instance_storage_encrypted          = true
db_instance_storage_type               = "gp3"
db_instance_tags = {
  "Env" = "prod"
}
db_creds_path = "../../canso-dataplane-configs/rds/db-creds.yaml.encrypted"