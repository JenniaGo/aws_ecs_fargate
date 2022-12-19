pipeline {
  agent any

  stages {
    stage('Build and Test') {
      steps {
        sh 'python -m unittest discover'
      }
    }

    stage('Deploy to Fargate') {
      steps {
        sh 'docker build -t my-app .'
        sh 'aws ecr get-login --no-include-email --region us-east-1 | sh'
        sh 'docker push 1234567890.dkr.ecr.us-east-1.amazonaws.com/my-app'
        sh 'aws ecs register-task-definition --cli-input-json file://task-definition.json'
        sh 'aws ecs update-service --cluster my-cluster --service my-service --task-definition my-app'
      }
    }
  }
}
