terraform {
  required_version = "~>1.0"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
}

resource "digitalocean_droplet" "VM_aula" {
  image    = var.image_droplet
  name     = "VM"
  region   = var.region_droplet
  size     = var.size_droplet
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.id]

  connection {
    host = "VM"
    type = "ssh"
    user = "root"
    private_key = file("~/.ssh/ansible")
    timeout = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "apt-get update",
      "apt-get install -y mysql-server",
      "mysql_secure_installation",
    ]
  }

}

data "digitalocean_ssh_key" "ssh_key" {
  name = "twitter-ssh"
}  

resource "digitalocean_firewall" "Firewall" {
  name = "Firewall"

  droplet_ids = digitalocean_droplet.VM_aula[*].id

                                                # INBOUND
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["239.13.117.114", "::/0"]
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

  inbound_rule {
    protocol         = "tcp"
    port_range       = "3306"
    source_addresses = ["239.13.117.114"]
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

# variable "do_token" {
#   value = "dop_v1_09cecbc1bfc1cd1a42421fcfe9b62aaa93098a381bf938136ebf88aaa1c4d361"
# }

variable "image_droplet" {
  default = "ubuntu-22-04-x64"
}

variable "size_droplet" {
  default = "s-1vcpu-2gb"
}

variable "region_droplet" {
  default = "nyc1"
}

variable "ssh_key_name" {
  default = "twitter-ssh"
}

# Variáveis de ambiente do DB MySQL
variable "mysql_user" {
  description = "Username for MySQL"
  type        = string
  default     = "myuser"
}

variable "mysql_password" {
  description = "Password for MySQL"
  type        = string
  default     = "mypassword"
}

variable "mysql_database" {
  description = "MySQL Database Name"
  type        = string
  default     = "mydatabase"
}

output "mysql_connection_string" {
  value = "mysql://${var.mysql_user}:${var.mysql_password}@${digitalocean_droplet.VM_aula.ipv4_address}/${var.mysql_database}"
}