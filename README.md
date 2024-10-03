# terraform-aws-ecs-fargate-deployment
terraform-aws-ecs-fargate-deployment

# update variable as per your config
update your domain_name in variable.tf
update your aws_region in variable.tf
update your vpc_cidr in variable.tf
update your image-location in variable.tf
update your health_check_path in variable.tf
update execution_role_arn in variable.tf
update task_role_arn in variable.tf

update ingress role  in variable.tf

# IMPORTANT
if your docker image architure is different then your ecs task definition operating_system_family/cpu_architecture. it wont work.
so make sure you choosing right one

