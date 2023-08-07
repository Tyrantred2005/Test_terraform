variable "california_cidr" {
    description = "CIDR California"
    type        = string
}

variable "public_subnet_az1"{
    description = "CIDR public subnet AZ1"
    type        = string
}

variable "public_subnet_az2"{
    description = "CIDR public subnet AZ2"
    type        = string
}

variable "private_subnet"{
    description = "CIDR private subnet"
    type        = string
}

variable "SG_ingress_cidr" {
  description   = "CIDR for ingress traffic"
  type          = string
}

variable "ami_id" {
    description = "AMI type"
    type        = string
}

variable "instance_type" {
    description = "Instance type"
    type        = string
}

variable "az1"{
    description = "Availability zone 1"
    type        = string
}

variable "az2"{
    description = "Availability zone 2"
    type        = string
}
