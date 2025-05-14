pipeline{
    agent any

    environment {
        VENV_DIR = 'venv'
        GCP_PROJECT = "long-state-452316-d2"
        GCLOUD_PATH = "/var/jenkins_home/google-cloud-sdk/bin"
        registry = 'truongnguyen250902'
        registryCredential = 'dockerhub'
    }

    stages{
        stage('Cloning Github repo to Jenkins'){
            steps{
                script{
                    echo 'Cloning Github repo to Jenkins............'
                    checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'github-token', url: 'https://github.com/daotuongcxz/mlops-project.git']])
                }
            }
        }

        stage('Setting up our Virtual Environment and Installing dependancies'){
            steps{
                script{
                    echo 'Setting up our Virtual Environment and Installing dependancies............'
                    sh '''
                    python -m venv ${VENV_DIR}
                    . ${VENV_DIR}/bin/activate
                    pip install --upgrade pip
                    pip install -e .
                    '''
                }
            }
        }

        stage('Build and Push') {
            steps {
                withCredentials([
                    file(credentialsId: 'gcp-key', variable: 'GCP_CRED'),
                    usernamePassword(
                        credentialsId: 'dockerhub',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PWD'
                    )
                ]) {
                    script {
                        def imageName = "${DOCKER_USER}/ml-project"
                        
                        // Build
                        sh """
                            cp "${GCP_CRED}" credentials.json
                            docker build \\
                                -t "${imageName}:${env.BUILD_NUMBER}" \\
                                -t "${imageName}:latest" \\
                                .
                            rm -f credentials.json
                        """
                        
                        withEnv(["DOCKER_PWD=${DOCKER_PWD}", "DOCKER_USER=${DOCKER_USER}"]) {
                            sh '''
                                echo "$DOCKER_PWD" | docker login -u "$DOCKER_USER" --password-stdin "$DOCKER_REGISTRY"
                                docker push "$DOCKER_USER"/ml-project:${env.BUILD_NUMBER}
                                docker push "$DOCKER_USER"/ml-project:latest
                            '''
                        }
                    }
                }
            }
        }
        
    }
}