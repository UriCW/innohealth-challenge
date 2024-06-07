resource "google_sql_database_instance" "this" {
  name             = "patients"
  database_version = "POSTGRES_15"
  region           = var.region
  deletion_protection = false

  settings {
    tier = "db-f1-micro"
  }
}
