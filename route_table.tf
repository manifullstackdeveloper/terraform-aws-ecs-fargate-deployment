resource "aws_route_table" "ecs-fargate-deployment" {
  vpc_id = aws_vpc.ecs-fargate-deployment.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ecs-faragte-deployment.id
  }

  tags = {
    Name = "ECS-Fargate-Deployment (v${var.infrastructure_version})"
  }
}

resource "aws_route_table_association" "ecs-fargate-deployment" {
  count          = 2
  subnet_id      = element(local.subnets, count.index)
  route_table_id = aws_route_table.ecs-fargate-deployment.id
}
