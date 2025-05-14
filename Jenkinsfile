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

        stage('Build and Push Docker Image') {
            steps {
                withCredentials([file(credentialsId: 'gcp-key', variable: 'GCP_CREDENTIALS')]) {
                    script {
                        sh '''
                        cp ${GCP_CREDENTIALS} long-state-452316-d2-1e09a3e52402.json
                        docker build -t ml-project .
                        rm -f long-state-452316-d2-1e09a3e52402.json
                        '''
                        
                        docker.withRegistry('', registryCredential) {
                            dockerImage.push()
                            dockerImage.push('latest')
                        }
                    }
                }
            }
        }
        
    }
}