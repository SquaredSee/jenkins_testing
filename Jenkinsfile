pipeline {
  agent any
  stages {
    stage('docker compose') {
      steps {
        sh 'docker-compose up -d'
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
  post {
    always {
      sh 'docker-compose down -v'
    }
  }
}
