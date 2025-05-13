pipeline {
    agent any

    environment {
        VENV_DIR = 'venv'
    }

    stages {
        stage('Cloning github repo to jenkins') {
            steps {
                script {
                    echo "Cloning github repo to jenkins ..................."
                    checkout scmGit(
                        branches: [[name: '*/main']],
                        extensions: [],
                        userRemoteConfigs: [[
                            credentialsId: 'github-token',
                            url: 'https://github.com/daotuongcxz/mlops-project.git'
                        ]]
                    )
                }
            }
        }
        stage('Setting up our vitual env and install dependency') {
            steps {
                script {
                    echo "Setting up our vitual env and install dependency ..................."
                    sh '''
                    python -m venv ${VENV_DIR}
                    . ${VENV_DIR}/bin/activate
                    pip install --upgrade pip
                    pip install -e
                    '''
                }
            }
        }
    }
}
