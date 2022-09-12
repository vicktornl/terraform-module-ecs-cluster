data "aws_iam_policy_document" "ecs_instance_role_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ecs_instance_role" {
  statement {
    actions = [
      "cloudwatch:PutMetricData",
      "ec2:DescribeTags",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role" "ecs_instance_role" {
  name               = "${var.name}-ecs-instance-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_instance_role_assume.json
}

resource "aws_iam_role_policy" "ecs_instance_role_policy" {
  name   = "${var.name}-ecs-instance-role"
  role   = aws_iam_role.ecs_instance_role.id
  policy = data.aws_iam_policy_document.ecs_instance_role.json
}

resource "aws_iam_instance_profile" "ecs_instance_role" {
  name = "${var.name}-ecs-instance-role"
  path = "/"
  role = aws_iam_role.ecs_instance_role.name
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}
