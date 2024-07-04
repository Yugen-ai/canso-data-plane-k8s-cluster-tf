data "aws_vpc" "my_vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}
