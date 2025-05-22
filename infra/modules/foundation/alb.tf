resource "aws_lb" "main" {
  name               = "epcn-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = aws_subnet.public[*].id

  tags = {
    Name = "epcn-alb"
  }
}
