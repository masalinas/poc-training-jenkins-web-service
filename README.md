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

Create the pipeline from repository code
![Jenkins Pipeline](./images/jenkins_pipeline.png "Jenkins Pipeline")

Pipeline Stage Execution
![Kubernetes Execution](./images/pipeline_execution.png "Pipeline Execution")

Kubernetes resources deployed
![Kubernetes Resources](./images/kubernetes_resouces.png "Kubernetes Resources")

To acces to Web page
Get the cluster IP
```
$ minikube ip
192.168.49.2
```

Get the nodeport generated from servicve web-service:
![Kubernetes Resources](./images/service_nodeport.png "Kubernetes Resources")

Load from broweset using the nodeport geberated
```
http://192.168.49.2:30080
```

![Web Service Portal](./images/web_service_portal.png "Web Service Portal")