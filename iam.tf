# =============================================================================
# 6. IAM ROLES & SERVICE ACCOUNTS
# =============================================================================

# A. FastAPI Ingest Service Account
resource "google_service_account" "fastapi_ingester" {
  account_id   = "fastapi-ingester"
  display_name = "FastAPI Ingestion Service Account"
  project      = var.project_id
  depends_on   = [google_project_service.enabled_apis]
}

resource "google_project_iam_member" "ingester_pubsub_publisher" {
  project = var.project_id
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:${google_service_account.fastapi_ingester.email}"
}

# B. Dataflow Worker Service Account
resource "google_service_account" "dataflow_worker" {
  account_id   = "dataflow-worker"
  display_name = "Dataflow Pipeline Worker Service Account"
  project      = var.project_id
  depends_on   = [google_project_service.enabled_apis]
}

locals {
  dataflow_worker_roles = [
    "roles/dataflow.worker",
    "roles/pubsub.subscriber",
    "roles/bigquery.dataEditor",
    "roles/cloudsql.client",
    "roles/storage.objectAdmin"
  ]
}

resource "google_project_iam_member" "dataflow_worker_permissions" {
  for_each = toset(local.dataflow_worker_roles)
  project  = var.project_id
  role     = each.key
  member   = "serviceAccount:${google_service_account.dataflow_worker.email}"
}
