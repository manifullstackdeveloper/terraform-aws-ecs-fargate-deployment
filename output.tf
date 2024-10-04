#Log the load balancer app url
output "app-alb-url" {
  value = aws_alb.ecs-fargate-deployment-alb.dns_name
}

output "app-dns-name" {
  value = aws_route53_record.ecs-fargate-deployment.name
}
