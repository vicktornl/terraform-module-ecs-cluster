variable "name" {}

variable "vpc_id" {}

variable "image_id" {}

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
