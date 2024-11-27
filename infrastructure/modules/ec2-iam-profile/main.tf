# Define el rol IAM para EC2 con la política de confianza necesaria
resource "aws_iam_role" "ec2_iam_role" {
  name = "${local.prefix}_ec2_role"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        }
      }
    ]
  }
  EOF
}

# Crea un perfil de instancia vinculado al rol
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${local.prefix}_ec2_profile"
  role = aws_iam_role.ec2_iam_role.name
}

# Política para acceso a CloudWatch Logs y métricas
resource "aws_iam_role_policy" "ec2_cloudwatch_policy" {
  name = "${local.prefix}_cloudwatch_access_policy"
  role = aws_iam_role.ec2_iam_role.name

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "cloudwatch:PutMetricData",
          "ec2:DescribeVolumes",
          "ec2:DescribeTags",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams",
          "logs:DescribeLogGroups",
          "logs:CreateLogStream",
          "logs:CreateLogGroup"
        ],
        "Resource": "*"
      }
    ]
  }
  EOF
}

# Política para permitir acceso a ECR
resource "aws_iam_role_policy" "ec2_ecr_policy" {
  name = "${local.prefix}_ecr_access_policy"
  role = aws_iam_role.ec2_iam_role.name

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "ecr:GetAuthorizationToken",
          "ecr:ListImages",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": "ecr:DescribeRepositories",
        "Resource": "*"
      }
    ]
  }
  EOF
}

# Variables locales
locals {
  prefix = "${var.project}_${var.env}"
}
