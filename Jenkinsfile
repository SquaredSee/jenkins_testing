pipeline {
    agent { docker { image 'python' } }
    stages {
        stage('build') {
            steps {
                cmd 'python --version'
            }
        }
    }
}
