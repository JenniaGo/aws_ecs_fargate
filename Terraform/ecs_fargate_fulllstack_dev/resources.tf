# Create the ECS cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.cluster_name}"

  tags = {
    Environment = "dev"
  }
}

# Create the Fargate task execution role
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.cluster_name}-task-execution-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    Environment = "dev"
  }
}

# Add permissions to the task execution role
resource "aws_iam_policy" "ecs_task_execution_policy" {
  name = "${var.cluster_name}-task-execution-policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF

  tags = {
    Environment = "dev"
  }
}

# Attach the policy to the role
resource "aws_iam_policy_attachment" "ecs_task_execution_policy_attachment" {
  name       = "${var.cluster_name}-task-execution-policy-attachment"
  policy_arn = "${aws_iam_policy.ecs_task_execution_policy.arn}"
  roles      = ["${aws_iam_role.ecs_task_execution_role.name}"]

  tags = {
    Environment = "dev"
  }
}

# Create the Fargate task definition
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                = "${var.cluster_name}-task-definition"
  task_role_arn         = "${aws_iam_role.ecs_task_execution_role.arn}"
  execution_role_arn    = "${aws_iam_role.ecs_task_execution_role.arn}"
  network_mode          = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                   = "${var.task_cpu
