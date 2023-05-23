terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_kubernetes_cluster" "k8s" {
  name    = "${var.k8s_name}-${terraform.workspace}"
  region  = var.region
  version = var.k8s_version

  node_pool {
    name       = "pool-k8s"
    size       = var.k8s_node_size
    node_count = var.k8s_node_count
  }

#   lifecycle {
#     prevent_destroy = true
#   }
}

variable "do_token" {
  type = string
}

variable "k8s_name" {
  type    = string
  default = "k8s-terraform"
}

variable "region" {
  type    = string
  default = "nyc1"
}

variable "k8s_version" {
  type    = string
  default = "1.26.3-do.0"
}

variable "k8s_node_size" {
  type    = string
  default = "s-2vcpu-2gb"
}

variable "k8s_node_count" {
  default = 3
}