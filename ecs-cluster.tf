resource "aws_ecs_cluster" "ecs_cluster" {
  name = "ClientesApp"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}