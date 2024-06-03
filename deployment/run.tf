resource "google_cloud_run_v2_service" "biocomposition_service" {
  name     = "biocomposition-service"
  location = var.region
  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = "europe-southwest1-docker.pkg.dev/innohealthexcercise/innohealth/bioservice:latest"
      volume_mounts {
        name       = "cloudsql"
        mount_path = "/cloudsql"
      }
      ports {
        container_port = 8080
      }
      env {
        name = "ENDPOINT_URL"
        value = "https://mockapi-furw4tenlq-ez.a.run.app/data"
      }
      env {
        name = "DATABASE_URL"
        value = data.google_secret_manager_secret_version.latest.secret_data
        # value = "postgresql://<USER>:<PASSWORD>@localhost:5432/innohealthdb?host=/cloudsql/innohealthexcercise:europe-southwest1:patients"
      }
    }
    volumes {
      name = "cloudsql"
      cloud_sql_instance {
      instances = [google_sql_database_instance.this.connection_name]
      }
    }
  }
  client     = "terraform"
  depends_on = [google_project_service.secretmanager, google_project_service.run, google_project_service.sqladmin]
}

resource "google_cloud_run_v2_service" "biocomposition_frontend" {
  name     = "biocomposition-frontend"
  location = var.region
  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = "europe-southwest1-docker.pkg.dev/innohealthexcercise/innohealth/biofrontend:latest"
      env {
        # Should come from config here for testing
        name = "SERVICE_ENDPOINT"
        value = "https://biocomposition-service-bupfcnw6ca-no.a.run.app/all"
      }
      env {
        # Should come from config here for testing
        NAME = "TARGET_AUDIENCE"
        value = "https://biocomposition-service-bupfcnw6ca-no.a.run.app"
      }
    }
    service_account = google_service_account.frontend.email
  }
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

# data "google_iam_policy" "backend-invoker" {
#   binding {
#     role = "roles/run.invoker"
#     members = [
#       "serviceAccount:${google_service_account.frontend.email}"
#     ]
#   }
# }
# 
# resource "google_cloud_run_service_iam_policy" "backend-invoker" {
#   location = google_cloud_run_v2_service.biocomposition_service.location
#   #  project  = google_cloud_run_v2_service.private.project
#   service  = google_cloud_run_v2_service.biocomposition_service.name
# 
#   policy_data = data.google_iam_policy.backend-invoker.policy_data
# }
