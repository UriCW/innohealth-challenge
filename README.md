# Innohealth Challenge

A demonstration of an application stack to perform a simple REST operations through frontend

# Strucutre
The application is actually two applications, a microservice and a fontend, each with their own Dockerfile.
these reside in `apps/patient_service` and `apps/patient_frontend`

The resources required to deploy this application on Google Cloud are defined in `deployment/` using terraform.
A github CI is defined in .github/workflows/ 

The microservice contains a few symbolic tests

# Deployment

## Local

You can deploy the application locally using `docker-compose up`, this should spin up a database and the two components of the application
It will expose the service on `localhost:3001` and the service on `localhost:3000`

You can query the service directly by using `curl localhost:3000/all` and `curl localhost:3000/update`

## Remote


