# Declare variables for the ECS cluster
variable "cluster_name" {
  type    = string
  default = "dev-ecs-cluster"
}

variable "vpc_id" {
  type    = string
  default = "vpc-12345678"
}

variable "subnet_ids" {
  type    = list(string)
  default = ["subnet-12345678", "subnet-87654321"]
}

variable "security_group_id" {
  type    = string
  default = "sg-12345678"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "task_memory" {
  type    = string
  default = "512"
}

variable "task_cpu" {
  type    = string
  default = "256"
}
