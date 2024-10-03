
# Firewall Rules

resource "aws_security_group" "asg_lab" {
  name = "asg-lab"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
# Thanos Sidecar gRPC (port 10911)
  ingress {
    from_port   = 10911
    to_port     = 10911
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Thanos Sidecar HTTP (port 10912)
  ingress {
    from_port   = 10912
    to_port     = 10912
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Thanos Store gRPC (port 10921)
  ingress {
    from_port   = 10921
    to_port     = 10921
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Thanos Store HTTP (port 10922)
  ingress {
    from_port   = 10922
    to_port     = 10922
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Thanos Query HTTP (port 10902)
  ingress {
    from_port   = 10902
    to_port     = 10902
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group" "asg_lab_lb" {
  name = "asg-lab-lb"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = module.vpc.vpc_id
}