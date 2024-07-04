resource "aws_db_parameter_group" "this" {
  count = var.parameter_group_create ? 1 : 0

  name = var.parameter_group_name

  description = var.parameter_group_description
  family      = var.parameter_group_family

  dynamic "parameter" {
    for_each = var.parameter_group_parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = lookup(parameter.value, "apply_method", null)
    }
  }

  tags = merge(
    var.parameter_group_tags,
    {
      "Name" = var.parameter_group_name
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}
 