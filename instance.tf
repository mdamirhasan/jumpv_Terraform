resource "aws_key_pair" "jumpv_key" {
  key_name   = "aws_key"
  public_key = file("/home/shtlp0133/Music/office-projects/Jumpv/jumpv.pub")
}

resource "aws_instance" "jumpv" {
  ami                         = "ami-053b0d53c279acc90"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.us-east-1b.id
  security_groups             = [aws_security_group.jumpv.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.jumpv_key.key_name
  tags = {
    Name = "jumpv"
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 30
    volume_type = "gp2"
  }
}

output "instance_public_ip" {
  value = aws_instance.jumpv.public_ip
}

output "instance_id" {
  value = aws_instance.jumpv.id
}




