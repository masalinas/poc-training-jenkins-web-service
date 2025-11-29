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