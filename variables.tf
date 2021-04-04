variable "region" {
  description = "digitalocean region"
  type = string
  default = "fra1"
}

variable "do_token" {
  description = "digitalocean access token"
  type = string
}

variable "pub_key" {
  description = "path to ssh public key"
  type = string
  default = "secrets/key.pub"
}

variable "pvt_key" {
  description = "path to ssh private key"
  type = string
  default = "secrets/key"
}

variable "apt_packages" {
  description = "apt packages to install"
  type = string
  default = ""
}

variable "vm_image" {
  description = "the droplet linux image"
  type = string
  default = "ubuntu-20-04-x64"
}

variable "vm_size" {
  description = "size of droplet vm"
  type = string
  default = "s-1vcpu-1gb"
}

variable "password_length" {
  description = "length of generated passwords"
  type = number
  default = 64
}

variable "username" {
  description = "username of created non-root user"
  type = string
  default = "ubuntu"
}
