resource "aws_db_instance" "this" {
  allocated_storage = var.db_instance_allocated_storage

  db_name                  = var.db_instance_db_name
  db_subnet_group_name     = var.db_instance_db_subnet_group_name
  delete_automated_backups = var.db_instance_delete_automated_backups
  deletion_protection      = var.db_instance_deletion_protection
  engine                   = var.db_instance_engine
  engine_version           = var.db_instance_engine_version

  identifier     = var.db_instance_identifier
  instance_class = var.db_instance_instance_class
  kms_key_id     = var.db_instance_kms_key_id
  license_model  = var.db_instance_license_model

  multi_az = var.db_instance_multi_az
  #option_group_name                     = "default:postgres-15"
  parameter_group_name = var.db_instance_parameter_group_name
  port                 = var.db_instance_port

  username               = local.db_creds.username
  password               = local.db_creds.password
  vpc_security_group_ids = var.db_instance_vpc_security_group_ids

  storage_encrypted       = var.db_instance_storage_encrypted
  storage_type            = var.db_instance_storage_type
  tags                    = var.db_instance_tags
  skip_final_snapshot     = true
  apply_immediately       = true
  backup_retention_period = 0

  depends_on = [aws_db_subnet_group.default]
}