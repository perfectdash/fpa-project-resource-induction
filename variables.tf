variable "project_id" {
  description = "The Google Cloud Project ID"
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{4,28}[a-z0-9]$", var.project_id))
    error_message = "The project_id must be between 6 and 30 characters, starting with a letter, and containing only lowercase letters, numbers, and hyphens."
  }
}

variable "region" {
  description = "The target region for GCP resources"
  type        = string
  default     = "us-central1"

  validation {
    condition     = can(regex("^[a-z]+-[a-z]+[0-9]$", var.region))
    error_message = "The region name must be a valid GCP region format (e.g. us-central1)."
  }
}

variable "zone" {
  description = "The target zone for GCP database instances"
  type        = string
  default     = "us-central1-a"

  validation {
    condition     = can(regex("^[a-z]+-[a-z]+[0-9]-[a-z]$", var.zone))
    error_message = "The zone name must be a valid GCP zone format (e.g. us-central1-a)."
  }
}

variable "db_password" {
  description = "The master password for the Cloud SQL PostgreSQL instance"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.db_password) >= 8
    error_message = "The db_password must be at least 8 characters long."
  }
}
