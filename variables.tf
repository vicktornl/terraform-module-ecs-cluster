variable "name" {}

variable "vpc_id" {}

variable "instance_type" {
  default = "t2.micro"
}

variable "min_size" {
  default = 0
}

variable "max_size" {
  default = 0
}

variable "security_groups" {
  default = []
}

variable "subnets" {
  default = []
}

data "aws_ssm_parameter" "ecs_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux/recommended/image_id"
}

locals {
  image_id = data.aws_ssm_parameter.ecs_ami.value
}
