module "storage-bucket" {
  source  = "SweetOps/storage-bucket/google"
  version = "0.3.0"
  location = var.region

  name = "storage-bucket-docker"
}

output storage-bucket_url {
  value = module.storage-bucket.url
}
