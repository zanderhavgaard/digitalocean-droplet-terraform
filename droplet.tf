
# create main VM
resource "digitalocean_droplet" "droplet" {
  name = "droplet"
  region = var.region
  image = var.vm_image
  size = var.vm_size
  private_networking = true
  vpc_uuid = digitalocean_vpc.vpc.id
  ssh_keys = [
    digitalocean_ssh_key.access_key.fingerprint,
  ]
}

# configure the new server as root
resource "null_resource" "main-root-provisioner" {
  depends_on = [
    digitalocean_droplet.droplet,
  ]

  # setup ssh connection
  connection {
    user = "root"
    host = digitalocean_droplet.droplet.ipv4_address
    type = "ssh"
    private_key = file(var.pvt_key)
    timeout = "2m"
  }

  # execute setup script using ssh
  provisioner "remote-exec" {
    inline = [
      # wait for cloud-init to finish
      "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done",

      # update system and install moreutils
      "DEBIAN_FRONTEND=noninteractive apt-get update -qq",
      "DEBIAN_FRONTEND=noninteractive apt-get -o \"Dpkg::Options::=--force-confdef\" -o \"Dpkg::Options::=--force-confold\" upgrade -yqq",
      "DEBIAN_FRONTEND=noninteractive apt-get install -yqq ufw docker.io docker-compose gnupg2 pass ${var.apt_packages}",
      "systemctl enable --now docker",

      "echo \"root:${random_password.root.result}\" | chpasswd",
      "useradd -s /bin/bash -m ${var.username}",
      "usermod -aG docker ${var.username}",
      "usermod -aG sudo ${var.username}",
      "echo \"${var.username}:${random_password.non_root.result}\" | chpasswd",
      "mkdir -p /home/${var.username}/.ssh",
      "cp /root/.ssh/authorized_keys /home/${var.username}/.ssh/authorized_keys",
      "chown -R ${var.username}:${var.username} /home/${var.username}",
    ]
  }
}
