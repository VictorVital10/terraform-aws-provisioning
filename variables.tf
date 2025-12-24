variable "aws_region" {
  type    = string
  default = "sa-east-1"
}

variable "aws_profile" {
  type    = string
  default = "Terraform"
}

variable "aws_instance_type" {
  type    = string
  default = "t3.micro"
}