#Log the load balancer app url
output "app_url" {
  value = aws_alb.ecs-fargate-deployment-alb.dns_name
}