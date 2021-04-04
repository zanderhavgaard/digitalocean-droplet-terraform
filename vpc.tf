resource "digitalocean_vpc" "vpc" {
  name = "experiment-vpc"
  region = var.region
}
