# Variables for the ECS Fargate stack
variable "ecs_cluster_name" {
  type = string
}

variable "task_definition_name" {
  type = string
}

variable "task_count" {
  type    = number
  default = 1
}

variable "container_port" {
  type    = number
  default = 80
}

variable "container_image" {
  type = string
}

variable "container_name" {
  type = string
}

variable "container_memory" {
  type    = number
  default = 512
}

variable "container_cpu" {
  type    = number
  default = 256
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_account_id" {
  type = string
}
