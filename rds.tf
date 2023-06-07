resource "aws_db_instance" "rds" {
  identifier            = "jumpv-db"
  engine                = "mysql"
  engine_version        = "8.0"
  instance_class        = "db.t2.micro"
  allocated_storage     = 20
  storage_type          = "gp2"
  username              = "myuser"
  password              = "mypassword"
#  name                  = "jumpv-db"
  parameter_group_name  = "default.mysql8.0"
  backup_retention_period = 7
  skip_final_snapshot   = true
  publicly_accessible  = false
  db_subnet_group_name  = aws_db_subnet_group.jumpv.name
  vpc_security_group_ids = [aws_security_group.jumpv.id]

  depends_on = [aws_db_subnet_group.jumpv, aws_security_group.jumpv]
}

resource "aws_db_subnet_group" "jumpv" {
  name       = "jumpv-db-subnet-group"
  subnet_ids = [aws_subnet.us-east-1a.id, aws_subnet.us-east-1b.id, aws_subnet.us-east-1c.id]
}

resource "aws_security_group" "jumpv-db" {
  name        = "example-security-group"
  description = "Allow incoming traffic to the database"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

