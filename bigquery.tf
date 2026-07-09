# =============================================================================
# 3. PROVISION BIGQUERY RESOURCES
# =============================================================================

resource "google_bigquery_dataset" "fpa_analytics" {
  dataset_id  = "fpa_analytics"
  description = "Dataset containing financial pipeline analytical aggregates"
  location    = "US"
  project     = var.project_id
  depends_on  = [google_project_service.enabled_apis]
}

resource "google_bigquery_table" "hourly_budget_aggregates" {
  dataset_id = google_bigquery_dataset.fpa_analytics.dataset_id
  table_id   = "hourly_budget_aggregates"
  project    = var.project_id

  time_partitioning {
    type  = "HOUR"
    field = "window_start"
  }

  clustering = ["department_id"]

  schema = <<EOF
[
  {
    "name": "department_id",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": "Unique identifier of the department"
  },
  {
    "name": "window_start",
    "type": "TIMESTAMP",
    "mode": "REQUIRED",
    "description": "Start timestamp of the tumbling window"
  },
  {
    "name": "total_spend",
    "type": "FLOAT",
    "mode": "REQUIRED",
    "description": "Sum of expenditures within the hourly window"
  },
  {
    "name": "budget_limit",
    "type": "FLOAT",
    "mode": "REQUIRED",
    "description": "Predefined budget limit for the hour"
  },
  {
    "name": "variance",
    "type": "FLOAT",
    "mode": "REQUIRED",
    "description": "The difference between budget_limit and total_spend"
  }
]
EOF
}
