variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "vpc_tags" {
  default = {
    Name = "demo-vpc"
  }
}

variable "public_cidrs" {
  default = ["10.0.0.16/24", "10.0.1.0/24"]
}