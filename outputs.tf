output "cluster_id" {
  value = aws_ecs_cluster.main.id
}

output "cluster_arn" {
  value = aws_ecs_cluster.main.arn
}

output "ecs_instance_role_name" {
  value = aws_iam_role.ecs_instance_role.name
}
