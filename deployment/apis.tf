#Enable APIs
# Not enabling APIs on deploy, not sure why

# resource "google_project_service" "cloudresourcemanager" {
#   service = "cloudresourcemanager.googleapis.com"
# }
resource "google_project_service" "computeapi" {
  service = "compute.googleapis.com"
}
# resource "google_project_service" "alloydbapi" {
#   service = "alloydb.googleapis.com"
# }

# resource "google_project_service" "servicenetworkingapi" {
#   service = "servicenetworking.googleapis.com"
# }

resource "google_project_service" "artifactregistry" {
  service = "artifactregistry.googleapis.com"
}

resource "google_project_service" "iamcredentials" {
  service = "iamcredentials.googleapis.com"
  disable_dependent_services = true
}

resource "google_project_service" "iam" {
  service = "iam.googleapis.com"
}

resource "google_project_service" "run" {
  service = "run.googleapis.com"
}

resource "google_project_service" "cloudresourcemanager" {
  service = "cloudresourcemanager.googleapis.com"
}
