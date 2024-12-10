pipeline {
    agent none
    stages {
        stage('Install Puppet Agent') {
            agent { label 'slave-node' }
            steps {
                script {
                    // Install Puppet agent on the slave node
                    sh '''
                    sudo apt update
                    sudo apt install -y puppet-agent
                    sudo systemctl enable puppet
                    sudo systemctl start puppet
                    '''
                }
            }
        }

        stage('Install Docker Using Ansible') {
            agent { label 'slave-node' }
            steps {
                script {
                    // Push the Ansible configuration to install Docker on the slave node
                    sh '''
                    ansible-playbook -i inventory install_docker.yml
                    '''
                }
            }
        }

        stage('Build and Deploy PHP Web App') {
            agent { label 'slave-node' }
            steps {
                script {
                    // Pull the PHP website and Dockerfile from GitHub repository
                    sh '''
                    git clone https://github.com/<username>/<repo>.git
                    cd <repo>
                    docker build -t php-web-app .
                    docker run -d --name php-web-app -p 80:80 php-web-app
                    '''
                }
            }
        }
    }
    post {
        failure {
            // Delete the running container if Job 3 fails
            script {
                sh '''
                docker stop php-web-app || true
                docker rm php-web-app || true
                '''
            }
        }
    }
}

