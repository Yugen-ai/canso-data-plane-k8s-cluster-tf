############################### 
## NFS Security Group
###############################

resource "aws_security_group" "nfs_sg" {
  name        = var.efs_sg_name
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.my_vpc.id

  ingress {
    description = "TCP from VPC"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.my_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.efs_sg_name
  }
}

############################### 
## EFS
###############################

resource "aws_efs_file_system" "fs" {
  creation_token = var.efs_name
  encrypted      = true
  tags = {
    Name = var.efs_name
  }

}

############################### 
## EFS Mount Points
###############################

resource "aws_efs_mount_target" "alpha1" {
  file_system_id  = aws_efs_file_system.fs.id
  subnet_id       = var.subnet_id_alpha1
  security_groups = [aws_security_group.nfs_sg.id]
  depends_on      = [aws_efs_file_system.fs]
}

resource "aws_efs_mount_target" "alpha2" {
  file_system_id  = aws_efs_file_system.fs.id
  subnet_id       = var.subnet_id_alpha2
  security_groups = [aws_security_group.nfs_sg.id]
  depends_on      = [aws_efs_file_system.fs]
}
