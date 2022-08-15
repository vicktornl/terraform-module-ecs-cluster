data "aws_iam_policy_document" "ecs_container_role_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ecs_container_role" {
  statement {
    actions = [
      "cloudwatch:PutMetricData",
      "ec2:DescribeTags",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role" "ecs_container_role" {
  name               = "${var.name}-ecs-container-role"
  assume_role_policy = "${data.aws_iam_policy_document.ecs_container_role_assume.json}"
}

resource "aws_iam_role_policy" "ecs_container_role_policy" {
  name   = "${var.name}-ecs-container-role"
  role   = "${aws_iam_role.ecs_container_role.id}"
  policy = "${data.aws_iam_policy_document.ecs_container_role.json}"
}

resource "aws_iam_role_policy_attachment" "ecs_container_service_role" {
  role       = "${aws_iam_role.ecs_container_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ecs_container_role_s3" {
  role       = "${aws_iam_role.ecs_container_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "ecs_container_role_ses" {
  role       = "${aws_iam_role.ecs_container_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonSESFullAccess"
}

resource "aws_iam_role_policy_attachment" "ecs_container_role_sqs" {
  role       = "${aws_iam_role.ecs_container_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
}

resource "aws_iam_instance_profile" "ecs_container_role" {
  name = "${var.name}-ecs-container-role"
  path = "/"
  role = aws_iam_role.ecs_container_role.name
}
