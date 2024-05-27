terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  project     = var.project_name
  region      = var.region
  #  credentials = file("./keys/project-editor-service-account.json")
}

resource "google_artifact_registry_repository" "innohealth" {
  location      = "europe-southwest1"
  repository_id = "innohealth"
  description   = "Stores the docker images for the innohealth excercise"
  format        = "DOCKER"

  docker_config {
    immutable_tags = true
  }
}

resource "google_iam_workload_identity_pool" "cicd_wip" {
  workload_identity_pool_id = "cicd-wip"
  display_name              = "CICD Workload Identity Pool"
  description               = "Identity pool for CICD (GitOps)"
  disabled                  = false
  depends_on = [google_project_service.iam, google_project_service.cloudresourcemanager]

}

resource "google_iam_workload_identity_pool_provider" "github" {
  workload_identity_pool_id = google_iam_workload_identity_pool.cicd_wip.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-provider"
  display_name = "Github"
  description = "Gitops Identity pool provider"
  disabled = false
  attribute_condition = "assertion.repository=='UriCW/innohealth-challenge'"
  attribute_mapping  = {
    "attribute.actor" = "assertion.actor"
    "google.subject" = "assertion.sub"
    "attribute.repository" = "assertion.repository"
    #  "attribute.aud" = "assertion.aud"
  }
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

data "google_project" "project" {}
