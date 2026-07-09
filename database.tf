# =============================================================================
# 4. PROVISION CLOUD SQL RESOURCES
# =============================================================================

resource "google_sql_database_instance" "fpa_budget_db" {
  name             = "fpa-budget-db"
  database_version = "POSTGRES_15"
  region           = var.region
  project          = var.project_id
  depends_on       = [google_project_service.enabled_apis]

  settings {
    tier = "db-custom-1-3840" # 1 vCPU, 3.75GB RAM Custom Machine Type
    ip_configuration {
      ipv4_enabled = true # Enable public IP for gcloud sql access (secured by logins/IAM proxy)
    }
  }
  deletion_protection = false # Set to true for production deployment
}

resource "google_sql_database" "budget_registry" {
  name     = "budget_registry"
  instance = google_sql_database_instance.fpa_budget_db.name
  project  = var.project_id
}

resource "google_sql_user" "pgadmin" {
  name     = "pgadmin"
  instance = google_sql_database_instance.fpa_budget_db.name
  password = var.db_password
  project  = var.project_id
}
