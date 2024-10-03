variable "domain_name" {
  description = "Your Route53 Hosted domain name"
  type = string
  default = "yourdomain.com"
}

variable "vpc_cidr" {
  type        = string
  description = "The IP range to use for the VPC"
  default     = "10.0.0.0/16"
}
variable "vpc_cidr_newbits" {
  type        = number
  description = "vpc_cidr_newbits"
  default     = 6
}
variable "vpc_cidr_netnum" {
  type        = number
  description = "vpc_cidr_netnum"
  default     = 30
}


variable "aws_region" {
  description = "Region in which AWS resources to be created"
  type        = string
  default     = "us-west-2"
}

variable "aws_availability_zones" {
  description = "Availability Zoneson in which AWS resources to be created"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b"]
}

variable "infrastructure_version" {
  default = "1"
}

variable "ecs-task-name" {
  description = "image-location"
  type = string
  default = "app_ecs_task"
}

variable "image-location" {
  description = "image-location"
  type = string
  default = "*******.dkr.ecr.regin.amazonaws.com/#######"
}

variable "health_check_path" {
  description = "Route53 Hosted domain name"
  type = string
  default = "/home"
}

variable "execution_role_arn" {
  description = "execution_role_arn"
  type = string
  default = "arn:aws:iam::*******:role/ecsTaskExecutionRole"
}

variable "task_role_arn" {
  description = "task_role_arn"
  type = string
  default = "arn:aws:iam::*******:role/ecsTaskExecutionRole"
}

variable "cpu" {
  description = "cpu"
  type = number
  default = 1024
}

 variable "memory" {
  description = "memory"
  type = number
  default = 2048
}

 variable "operating_system_family" {
  description = "operating_system_family"
  type = string
  default = "LINUX"
}

 variable "cpu_architecture" {
  description = "cpu_architecture"
  type = string
  default = "ARM64"
}

variable "container-port" {
  description = "container-port"
  type = number
  default = 8080
}

variable "assign_public_ip" {
  description = "assign_public_ip"
  type = bool
  default = true
}

variable "awslogs-group-location" {
  description = "awslogs-group-location"
  type = string
  default = "/ecs/dev"
}

variable "sg_ingress_rules" {
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = string
      description = string
      self = bool
    }))
    default     = [
        {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_block  = "0.0.0.0/0"
          description = "port-80"
          self = false
        },
        {
          from_port   = 8080
          to_port     = 8080
          protocol    = "tcp"
          cidr_block  = "10.0.0.0/16"
          self = true
          description = "8080-port"
        },
    ]
}