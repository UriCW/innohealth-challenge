# Innohealth Challenge

[![Super-Linter](https://github.com/UriCW/innohealth-challenge/actions/workflows/test-service.yml/badge.svg)](https://github.com/marketplace/actions/super-linter)

[![Super-Linter](https://github.com/UriCW/innohealth-challenge/actions/workflows/test-frontend.yml/badge.svg)](https://github.com/marketplace/actions/super-linter)




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
It will expose the service on `localhost:3001` and the frontend on `localhost:3000`

You can query the service directly by using `curl localhost:3001/all` and `curl localhost:3001/update`
You can use the frontend by browsing to `localhost:3000/`

