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
        value = var.mock_endpoint
      }

      # This is not optimal
      # https://cloud.google.com/run/docs/configuring/services/secrets#terraform
      # Secrets should be mounted as volume, currently this is visible in run configs
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
        name = "SERVICE_ENDPOINT"
        # value = "https://biocomposition-service-bupfcnw6ca-no.a.run.app/all"
        value = "${google_cloud_run_v2_service.biocomposition_service.uri}/all"
      }
      env {
        name = "TARGET_AUDIENCE"
        # value = "https://biocomposition-service-bupfcnw6ca-no.a.run.app"
        value = google_cloud_run_v2_service.biocomposition_service.uri
      }

      env {
        name = "AUTH0_SECRET"
        value_source {
          secret_key_ref {
            secret  = google_secret_manager_secret.auth0_secret.secret_id
            version = "latest"
          }
        }
      }

      env {
        name = "AUTH0_CLIENT_SECRET"
        value_source {
          secret_key_ref {
            secret  = google_secret_manager_secret.auth0_client_secret.secret_id
            version = "latest"
          }
        }
      }
      env {
        name = "AUTH0_BASE_URL"
        value = "TO SET IN RUN CONFIG AFTER RESOURCE IS CREATED OR WHEN HAVE DOMAIN"

      }
      env {
        name = "AUTH0_ISSUER_BASE_URL"
        value = "TO SET IN RUN CONFIG AFTER RESOURCE IS CREATED"
      }
      env {
        name = "AUTH0_CLIENT_ID"
        value = "TO SET IN RUN CONFIG AFTER RESOURCE IS CREATED"
      }
    }
    service_account = google_service_account.frontend.email
  }
}
