
resource "aws_alb" "application-load-balancer" {
  name               = "${var.project}-${var.env}-${var.app}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnets
  security_groups    = [aws_security_group.load-balancer-security-group.id]

  # Condicional para configurar TLS o no

  tags = {
    Name        = "${var.project}-${var.env}-${var.app}-alb"
    Environment = var.env
  }
}

resource "aws_security_group" "load-balancer-security-group" {
  vpc_id = var.vpc_id

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
    ingress {
    from_port        = 2049
    to_port          = 2049
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name        = "${var.project}-${var.env}-${var.app}-sg"
    Environment = var.env
  }
}

resource "aws_lb_target_group" "target-group" {
  name        = "${var.project}-${var.env}-${var.app}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold   = "3"
    interval            = "60"
    protocol            = "HTTP"
    matcher             = var.matcher
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }

  tags = {
    Name        = "${var.project}-${var.env}-${var.app}-lb-tg"
    Environment = var.env
  }
}

resource "aws_lb_listener" "listener_service_legacy" {
  count             = var.enable_tls ? 0 : 1
  load_balancer_arn = aws_alb.application-load-balancer.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group.id
  }
}


resource "aws_lb_listener" "listener_service_legacy_tls" {
  count             = var.enable_tls ? 1 : 0
  load_balancer_arn = aws_alb.application-load-balancer.id
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = var.cert_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group.id
  }
}

resource "aws_lb_listener" "redirect_http" {
  count             = var.enable_tls ? 1 : 0
  load_balancer_arn = aws_alb.application-load-balancer.id
  port              = "80"
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

