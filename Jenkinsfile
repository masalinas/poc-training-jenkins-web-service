pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "ofertoio/web-service"
        KUBE_NAMESPACE = "default"
        KUBE_DEPLOYMENT = "web-service-deployment"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Generate Version') {
            steps {
                script {
                    // Version format: vYYYYMMDD-HHMMSS
                    VERSION = "v" + sh(script: "date +%Y%m%d-%H%M%S", returnStdout: true).trim()
                    echo "Generated version: ${VERSION}"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE}:${VERSION} ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                        docker push ${DOCKER_IMAGE}:${VERSION}
                    """
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh """
cat << 'EOF' | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: simple-web
spec:
  replicas: 1
  selector:
    matchLabels:
      app: simple-web
  template:
    metadata:
      labels:
        app: simple-web
    spec:
      containers:
        - name: simple-web
          image: ${DOCKER_IMAGE}:${VERSION}
          ports:
            - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: simple-web
spec:
  type: NodePort
  selector:
    app: simple-web
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30080
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