output "ip" {
  value = "${google_compute_address.ip_address.address}"
}

output "github_webhook_secret" {
  value = "${random_string.secret.result}"
}
