output "root_password" {
  value = random_password.root.result
}

output "non_root_password" {
  value = random_password.non_root.result
}

output "ip_address" {
  value = digitalocean_droplet.droplet.ipv4_address
}
