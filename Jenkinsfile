pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "ofertoio/web-service:latest"
        KUBE_NAMESPACE = "default"
        KUBE_DEPLOYMENT = "web-service-deployment"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                        docker push ${DOCKER_IMAGE}
                    """
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Create deployment YAML dynamically
                    sh """
                    cat <<EOF | kubectl apply -f -
                    apiVersion: apps/v1
                    kind: Deployment
                    metadata:
                      name: ${KUBE_DEPLOYMENT}
                      namespace: ${KUBE_NAMESPACE}
                    spec:
                      replicas: 1
                      selector:
                        matchLabels:
                          app: simple-webpage
                      template:
                        metadata:
                          labels:
                            app: simple-webpage
                        spec:
                          containers:
                          - name: simple-webpage
                            image: ${DOCKER_IMAGE}
                            ports:
                            - containerPort: 80
                    ---
                    apiVersion: v1
                    kind: Service
                    metadata:
                      name: simple-webpage-service
                      namespace: ${KUBE_NAMESPACE}
                    spec:
                      selector:
                        app: simple-webpage
                      ports:
                        - protocol: TCP
                          port: 80
                          targetPort: 80
                      type: NodePort
                    EOF
                    """
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline finished"
        }
    }
}