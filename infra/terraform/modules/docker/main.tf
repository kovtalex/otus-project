resource "google_compute_instance" "docker" {
  for_each = var.env
  name         = "${var.name}-${each.value}"
  machine_type = var.machine_type
  zone         = var.zone
  tags         = var.app_tags
  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
  boot_disk {
    initialize_params {
      image = var.app_disk_image
    }
  }
  network_interface {
    network = "default"
    access_config {}
  }
}

resource "google_compute_firewall" "firewall_docker-host" {
  name = "docker-host-allow"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["80","3000",]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["docker-host"]
}
