resource "aws_db_subnet_group" "default" {
  count      = var.enable_subnet_group ? 1 : 0
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids

  tags = var.subnet_group_tags
}