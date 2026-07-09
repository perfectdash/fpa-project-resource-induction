output "sql_instance_connection_name" {
  description = "The connection name of the Cloud SQL instance"
  value       = google_sql_database_instance.fpa_budget_db.connection_name
}

output "dataflow_storage_bucket_url" {
  description = "The URL of the GCS bucket for Dataflow temp files"
  value       = google_storage_bucket.dataflow_temp_bucket.url
}

output "fastapi_ingester_service_account" {
  description = "The email address of the FastAPI ingester service account"
  value       = google_service_account.fastapi_ingester.email
}

output "dataflow_worker_service_account" {
  description = "The email address of the Dataflow worker service account"
  value       = google_service_account.dataflow_worker.email
}
