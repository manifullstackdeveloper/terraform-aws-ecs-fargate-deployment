resource "aws_internet_gateway" "ecs-faragte-deployment" {
  vpc_id = aws_vpc.ecs-fargate-deployment.id
  tags = {
    Name = "ECS-Faragte-Deployment (v${var.infrastructure_version})"
  }
}
