#Create target group
resource "aws_lb_target_group" "tg_tomcat" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
  name        = "alb-tg"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc_california.id
}

#Create app load balancer
resource "aws_lb" "app-lb" {
  name = "app-lb"
  internal = false
  ip_address_type = "ipv4"
  load_balancer_type = "application"
  security_groups = [aws_security_group.SG_Public_instance.id]
  subnets = [aws_subnet.public_subnet_az1.id,aws_subnet.public_subnet_az2.id]
}

#Create listener
resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.app-lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_tomcat.arn
  }  
}

#Create attachment
resource "aws_lb_target_group_attachment" "ec2_attachment" {
  target_group_arn = aws_lb_target_group.tg_tomcat.arn
  target_id        = aws_instance.tomcat_az1.id
  port             = 80
}
