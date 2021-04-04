terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.7.0"
    }
    null = {
      source = "hashicorp/null"
      version = "~> 3.1.0"
    }
    random = {
      source = "hashicorp/random"
      version = "~> 3.1.0"
    }
  }
  required_version = ">= 0.14"
}

provider "digitalocean" {
  token = var.do_token
}
