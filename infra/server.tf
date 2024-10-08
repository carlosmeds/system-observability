### IAM
resource "aws_iam_role" "lab_role" {
  name = "LabRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_instance_profile" "lab_instance_profile" {
  name = "LabInstanceProfile"
  role = aws_iam_role.lab_role.name
}

resource "aws_iam_role_policy_attachment" "lab_role_policy_attachment" {
  role       = aws_iam_role.lab_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_launch_configuration" "lab" {
  name_prefix   = "terraform-aws-asg-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t3.small"
  user_data = templatefile("templates/server.yaml", {
    aws_access_key = var.aws_access_key
    aws_secret_key = var.aws_secret_key
    bucket_name    = var.bucket_name
  })
  security_groups      = [aws_security_group.asg_lab.id]
  iam_instance_profile = "LabInstanceProfile"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "lab" {
  name                 = "lab"
  min_size             = 1
  max_size             = 1
  desired_capacity     = 1
  launch_configuration = aws_launch_configuration.lab.name
  vpc_zone_identifier  = module.vpc.public_subnets

  health_check_type = "ELB"

  tag {
    key                 = "Name"
    value               = "server"
    propagate_at_launch = true
  }
}

### Application Server ALB

resource "aws_lb" "server" {
  name               = "asg-server-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.asg_lab_lb.id]
  subnets            = module.vpc.public_subnets
}

resource "aws_lb_listener" "server" {
  load_balancer_arn = aws_lb.server.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.server.arn
  }
}

resource "aws_lb_target_group" "server" {
  name     = "asg-server"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
}


resource "aws_autoscaling_attachment" "server" {
  autoscaling_group_name = aws_autoscaling_group.lab.id
  alb_target_group_arn   = aws_lb_target_group.server.arn
}

### Grafana ALB

resource "aws_lb" "grafana" {
  name               = "asg-grafana-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.asg_lab_lb.id]
  subnets            = module.vpc.public_subnets
}

resource "aws_lb_listener" "grafana" {
  load_balancer_arn = aws_lb.grafana.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.grafana.arn
  }
}

resource "aws_lb_target_group" "grafana" {
  name     = "asg-grafana"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
}


resource "aws_autoscaling_attachment" "grafana" {
  autoscaling_group_name = aws_autoscaling_group.lab.id
  alb_target_group_arn   = aws_lb_target_group.grafana.arn
}