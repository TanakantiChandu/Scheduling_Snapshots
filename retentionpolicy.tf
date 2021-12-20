resource "google_compute_resource_policy" "daily10pm_ret14" {
  name   = "daily-shedule"
  region = var.region
  #project = var.project_id
  snapshot_schedule_policy {
    schedule {
      hourly_schedule {
        hours_in_cycle = 1
        start_time     = "12:00"
      }
    }
    retention_policy {
      max_retention_days    = 14
      on_source_disk_delete = "KEEP_AUTO_SNAPSHOTS"
    }
    snapshot_properties {
      labels = {
        my_label = "value"
      }
      storage_locations = ["us"]
      #guest_flush       = true
    }
  }
}

resource "google_compute_disk_resource_policy_attachment" "attachment1" {
  name = google_compute_resource_policy.daily10pm_ret14.name
  disk = google_compute_disk.persistent.name
  zone = "us-central1-a"
}

resource "google_compute_disk_resource_policy_attachment" "attachment2" {
  name = google_compute_resource_policy.daily10pm_ret14.name
  disk = google_compute_instance.vm_instance.name
  zone = "us-central1-a"
}
