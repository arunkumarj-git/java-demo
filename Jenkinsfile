
pipeline {

    agent any

    stages {

        stage('Checkout') {
            steps {
                echo '====================================='
                echo '       CHECKOUT JAVA-DEMO             '
                echo '====================================='

                git branch: 'main',
                    url: 'https://github.com/arunkumarj-git/java-demo.git'
            }
        }

        stage('Build') {
            steps {
                echo '====================================='
                echo '       BUILD JAVA APPLICATION         '
                echo '====================================='

                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Docker Build') {
            steps {
                echo '====================================='
                echo '       BUILD DOCKER IMAGE             '
                echo '====================================='

                sh 'docker build -t java-demo:latest .'
            }
        }

        stage('Stop Old Container') {
            steps {
                echo '====================================='
                echo '       STOP OLD CONTAINER             '
                echo '====================================='

                sh '''
                    docker stop java-demo || true
                    docker rm java-demo || true
                '''
            }
        }

        stage('Deploy') {
            steps {
                echo '====================================='
                echo '       DEPLOY JAVA-DEMO               '
                echo '====================================='

                sh '''
                    docker run -d \
                      --name java-demo \
                      -p 8080:8080 \
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
            echo 'Server      : 15.252.18.216'
            echo 'Port        : 8080'
            echo 'Website     : http://15.252.18.216:8080'
            echo '====================================='
        }

        failure {
            echo '====================================='
            echo '       DEPLOYMENT FAILED              '
            echo '====================================='
        }
    }
}
