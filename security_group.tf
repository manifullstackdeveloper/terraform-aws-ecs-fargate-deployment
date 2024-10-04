resource "aws_security_group" "ecs-fargate-deployment" {
  description = "ECS Fargate Deployment"
  vpc_id      = aws_vpc.ecs-fargate-deployment.id
  name        = "ecs-fargate-deployment-v${var.infrastructure_version}"

  tags = {
    Name = "Ecs-Fargate-Deployment (v${var.infrastructure_version})"
  }
}

resource "aws_security_group_rule" "ecs-fargate-deployment-ingress" {
  type              = "ingress"
  security_group_id = aws_security_group.ecs-fargate-deployment.id
  count = length(var.sg_ingress_rules)
  from_port         = var.sg_ingress_rules[count.index].from_port
  to_port           = var.sg_ingress_rules[count.index].to_port
  protocol          = var.sg_ingress_rules[count.index].protocol
  //cidr_blocks        = [var.sg_ingress_rules[count.index].cidr_block]
  description       = var.sg_ingress_rules[count.index].description
  self = var.sg_ingress_rules[count.index].self
}

resource "aws_security_group_rule" "ecs-fargate-deployment-ingress-80" {
  type              = "ingress"
  security_group_id = aws_security_group.ecs-fargate-deployment.id
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ecs-fargate-deployment-egress" {
  type              = "egress"
  security_group_id = aws_security_group.ecs-fargate-deployment.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}
