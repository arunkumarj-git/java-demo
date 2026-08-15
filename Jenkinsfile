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

        stage('Maven Test') {
            steps {
                sh 'mvn clean test'
            }
        }

        stage('Maven Package') {
            steps {
                sh 'mvn package -DskipTests'
            }
        }

        stage('Check JAR') {
            steps {
                sh '''
                    echo "Checking generated JAR..."
                    find target -name "*.jar" -type f
                '''
            }
        }

        stage('Docker Build') {
            steps {
                sh '''
                    echo "Building Docker image..."
                    docker build -t ${ECR_REPO}:${IMAGE_TAG} .
                '''
            }
        }

        stage('ECR Login') {
            steps {
                sh '''
                    echo "Logging in to Amazon ECR..."

                    aws ecr get-login-password --region ${AWS_REGION} | \
                    docker login --username AWS --password-stdin ${ECR_REGISTRY}
                '''
            }
        }

        stage('Push Image') {
            steps {
                sh '''
                    echo "Pushing Docker image to ECR..."
                    docker push ${ECR_REPO}:${IMAGE_TAG}
                '''
            }
        }

        stage('Verify Image') {
            steps {
                sh '''
                    echo "Docker image pushed successfully:"
                    echo "${ECR_REPO}:${IMAGE_TAG}"
                '''
            }
        }
    }

    post {
        success {
            echo 'Jenkins Pipeline SUCCESS'
        }

        failure {
            echo 'Jenkins Pipeline FAILED'
        }

        always {
            echo 'Pipeline execution completed.'
        }
    }
}
