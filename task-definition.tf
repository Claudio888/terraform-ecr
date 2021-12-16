resource "aws_ecs_task_definition" "ecs_task_definition" {
  family = "service"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn = "arn:aws:iam::933375035704:role/ecsTaskExecutionRole"
  cpu = 1024
  memory    = 2048
  network_mode = "awsvpc"
  container_definitions = jsonencode([
    {
      name      = "GetIPTest"
      image     = "933375035704.dkr.ecr.us-east-1.amazonaws.com/getip-drone:latest"
      cpu       = 512
      memory    = 256
      essential = true
      portMappings = [
        {
          containerPort = 8090
          hostPort      = 8090
        }
      ]
    }
   ])

  runtime_platform {
    operating_system_family = "LINUX"
  }

}