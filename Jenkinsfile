pipeline {   
  agent {
    label 'master'
  }
    environment {
      PATH = "/usr/local/bin:$PATH"
  }  
  stages {
    stage('checkout') {
      steps {
        checkout scm
      }
    }
    stage('init') {
      steps {
        sh 'terraform init'
      }
    }
    stage('plan') {
      steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: 'aws-creds',
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
          sh 'terraform plan'
        }
      }
    }
    stage('approval') {
      options {
        timeout(time: 1, unit: 'HOURS') 
      }
      steps {
        input 'review the plan and approve to apply'
      }
    }
    stage('apply') {
      steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: 'aws-creds',
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
          sh 'terraform apply -auto-approve'
        } 
        cleanWs()
      }
    }
  }
}