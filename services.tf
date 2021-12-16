resource "aws_ecs_service" "ecs_service" {
  name            = "GetIPTest"
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = 1
  cluster         = aws_ecs_cluster.ecs_cluster.id
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = "${aws_lb_target_group.target_group.arn}" 
    container_name   = "GetIPTest"
    container_port   = 8090 
  }
  
  lifecycle {
    ignore_changes = [
      load_balancer,
      desired_count,
      task_definition
    ]
  }

  network_configuration {
    subnets = ["${aws_default_subnet.default_subnet_a.id}", "${aws_default_subnet.default_subnet_b.id}", "${aws_default_subnet.default_subnet_c.id}"]
    security_groups = [aws_security_group.ecs_security_group.id]
    assign_public_ip = true 
  }
}

resource "aws_security_group" "ecs_security_group" {
  name        = "ecs-sg"
  description = "Sg para ecs"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    # Only allowing traffic in from the load balancer security group
    security_groups = ["${aws_security_group.load_balancer_security_group.id}"]
  }
  
   egress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }
}

