resource "google_cloud_run_v2_service" "biocomposition_service" {
  name     = "biocomposition-service"
  location = var.region
  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = "europe-southwest1-docker.pkg.dev/innohealthexcercise/innohealth/bioservice"
      ports {
        container_port = 3000
      }
      env {
        name = "ENDPOINT_URL"
        value = "https://mockapi-furw4tenlq-ez.a.run.app/data"
      }
      env {
        name = "DATABASE_URL"
        value = "postgresql://user:password@localhost:5432/innohealthdb?host=/cloudsql/innohealthexcercise:europe-southwest1:patients"
      }
    }
  }
}

resource "google_cloud_run_v2_service" "biocomposition_frontend" {
  name     = "biocomposition-frontend"
  location = var.region
  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = "europe-southwest1-docker.pkg.dev/innohealthexcercise/innohealth/biofrontend"
    }
  }
}
