pipeline {
    agent any

    tools {
    maven 'Maven3'
}

    environment {
        IMAGE_NAME = "chibuzone/javaweb3"
        DOCKER_CREDENTIALS_ID = "dockerhub-creds"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git url: 'https://github.com/ChibuzoNE/JavaWeb3.git'
            }
        }

        stage('Build with Maven') {
            steps {
                bat 'mvn clean package'
            }
        }

        stage('Setup Docker') {
            steps {
                script {
                    // For Windows
                    bat 'net start docker || true'
                    // For Linux: sh 'sudo systemctl start docker'
                }
            }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("chibuzone/javaweb3:latest")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: "${DOCKER_CREDENTIALS_ID}",
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    bat 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    bat "docker push ${IMAGE_NAME}:latest"
                }
            }
        }
    }
}
