pipeline {
  agent any
  stages {
    stage('docker compose') {
      steps {
        sh 'docker-compose up -d'
      }
    }
    stage('test jira') {
      steps {
        sh 'wget --retry-connrefused --waitretry=1 -q localhost:8081'
        sh 'curl localhost:8081'
      }
    }
    stage('test postgres') {
      steps {
        sh 'PGPASSWORD=password psql -h localhost -p 5432 -U postgres'
        sh '\\q'
      }
    }
  }
  post {
    always {
      sh 'docker-compose down -v'
      
    }
    
  }
}