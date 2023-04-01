# new-app


# To deploy a Node.js app to Kubernetes and exposing it to your subdomain using Ingress and the Nginx Ingress Controller, you can follow these steps:

    1 - Install the Nginx Ingress Controller: 
    Install the Nginx Ingress Controller in your Kubernetes cluster.

    2- Create a Kubernetes deployment file: 
    Create a deployment file for your Node.js app in Kubernetes, specifying the container image, environment variables, and other configuration options.

    3- Create a Kubernetes service file: 
    Create a service file that exposes your Node.js app to other pods in the Kubernetes cluster.

    4- Create an Ingress file: 
    Create an Ingress file that defines the routing rules for your subdomain. In the Ingress file, you'll specify the subdomain, the path to your Node.js app, and other configuration options.

    5- Apply the deployment, service, and Ingress files: 
    Use the kubectl apply command to apply the deployment, service, and Ingress files to your Kubernetes cluster.

    6- Configure your DNS: 
    Configure your DNS settings to point your subdomain to the IP address of the Nginx Ingress Controller.

    7- Test your app: Test your app by visiting your subdomain in a web browser. You should see your Node.js app running.

Here's an example deployment file for a Node.js app:

apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-nodejs-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: my-nodejs-app
  template:
    metadata:
      labels:
        app: my-nodejs-app
    spec:
      containers:
        - name: my-nodejs-app
          image: your-docker-image:latest
          env:
            - name: NODE_ENV
              value: production
          ports:
            - containerPort: 3000
And here's an example service file:

apiVersion: v1
kind: Service
metadata:
  name: my-nodejs-app
spec:
  selector:
    app: my-nodejs-app
  ports:
    - name: http
      port: 80
      targetPort: 3000
And here's an example Ingress file:

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-nodejs-app
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /$1
spec:
  rules:
    - host: my-subdomain.example.com
      http:
        paths:
          - path: /myapp(/|$)(.*)
            pathType: Prefix
            backend:
              service:
                name: my-nodejs-app
                port:
                  name: http
Note that you'll need to replace your-docker-image with the name of your Docker image. You'll also need to update the host field in the Ingress file to match your subdomain, and update the path field in the Ingress file to match the path to your Node.js app.




# Here are some more details for step 6, which is configuring your DNS:

    1- Find the IP address of the Nginx Ingress Controller: 
    You can find the IP address of the Nginx Ingress Controller by running the following command in your Kubernetes cluster:

    kubectl get services -n ingress-nginx
    Look for the ingress-nginx-controller service and note the IP address listed in the EXTERNAL-IP column.

    2- Update your DNS settings: 
    Log in to your domain registrar or DNS provider and create a new DNS record for your subdomain. Set the record to point to the IP address of the Nginx Ingress Controller that you found in step 1.

    The exact steps for updating your DNS settings will depend on your registrar or provider. Here are some general instructions:

        Create a new DNS record for your subdomain.
        Choose "A" as the record type.
        Enter your subdomain in the "Name" field.
        Enter the IP address of the Nginx Ingress Controller in the "IPv4 Address" field.
        Save your changes.
        Note that it may take some time for your DNS changes to propagate.

    3- Test your DNS settings: 
    Test your DNS settings by pinging your subdomain from your local computer. Open a terminal or command prompt and run the following command:

    ping my-subdomain.example.com
    Replace my-subdomain.example.com with your actual subdomain. You should see responses from the IP address of the Nginx Ingress Controller.

    If you don't see responses, double-check your DNS settings and wait a few minutes for the changes to propagate.



# Creating docker image 
    - Building an image from the Dockerfile 
      docker build -t newapp .
    
    - Creating container from the docker image to test the image.
      docker run -d -p 8033:3000 --name newapp -it newapp
    
    - Tagging v1 and pushing the image to docker hub 
      docker tag newapp your-dockerhub-username/newapp:v1
      docker login
      docker push your-dockerhub-username/newapp:v1