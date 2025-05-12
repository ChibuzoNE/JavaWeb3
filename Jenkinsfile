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
                // Optional: Only needed if Docker might not be running
                bat 'net start com.docker.service || exit 0'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}:latest")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_HUB_CREDENTIALS}") {
                        docker.image("${IMAGE_NAME}:latest").push()
                    }
                }
            }
        }
    }
}
