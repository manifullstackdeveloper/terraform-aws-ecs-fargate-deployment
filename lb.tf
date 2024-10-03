resource "aws_alb" "ecs-fargate-deployment-alb" {
  name               = "ecs-fargate-deployment"
  load_balancer_type = "application"
  subnets = aws_subnet.ecs-fargate-deployment.*.id
  security_groups = ["${aws_security_group.ecs-fargate-deployment.id}"]
}

resource "aws_lb_listener" "ecs-fargate-deployment" {
  load_balancer_arn = aws_alb.ecs-fargate-deployment-alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs-faragte-target-group.arn
  }
}
