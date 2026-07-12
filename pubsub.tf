# =============================================================================
# 2. PROVISION PUBSUB RESOURCES
# =============================================================================

resource "google_pubsub_topic" "transactions" {
  name       = "transactions"
  project    = var.project_id
  depends_on = [google_project_service.enabled_apis]
}

resource "google_pubsub_subscription" "transactions_sub" {
  name    = "transactions-sub"
  topic   = google_pubsub_topic.transactions.name
  project = var.project_id
}

resource "google_pubsub_topic" "budget_breaches_alerts" {
  name       = "budget-breaches-alerts"
  project    = var.project_id
  depends_on = [google_project_service.enabled_apis]
}

resource "google_pubsub_subscription" "budget_breaches_alerts_sub" {
  name    = "budget-breaches-alerts-sub"
  topic   = google_pubsub_topic.budget_breaches_alerts.name
  project = var.project_id

  # Retain undelivered messages for 7 days
  message_retention_duration = "604800s"
  ack_deadline_seconds       = 30
}
