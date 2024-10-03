# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  subnets = aws_subnet.ecs-fargate-deployment.*.id
  subnet_count       =  length(data.aws_availability_zones.available.names)
  availability_zones = data.aws_availability_zones.available.names
}
resource "aws_subnet" "ecs-fargate-deployment" {
  count                   = local.subnet_count
  vpc_id                  = aws_vpc.ecs-fargate-deployment.id
  availability_zone       = element(local.availability_zones, count.index)
  #cidr_block             =  cidrsubnet(var.vpc_cidr, var.vpc_cidr_newbits, var.vpc_cidr_netnum)
  cidr_block              = "10.0.${local.subnet_count * (var.infrastructure_version - 1) + count.index + 1}.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "${element(local.availability_zones, count.index)} (v${var.infrastructure_version})"
  }
}
