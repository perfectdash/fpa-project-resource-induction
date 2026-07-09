# =============================================================================
# 5. PROVISION STORAGE BUCKETS FOR DATAFLOW
# =============================================================================

resource "google_storage_bucket" "dataflow_temp_bucket" {
  name                        = "${var.project_id}-dataflow-storage"
  location                    = "US"
  project                     = var.project_id
  force_destroy               = true
  uniform_bucket_level_access = true
  depends_on                  = [google_project_service.enabled_apis]
}
