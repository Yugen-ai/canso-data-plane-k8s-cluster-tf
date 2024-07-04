resource "aws_security_group" "this" {

  count       = var.security_group_create ? 1 : 0
  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = var.vpc_id

  tags = var.security_group_tags
}