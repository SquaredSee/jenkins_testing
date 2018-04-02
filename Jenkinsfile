pipeline {
  agent any
  stages {
    stage('docker compose') {
      steps {
        sh 'docker-compose up -d'
      }
    }
    stage('test') {
      steps {
          sh 'wget --retry-connrefused --retry-on-http-error=503 --tries=120 --waitretry=2 localhost:8081 -O /dev/null'
        }
      }
    }
    // done in two stages instead of parallel because can't test postgres otherwise
    // waituntil() block fails instantly for some reason
    stage('test postgres') {
      steps {
        sh 'PGPASSWORD=password psql -h localhost -p 5432 -U postgres'
      }
    }
  }
  post {
    always {
      sh 'docker-compose down -v'
    }
  }
}
