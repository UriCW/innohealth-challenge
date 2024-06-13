resource "google_service_account" "frontend" {
  account_id   = "frontend-service-account"
  description  = "A service account for the Frontend."
  display_name = "Biocomposition Frontend Service Account"
  project      = var.project_name
}

resource "google_service_account" "service" {
  account_id   = "bioservice-account"
  description  = "A service account for the biocomposition service"
  display_name = "Biocomposition Service Account"
  project      = var.project_name
}

resource "google_project_iam_member" "cloudsql-client" {
  project = var.project_name
  role = "roles/cloudsql.client"
  member = "serviceAccount:${google_service_account.service.email}"
}



# Deployment
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

resource "google_cloud_run_service_iam_binding" "frontend-invoker" {
  location = google_cloud_run_v2_service.biocomposition_frontend.location
  service  = google_cloud_run_v2_service.biocomposition_frontend.name
  role     = "roles/run.invoker"
  members = [
    "allUsers"
  ]
}

resource "google_cloud_run_service_iam_binding" "backend-service-invoker" {
  location = google_cloud_run_v2_service.biocomposition_service.location
  service  = google_cloud_run_v2_service.biocomposition_service.name
  role     = "roles/run.invoker"
  members = [
    "serviceAccount:${google_service_account.frontend.email}"
  ]
}

resource "google_secret_manager_secret_iam_member" "connection_string" {
  secret_id = google_secret_manager_secret.connection_string.id
  role      = "roles/secretmanager.secretAccessor"
  member     = "serviceAccount:${google_service_account.service.email}"
  depends_on = [google_secret_manager_secret.connection_string]
}

resource "google_secret_manager_secret_iam_member" "auth0_secret" {
  secret_id = google_secret_manager_secret.auth0_secret.id
  role      = "roles/secretmanager.secretAccessor"
  member     = "serviceAccount:${google_service_account.frontend.email}"
  depends_on = [google_secret_manager_secret.auth0_secret]
}

resource "google_secret_manager_secret_iam_member" "auth0_client_secret" {
  secret_id = google_secret_manager_secret.auth0_client_secret.id
  role      = "roles/secretmanager.secretAccessor"
  member     = "serviceAccount:${google_service_account.frontend.email}"
  depends_on = [google_secret_manager_secret.auth0_client_secret]
}
