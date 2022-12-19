# Create an ECS cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.ecs_cluster_name}"
}

# Create a task definition for the ECS cluster
resource "aws_ecs_task_definition" "task_definition" {
  family                = "${var.task_definition_name}"
  network_mode          = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                   = "${var.container_cpu}"
  memory                = "${var.container_memory}"

  container_definitions = <<DEFINITION
  [
    {
      "name": "${var.container_name}",
      "image": "${var.container_image}",
      "portMappings": [
        {
          "containerPort": "${var.container_port}",
          "hostPort": "${var.container_port}"
        }
      ],
      "essential": true
    }
  ]
  DEFINITION
}

# Create an ECS service
resource "aws_ecs_service" "ecs_service" {
  name            = "${var.task_definition_name}"
  cluster         = "${aws_ecs_cluster.ecs_cluster.id}"
  task_definition = "${aws_ecs_task_definition.task_definition.arn}"
  desired_count   = "${var.task_count}"
  launch_type     = "FARGATE"
  network_configuration {
    security_groups = "${var.security_group_ids}"
    subnets        = "${var.subnet_ids}"
  }
}
