# =============================================================================
# 7. PROVISION ARTIFACT REGISTRY
# =============================================================================

resource "google_artifact_registry_repository" "fpa_repo" {
  location      = var.region
  repository_id = "fpa-repo"
  description   = "Docker repository for FP&A applications"
  format        = "DOCKER"
  project       = var.project_id
  depends_on    = [google_project_service.enabled_apis]
}
