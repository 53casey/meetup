resource "aws_ecs_cluster" "meetup_ecs_cluster" {
  name = "meetup-ecs-cluster"
}

resource "aws_ecs_task_definition" "meetup_task_def" {
  family                   = "meetup-task-def"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.meetup_ecs_task_execution_role.arn
  container_definitions = jsonencode([
    {
      name      = "meetup-container"
      image     = "${aws_ecr_repository.meetup_ecr_repo.repository_url}:latest"
      essential = true
      portMappings = [
        {
          protocol      = "tcp"
          containerPort = 8000
          hostPort      = 8000
        }
      ],
      #   logConfiguration : {
      #     logDriver : awslogs,
      #     options : {
      #       awslogs-create-group : true,
      #       awslogs-group : awslogs-wordpress,
      #       awslogs-region : us-west-2,
      #       awslogs-stream-prefix : awslogs-example
      #     }
      #   },
    }
  ])
}

resource "aws_ecs_service" "meetup_ecs_service" {
  name            = "meetup-ecs-service"
  cluster         = aws_ecs_cluster.meetup_ecs_cluster.id
  task_definition = aws_ecs_task_definition.meetup_task_def.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
    security_groups  = [aws_security_group.meetup_ecs_sg.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.meetup_target_group.arn
    container_name   = "meetup-container"
    container_port   = 8000
  }

  lifecycle {
    ignore_changes = [task_definition]
  }

  tags = {
    env = "meetup-ecs-service"
  }
}

resource "aws_iam_role" "meetup_ecs_task_execution_role" {
  name = "meetup-ecs-task-execution-role"

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow"
   }
 ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "meetup_ecs_task_execution_role_policy_attachment" {
  role       = aws_iam_role.meetup_ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
