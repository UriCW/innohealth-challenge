resource "google_cloud_run_v2_service" "patient_service" {
  name     = "patient-service"
  location = var.region
  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = "europe-southwest1-docker.pkg.dev/innohealthexcercise/innohealth/service"
    }
  }
}
