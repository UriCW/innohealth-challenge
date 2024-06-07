# Innohealth Challenge

A demonstration of an application stack to perform a simple REST operations through frontend.
This was originally a simple demonstration of microservice for a job application.
It's now a bit of a playground for DevOp setups.

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

## Google Cloud

You will need to setup gcloud and terraform and docker.

1. Create resources on Google Cloud

```bash
terraform deploy
```

You will need to set a few variables,
`project_name`, the GCP project to deploy at is the only required one if you are happy with the defaults.
`region` will default to "europe-southwest1"
`github_repo` is this repo and you probably shouldn't change this unless you fork this project for some reason.

This will create a bunch of resources, you will need to set a connection string in Google Secret Manager
`connection-string`, and it should be in the format of
`postgresql://<USER>:<PASSWORD>@localhost:5432/innohealthdb?host=/cloudsql/<PROJECT_NAME>:<REGION>:patients`
This will allow the backend service to connect to the Database.

You also have to configure the database credentials manually on GCP.
I may move those to terraform variables later for easier setup.

## Deploy

Deployment is taken care of using github action workflows, specifically build.yml, which triggers  
`./.github/workflows/build-service.yml` and
`./.github/workflows/build-frontend.yml`. on a PR merge.

You can build, push and deploy the images manually. 
You need to build the docker images of the frontend and the backend, 
tagging them to the corrsponding artifact registry docker repository.
Then You need to push them and deploy the two cloud run instances with those images

``` bash
cd apps/patient_service
docker build . --tag europe-southwest1-docker.pkg.dev/innohealthexcercise/innohealth/bioservice:latest
docker push europe-southwest1-docker.pkg.dev/innohealthexcercise/innohealth/bioservice:latest

cd ../patient_frontend
docker build . --tag europe-southwest1-docker.pkg.dev/innohealthexcercise/innohealth/biofrontend:latest
docker push europe-southwest1-docker.pkg.dev/innohealthexcercise/innohealth/biofrontend:latest
```
