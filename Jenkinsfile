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
            sh 'PGPASSWORD=password psql -h localhost -p 5432 -U postgres'
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
