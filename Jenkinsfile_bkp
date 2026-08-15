
pipeline {

    agent any

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/arunkumarj-git/java-demo.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t java-demo:latest .'
            }
        }

        stage('Stop Old Container') {
            steps {
                sh '''
                    docker stop java-demo || true
                    docker rm java-demo || true
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    docker run -d \
                      --name java-demo \
                      -p 9091:9091 \
                      java-demo:latest
                '''
            }
        }
    }

    post {
        success {
            echo '====================================='
            echo '      DEPLOYMENT SUCCESSFUL           '
            echo '====================================='
            echo 'Application : java-demo'
            echo 'Server      : 13.201.227.10'
            echo 'Port        : 9091'
            echo 'Website     : http://13.201.227.10:9091'
            echo '====================================='
        }

        failure {
            echo 'DEPLOYMENT FAILED'
        }
    }
}
