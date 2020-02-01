terraform {
  backend "gcs" {
    bucket = "storage-bucket-kovtalex"
    prefix = "docker"
  }
}
