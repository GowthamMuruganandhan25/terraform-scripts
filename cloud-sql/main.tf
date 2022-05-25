resource "google_sql_database_instance" "primary" {
  provider            = google-beta
  project             = var.project_id
  name                = var.name
  region              = var.region
  database_version    = var.database_version
  encryption_key_name = var.encryption_key_name

  settings {
    tier              = var.tier
    disk_size         = var.disk_size
    disk_type         = var.disk_type
    availability_type = var.availability_type
    user_labels       = var.labels

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.network
      dynamic "authorized_networks" {
        for_each = var.authorized_networks != null ? var.authorized_networks : {}
        iterator = network
        content {
          name  = network.key
          value = network.value
        }
      }
    }
  }
   deletion_protection = var.deletion_protection
}