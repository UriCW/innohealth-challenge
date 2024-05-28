# resource "google_service_account" "ais_listener" {
#   account_id   = "ais-listener-service-account"
#   description  = "A service account for the AIS Listener service."
#   display_name = "AIS Listener Service Account"
#   project      = var.project_name
# }
# 
# resource "google_service_account" "ais_user" {
#   account_id   = "ais-user-service-account"
#   description  = "A service account for applications that use the AIS service endpoints or read from big query database, etc."
#   display_name = "AIS User Service Account"
#   project      = var.project_name
# }

resource "google_service_account" "deployment" {
  account_id   = "deployment-service"
  description  = "A service that can push to artefact registry to update a docker image."
  display_name = "Deployment Service"
  project      = var.project_name
  depends_on = [google_project_service.iam, google_project_service.cloudresourcemanager]
}

resource "google_artifact_registry_repository_iam_member" "artifact-pusher" {
  role = "roles/artifactregistry.writer"
  repository = google_artifact_registry_repository.innohealth.name
  location = google_artifact_registry_repository.innohealth.location
  member = "serviceAccount:${google_service_account.deployment.email}"
}

resource "google_project_iam_member" "workload-identity-user" {
  project = var.project_name
  role = "roles/iam.workloadIdentityUser"
  member = "serviceAccount:${google_service_account.deployment.email}"
}

resource "google_project_iam_member" "service-account-user" {
  project = var.project_name
  role = "roles/iam.serviceAccountUser"
  member = "serviceAccount:${google_service_account.deployment.email}"
}

resource "google_project_iam_member" "service-account-token-creator" {
  project = var.project_name
  role = "roles/iam.serviceAccountTokenCreator"
  member = "serviceAccount:${google_service_account.deployment.email}"
}

resource "google_project_iam_member" "cloud-run-developer" {
  project = var.project_name
  role = "roles/run.developer"
  member = "serviceAccount:${google_service_account.deployment.email}"
}

resource "google_service_account_iam_binding" "admin-account-iam" {
  service_account_id = google_service_account.deployment.name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.gitops_wip.name}/attribute.repository/${var.git_repo}"
  ]
}

