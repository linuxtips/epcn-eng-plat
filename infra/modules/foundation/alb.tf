resource "aws_lb" "main" {
  name               = "${var.env_id}-epcn-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = aws_subnet.public[*].id

  tags = {
    Name = "epcn-alb"
  }
}

resource "aws_lb_target_group" "main" {
    name     = "${var.env_id}-epcn-tg"
    port     = 80
    protocol = "HTTP"
    vpc_id   = aws_vpc.main.id

    health_check {
        path                = "/"
        protocol            = "HTTP"
        matcher             = "200"
        interval            = 30
        timeout             = 5
        healthy_threshold   = 5
        unhealthy_threshold = 2
    }

    tags = {
        Name = "epcn-tg"
    }
}

resource "aws_lb_listener" "https" {
    load_balancer_arn = aws_lb.main.arn
    port              = 443
    protocol          = "HTTPS"
    ssl_policy        = "ELBSecurityPolicy-2016-08"
    certificate_arn   = var.certificate_arn

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.main.arn
    }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}