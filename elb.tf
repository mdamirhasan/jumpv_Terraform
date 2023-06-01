resource "aws_lb" "jumpv" {
  name               = "application-loadbalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.jumpv.id]
  # subnets            = [aws_subnet.us_east_1a.id,aws_subnet.us_east_1b.id, aws_subnet.us_east_1c.id]
  subnets            = [aws_subnet.us-east-1a.id,aws_subnet.us-east-1b.id, aws_subnet.us-east-1c.id]

  tags = {
    Environment = "jumpv_prod"
  }
}

resource "aws_lb_target_group" "jumpv_tg" {
  name        = "jumpv-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.jumpv.id
  target_type = "instance"

  load_balancing_algorithm_type = "round_robin"

  health_check {
    interval            = 30
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  tags = {
    Environment = "jumpv_prod"
  }

  depends_on = [aws_lb.jumpv]
}

resource "aws_lb_target_group_attachment" "jumpv-tg" {
  target_group_arn = aws_lb_target_group.jumpv_tg.arn
  target_id        = aws_instance.jumpv.id
  port             = 80
}

resource "aws_lb_listener" "webserver1" {
  load_balancer_arn = aws_lb.jumpv.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jumpv_tg.arn       

  }
}















