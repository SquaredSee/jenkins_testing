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
        waitUntil() {
          sh '''wget --retry-connrefused --retry-on-http-error=503 --tries=120 --waitretry=2 localhost:8081
'''
        }
        
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