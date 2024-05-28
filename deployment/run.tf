resource "google_cloud_run_v2_service" "biocomposition_service" {
  name     = "biocomposition-service"
  location = var.region
  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = "europe-southwest1-docker.pkg.dev/innohealthexcercise/innohealth/bioservice"
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
