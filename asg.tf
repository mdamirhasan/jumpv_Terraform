resource "aws_launch_template" "jumpv_lt" {
  name   = "jumpv-template"
  image_id      = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.jumpv_key.key_name
 

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.jumpv.id]
  }

}


resource "aws_autoscaling_group" "jumpv_asg" {
  launch_template {
    id      = aws_launch_template.jumpv_lt.id
    version = "$Latest"
  }
  
  vpc_zone_identifier       = [aws_subnet.us-east-1a.id,aws_subnet.us-east-1b.id,aws_subnet.us-east-1c.id]
  health_check_type         = "EC2"
  min_size                  = 2
  max_size                  = 5
  desired_capacity          = 2
  health_check_grace_period = 300

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "jumpv"
    value               = "jumpv_lt"
    propagate_at_launch = true
  }

  target_group_arns = [aws_lb_target_group.jumpv_tg.arn]

  depends_on = [
    aws_lb_target_group.jumpv_tg,
    aws_launch_template.jumpv_lt,
  ]
}













