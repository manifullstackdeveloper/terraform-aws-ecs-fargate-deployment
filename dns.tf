data "aws_route53_zone" "ecs-fargate-deployment" {
  name = "${var.domain_name}."
}

resource "aws_route53_record" "ecs-fargate-deployment" {
  zone_id = data.aws_route53_zone.ecs-fargate-deployment.zone_id
  name    = "v${var.infrastructure_version}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = "dualstack.${aws_alb.ecs-fargate-deployment-alb.dns_name}"
    zone_id                = aws_alb.ecs-fargate-deployment-alb.zone_id
    evaluate_target_health = false
  }
}
