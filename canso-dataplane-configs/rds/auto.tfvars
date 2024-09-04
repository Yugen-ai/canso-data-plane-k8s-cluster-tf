############################### 
## AWS Region
###############################

region = "us-east-1"

############################### 
## AWS Subnets
###############################

enable_subnet_group = true
subnet_ids          = ["subnet-0bb63337022e4a2bb", "subnet-09ab07dfe04b6edca"]
subnet_group_name   = "canso-dplane-v1-rds-subnet-group"
subnet_group_tags = {
  Name = "canso-dplane-v1-rds-subnet-group"
}


############################### 
## AWS RDS Parameter Group
###############################

parameter_group_create      = true
parameter_group_name        = "canso-dplane-v1-postgres16-pg"
parameter_group_description = "postgres16 parameter group"
parameter_group_family      = "postgres16"
parameter_group_parameters  = []
parameter_group_tags = {
  Environment              = "canso-dplane-v1-env"
  Department               = "platform"
  CansoDataPlane           = "True"
  CansoDataPlaneRequiredBy = "airflow"
  # Add more tags as needed
}

############################### 
## AWS RDS Security Group
###############################

security_group_create      = false
security_group_name        = "canso-dplane-v1-rds-security-group"
security_group_description = "canso-dplane-v1-rds-security-group"
vpc_id                     = "vpc-0f19d7ecde30feacc"
security_group_tags = {
  Name = "canso-dplane-v1-rds-security-group"
}

###############################
## AWS RDS DB Instance Details
###############################

db_instance_allocated_storage          = 30
db_instance_auto_minor_version_upgrade = true
db_instance_db_name                    = "postgres"
db_instance_db_subnet_group_name       = "canso-dplane-v1-rds-subnet-group"
db_instance_delete_automated_backups   = true
db_instance_deletion_protection        = false
db_instance_engine                     = "postgres"
db_instance_engine_version             = "16.2"
db_instance_identifier                 = "canso-dplane-v1-airflow-ap-rds"
db_instance_instance_class             = "db.t3.medium"
db_instance_kms_key_id                 = "arn:aws:kms:us-east-1:605134474715:key/7e3e6130-f015-46a6-a31c-932263b7b5e4"
db_instance_license_model              = "postgresql-license"
db_instance_multi_az                   = true
db_instance_parameter_group_name       = "canso-dplane-v1-postgres16-pg"
db_instance_port                       = 5432
db_instance_vpc_security_group_ids     = ["sg-0258d14310930191e"]
db_instance_storage_encrypted          = true
db_instance_storage_type               = "gp3"
db_instance_tags = {
  "Env" = "canso-dplane-v1-env"
}
db_creds_path = "../../canso-dataplane-configs/rds/db-creds.yaml.encrypted"