resource "google_compute_instance" "vm_instance" {
  name         = "instance-snap"
  machine_type = var.machine
  zone         = var.zone
  tags         = ["http-server", "https-server"]
  boot_disk {
    auto_delete = false
    mode        = "READ_WRITE"
    initialize_params {
      image = "debian-cloud/debian-10"
      type  = "pd-ssd"
      size  = 20
    }
  }
  metadata_startup_script = var.startupscript
  network_interface {
    network = "default"
    access_config {
    }
  }
  scheduling {
    on_host_maintenance = "MIGRATE"
    automatic_restart   = true
  }

}


resource "google_compute_disk" "persistent" {
  name = "persistent-disk"
  type = "pd-ssd"
  size = 50
  zone = var.zone
}


resource "google_compute_attached_disk" "persistent" {
  disk        = google_compute_disk.persistent.name
  instance    = google_compute_instance.vm_instance.name
  device_name = "fast"
  mode        = "READ_WRITE"
  zone        = var.zone
}

/*
resource "google_compute_snapshot" "snapshot_vm" {
  name        = "my-snapshot"
  source_disk = google_compute_instance.vm_instance.name
  zone        = var.zone
  labels = {
    my_label = "value"
  }
  storage_locations = ["us-central1"]
}

resource "google_compute_snapshot" "snapshot_vm2" {
  name        = "my-snapshot2"
  source_disk = google_compute_instance.vm_instance.name
  zone        = var.zone
  labels = {
    my_label = "value"
  }
  storage_locations = ["us-central1"]
}


resource "google_compute_snapshot" "snapshot-disk" {
  name        = "disk-snapshot"
  source_disk = google_compute_disk.persistent.name
  zone        = var.zone
  labels = {
    my_label = "value"
  }
  storage_locations = ["us-central1"]
}
*/