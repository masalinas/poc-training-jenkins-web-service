# Description
A simple Web frontend from [startbootstrap](https://startbootstrap.com/) Bootstrap Templates portal

## Build and Test service
Execute these commans to:

- Build image
    ```
    $ docker build -t web-service .
    ```

- Test Image
    ```
    $ docker run --name web-service -d -p 8081:80 web-service
    ```

## Build and Deploy

To build and deploy the service execute the Jenkins pipeline

- **STEP01**: Create the pipeline from repository code in jenkins:

    ![Jenkins Pipeline](./images/jenkins_pipeline.png "Jenkins Pipeline")

- **STEP02**: Pipeline stages execution

    ![Kubernetes Execution](./images/pipeline_execution.png "Pipeline Execution")

- **STEP03**: Docker Image generated in Dockr Hub

    ![Kubernetes Docker Hub Image](./images/dockerhub_web_service.png "Kubernetes Docker Hub Image")

- **STEP04**: Kubernetes resources deployed in default namespace

    ![Kubernetes Resources](./images/kubernetes_resouces.png "Kubernetes Resources")

- **STEP05**: To acces to Web page
    Get the cluster IP
    ```
    $ minikube ip
    192.168.49.2
    ```

- **STEP06**: Get the nodeport generated from kubernetes service called web-service in default namespace

    ![Kubernetes Resources](./images/service_nodeport.png "Kubernetes Resources")

- **STEP07**: Load from broweset using the nodeport geberated
    ```
    http://192.168.49.2:30080
    ```

    ![Web Service Portal](./images/web_service_portal.png "Web Service Portal")