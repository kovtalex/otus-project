output "external_ip" {
  value = { 
    "dev"     = google_compute_instance.docker["dev"].network_interface[0].access_config[0].nat_ip,
    "preprod" = google_compute_instance.docker["preprod"].network_interface[0].access_config[0].nat_ip,
    "prod"    = google_compute_instance.docker["prod"].network_interface[0].access_config[0].nat_ip
  }
}
