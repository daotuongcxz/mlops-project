pipeline {
    agent any

    stages {
        stage('Cloning github repo to jenkins')
        step {
            script {
                echo "Cloning github repo to jenkins ..................."
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'github-token', url: 'https://github.com/daotuongcxz/mlops-project.git']])

            }
        }
    }

}