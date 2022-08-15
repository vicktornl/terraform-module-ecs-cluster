data "aws_iam_policy_document" "ecs_instance_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_instance_role" {
  name               = "${var.name}-ecs-instance-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_instance_role.json
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
