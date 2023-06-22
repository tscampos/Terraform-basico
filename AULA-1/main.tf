                                              ##### DROPLET #####

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
  image    = "ubuntu-22-04-x64"
  name     = "${var.droplet_name}-${count.index}"
  region   = var.droplet_region
  size     = var.droplet_size
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.id]
  count    = var.vms_count

                                            ##### Acessando VM para instalação remota #####
  # connection {
  #   type = "ssh"
  #   user = "root"
  #   private_key = file("~/.ssh/ansible")
  #   host = digitalocean_droplet.VM_aula.ipv4_address
  #   timeout = "2m"
  # }

  # provisioner "remote-exec" {
  #   inline = [
  #     "apt-get update",
  #     "apt-get install -y mysql-server",
  #     "mysql_secure_installation",
  #   ]
  # }
}

                                              ##### FIREWALL #####
                                              
resource "digitalocean_firewall" "Firewall" {
  name = "Firewall"

  droplet_ids = digitalocean_droplet.VM_aula[*].id

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "22"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "53"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "443"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "80"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

}
