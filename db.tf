resource "aws_security_group" "rds-sg" {
  name   = "rds_sg"
  ingress {
    from_port   = var.rds_port
    to_port     = var.rds_port
    protocol    = "tcp"
    security_groups = [aws_security_group.ec2-sg.id]
  }# outbound internet access
}

resource "aws_db_instance" "db" {
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.db_instance_class
  name                   = var.db_name
  username               = var.username
  password               = var.password
  vpc_security_group_ids = [aws_security_group.rds-sg.id]
  skip_final_snapshot    = true
}
