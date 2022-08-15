resource "aws_ecs_cluster" "main" {
  name = var.name
}

resource "aws_launch_configuration" "main" {
  name_prefix          = var.name
  image_id             = local.ami_id
  instance_type        = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.ecs_container_role.id
  security_groups      = var.security_groups

  user_data = <<EOF
#!/bin/bash
echo ECS_CLUSTER='${aws_ecs_cluster.main.name}' >> /etc/ecs/ecs.config
EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "main" {
  name                 = var.name
  launch_configuration = aws_launch_configuration.main.name
  min_size             = var.min_size
  max_size             = var.max_size
  vpc_zone_identifier  = var.subnets

  lifecycle {
    create_before_destroy = true
  }
}
