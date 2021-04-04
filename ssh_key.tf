# key used for autmated access when provisioning
resource "digitalocean_ssh_key" "access_key" {
  name = "access_key"
  public_key = file(var.pub_key)
}
