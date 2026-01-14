pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "eslamzain99/recipes_app"
        DOCKER_TAG   = "${BUILD_NUMBER}"
        KUBE_NAMESPACE = "prod"
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
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
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
                sh """
                kubectl apply -f k8s/
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
        success {
            echo "✅ Deployment completed successfully"
        }
        failure {
            echo "❌ Deployment failed"
        }
    }
}
