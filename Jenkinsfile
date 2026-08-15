pipeline {

    agent any

    environment {
        AWS_REGION = 'ap-south-1'
        AWS_ACCOUNT_ID = '869843199190'
        ECR_REGISTRY = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
        ECR_REPO = "${ECR_REGISTRY}/java-demo"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Docker Build') {
            steps {
                sh '''
                    docker build \
                    -t ${ECR_REPO}:${IMAGE_TAG} .
                '''
            }
        }

        stage('ECR Login') {
            steps {
                sh '''
                    aws ecr get-login-password \
                    --region ${AWS_REGION} | \
                    docker login \
                    --username AWS \
                    --password-stdin ${ECR_REGISTRY}
                '''
            }
        }

        stage('Push Image') {
            steps {
                sh '''
                    docker push ${ECR_REPO}:${IMAGE_TAG}
                '''
            }
        }
    }

    post {
        success {
            echo 'Build and Docker image push completed successfully.'
        }

        failure {
            echo 'Pipeline failed. Check the Console Output.'
        }
    }
}
    }
}
}
