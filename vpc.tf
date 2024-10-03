resource "aws_vpc" "ecs-fargate-deployment" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = {
    Name = "ECS-Fargate-Deployment (v${var.infrastructure_version})"
  }
}
