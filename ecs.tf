resource "aws_ecs_cluster" "ecs-fargate-deployment-cluster" {
  name = "ecs-fargate-deployment-cluster" 
}

resource "aws_ecs_task_definition" "ecs-fargate-deployment-cluster-app-task" {
 family             = var.ecs-task-name
 requires_compatibilities = ["FARGATE"]
 network_mode       = "awsvpc"
 execution_role_arn = var.execution_role_arn
 task_role_arn  = var.task_role_arn
 cpu                = var.cpu
 memory             = var.memory
 runtime_platform {
   operating_system_family = var.operating_system_family
   cpu_architecture        = var.cpu_architecture
 }
 container_definitions = jsonencode([
   {
     name      = var.ecs-task-name
     image     = var.image-location
     cpu       = var.cpu
     memory    = var.memory
     essential = true
     portMappings = [
       {
         "name": "httpd-8888-dev",
          "containerPort": var.container-port,
          "hostPort": var.container-port,
          "protocol": "tcp",
          "appProtocol": "http"
       }
     ]
     logConfiguration =  {
                  logDriver =  "awslogs"
                  options =  {
                      "awslogs-group" = var.awslogs-group-location,
                      "mode"= "non-blocking",
                      "awslogs-create-group"= "true",
                      "max-buffer-size"= "25m",
                      "awslogs-region"= var.aws_region
                      "awslogs-stream-prefix"= "ecs"
                  }
              }
   }
 ])
}

resource "aws_ecs_service" "ecs-fargate-deployment-cluster-app-service" {
  name            = "ecs-app-service"                  
  cluster         = aws_ecs_cluster.ecs-fargate-deployment-cluster.id       
  task_definition = aws_ecs_task_definition.ecs-fargate-deployment-cluster-app-task.arn
  desired_count   = 2
  launch_type = "FARGATE"

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs-faragte-target-group.arn
    container_name   = aws_ecs_task_definition.ecs-fargate-deployment-cluster-app-task.family
    container_port   = var.container-port
  }

  network_configuration {
    subnets          = aws_subnet.ecs-fargate-deployment.*.id
    assign_public_ip = var.assign_public_ip                                         
    security_groups  = ["${aws_security_group.ecs-fargate-deployment.id}"]
  }
}