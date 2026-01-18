pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "eslamzain99/recipes_app"
        DOCKER_TAG   = "${BUILD_NUMBER}"
        KUBE_NAMESPACE = "prod"
        cred = credentials('aws-key')
        dockerhub_cred = credentials('docker-cred')
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/eslam-devops/recipes-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh """
                docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .
                docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_IMAGE}:latest
                """
            }
        }

        stage('Docker Login') {
            steps {
                sh "echo $dockerhub_cred_PSW | docker login -u $dockerhub_cred_USR --password-stdin"
                sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
                sh "docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_IMAGE}:latest"
                sh "docker push ${DOCKER_IMAGE}:latest"
                // withCredentials([usernamePassword(
                //     credentialsId: 'dockerhub-creds',
                //     usernameVariable: 'DOCKER_USER',
                //     passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                sh """
                docker push ${DOCKER_IMAGE}:${DOCKER_TAG}
                docker push ${DOCKER_IMAGE}:latest
                """
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                //  sh 'aws eks update-kubeconfig --region us-east-1 --name devops-working'
                // sh 'kubectl apply -f recipes-app-full.yamll'
                sh """
                kubectl apply -f recipes-app-full.yaml/
                kubectl set image deployment/recipes-app \
                  app=${DOCKER_IMAGE}:${DOCKER_TAG} \
                  -n ${KUBE_NAMESPACE}
                
                """
            }
        }

        stage('Verify Deployment') {
            steps {
                sh """
                kubectl rollout status deployment/recipes-app -n ${KUBE_NAMESPACE}
                kubectl get pods -n ${KUBE_NAMESPACE}
                """
            }
        }
    }

    post {
        alwase {
            echo "run it alwase"
        }
        success {
            echo "✅ Deployment completed successfully"
        }
        failure {
            echo "❌ Deployment failed"
        }
    }
}
