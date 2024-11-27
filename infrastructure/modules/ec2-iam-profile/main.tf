resource "aws_iam_role" "ec2_iam_role" {
  name = "${local.prefix}_ec2_role"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "sts:AssumeRole"
        ],
        "Principal": {
            "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${local.prefix}_ec2_profile"
  role = aws_iam_role.ec2_iam_role.name
}

# Add a cloudwatch policy
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

# Add ECR Policy
resource "aws_iam_role_policy" "ec2_ecr_policy" {
  name = "${local.prefix}_ecr_access_policy"
  role = aws_iam_role.ec2_iam_role.name

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "ecr:GetAuthorizationToken",
          "ecr:ListImages",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  }
  EOF
}

locals {
  prefix = "${var.project}_${var.env}"
}
