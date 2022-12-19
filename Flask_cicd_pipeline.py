import os
import subprocess

def build_docker_image():
  # Clone Git repository
  subprocess.run(["git", "clone", "https://github.com/user/my-flask-app.git"])

  # Build Docker image
  subprocess.run(["docker", "build", "-t", "my-flask-app", "."])

def push_to_ecr():
  # Push Docker image to ECR
  subprocess.run(["aws", "ecr", "get-login", "--no-include-email", "--region", "us-east-1"])
  subprocess.run(["docker", "push", "1234567890.dkr.ecr.us-east-1.amazonaws.com/my-flask-app"])

def update_fargate_service():
  # Update Fargate task definition and service
  subprocess.run(["aws", "ecs", "register-task-definition", "--cli-input-json", "file://task-definition.json"])
  subprocess.run(["aws", "ecs", "update-service", "--cluster", "my-cluster", "--service", "my-service", "--task-definition", "my-flask-app"])

def main():
  # Check if this is a pull request or branch build
  if "PULL_REQUEST_NUMBER" in os.environ:
    print("Skipping deployment for pull request")
    return

  # Build and test code
  build_and_test()

  # Build Docker image for Flask website
  build_docker_image()

  # Push Docker image to ECR
  push_to_ecr()

  # Deploy Flask website to Fargate
  update_fargate_service()

if __name__ == "__main__":
  main()
``
