pipeline {
  agent any
  stages {
    stage('docker compose') {
      steps {
        sh '/usr/local/bin/docker-compose up'
      }
    }
    stage('test') {
      parallel {
        stage('test jira') {
          steps {
            sh 'curl localhost:8081'
          }
        }
        stage('test postgres') {
          steps {
            sh 'curl localhost:5432'
          }
        }
      }
    }
  }
}