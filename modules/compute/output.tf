output private_servers {
    value       = "${aws_instance.private-server.*.id}"
}
output public_servers {
    value       = "${aws_instance.public-server.*.id}"
}
output "public_server_count" {
  description = "The number of public servers being created"
  value       = var.environment == "production" ? 2 : 1
}

output "environment_debug" {
  description = "The environment variable passed to the compute module"
  value       = var.environment
}
