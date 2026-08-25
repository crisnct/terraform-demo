resource "google_compute_instance" "vm-from-tf" {
  name         = "vm-from-tf"
  zone         = var.zone
  machine_type = "e2-medium" # e2-medium or e2-standard-2 have high availability

  allow_stopping_for_update = true

  network_interface {
    # NOTE: If custom-vpc-tf has automatic subnetting, this works.
    # If sub-sg was created strictly in us-central1, use the default network or update the subnetwork region.
    network    = "custom-vpc-tf"
    subnetwork = "sub-sg"
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11" # Note: debian-9 is end-of-life
      size  = 10
    }
    auto_delete = true
  }

  labels = {
    "env" = "tfleaning"
  }

  scheduling {
    preemptible       = false
    automatic_restart = false
  }

  service_account {
    email  = "test-terraform@gen-lang-client-0640093980.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }

  lifecycle {
    ignore_changes = [
      attached_disk
    ]
  }
}

resource "google_compute_disk" "disk-1" {
  name = "disk-1"
  size = 15
  zone = var.zone
  type = "pd-ssd"
}

resource "google_compute_attached_disk" "adisk" {
  disk     = google_compute_disk.disk-1.id
  instance = google_compute_instance.vm-from-tf.id
}
