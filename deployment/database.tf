resource "google_sql_database_instance" "this" {
  name             = "patients"
  database_version = "POSTGRES_15"
  region           = var.region

  settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    tier = "db-f1-micro"
  }
}
