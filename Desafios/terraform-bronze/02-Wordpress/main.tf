terraform {
  required_version = "~>1.0"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

resource "digitalocean_droplet" "VM_aula" {
  image    = var.image_droplet
  name     = "VM"
  region   = var.region_droplet
  size     = var.size_droplet
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.id]
}

resource "digitalocean_database_firewall" "example-fw" {
  cluster_id = digitalocean_database_cluster.mysql-example.id

  rule {
    type  = "droplet"
    value = digitalocean_droplet.VM_aula.id
  }
}

resource "digitalocean_database_cluster" "mysql-example" {
  name       = "mysql-cluster"
  engine     = "mysql"
  version    = "8"
  size       = var.size_db
  region     = var.region_droplet
  node_count = 1

}

data "digitalocean_ssh_key" "ssh_key" {
  name = "crm-ssh"
}

resource "digitalocean_firewall" "Firewall" {
  name = "Firewall"

  # INBOUND
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "53"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # OUTBOUND

  outbound_rule {
    protocol              = "tcp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "443"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "80"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

}