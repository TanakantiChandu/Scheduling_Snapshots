terraform {
  required_version = ">=0.12.0"
  required_providers {
    google = ">=2.11.0"
  }
}
provider "google" {
  credentials = var.key
  project     = var.project_id
}