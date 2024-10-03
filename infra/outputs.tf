output "Server" {
  value = "http://${aws_lb.server.dns_name}"
}

output "Metrics" {
  value = "http://${aws_lb.server.dns_name}/metrics"
}

output "Grafana" {
  value = "http://${aws_lb.grafana.dns_name}"
}

output "s3_bucket_name" {
  value       = var.bucket_name
}

