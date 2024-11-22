pipeline {
  agent any
  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/stann16/resideo.git'
      }
    }
    stage('Build Docker Image') {
      steps {
        sh './build.sh'
      }
    }
    stage('Terraform Init') {
      steps {
        sh 'terraform init'
      }
    }
    stage('Terraform Plan') {
      steps {
        sh 'terraform plan -out=tfplan'
      }
    }
    stage('Terraform Apply') {
      steps {
        sh 'terraform apply -auto-approve tfplan'
      }
    }
    stage('Kubernetes Deployment') {
      steps {
        sh 'kubectl apply -f k8s/deployment.yaml'
        sh 'kubectl apply -f k8s/service.yaml'
      }
    }
  }
}

