#create a security group for RDS Database Instance
resource "aws_security_group" "rds_sg" {
  name   = "${var.project}_${var.env}_rds_sg"
  vpc_id = var.vpc_id
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#create a RDS Database Instance
resource "aws_db_instance" "myinstance" {
  engine                  = var.engine
  identifier              = var.identifier
  allocated_storage       = var.rds_storage
  engine_version          = var.engine_version
  instance_class          = var.rds_instance_class
  db_name                 = var.db_name
  username                = jsondecode(data.aws_secretsmanager_secret_version.secret_password_rds.secret_string)["username"]
  password                = jsondecode(data.aws_secretsmanager_secret_version.secret_password_rds.secret_string)["password"]
  vpc_security_group_ids  = ["${aws_security_group.rds_sg.id}"]
  skip_final_snapshot     = true
  publicly_accessible     = var.rds_public
  db_subnet_group_name    = aws_db_subnet_group.subnetgroup.name
  backup_retention_period = var.backup_retention_period
  storage_type            = "gp3"
}

resource "aws_db_subnet_group" "subnetgroup" {
  name       = "${var.project}_${var.env}_subnet_group"
  subnet_ids = var.private_subnets

  tags = {
    Name        = "${var.project}_${var.env}_subnet_group"
    Project     = var.project
    Environment = var.env
  }
}