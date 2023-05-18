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

variable "do_token" {}

resource "digitalocean_droplet" "vm-labs" {
  image  = "ubuntu-22-04-x64"
  name   = "vm-labs-${count.index}"
  region = "nyc1"
  size   = "s-1vcpu-1gb"
  count = 5

  ssh_keys = [digitalocean_ssh_key.ssh.fingerprint]
}

#CONFIGURANDO CHAVE SSH VIA SCRIPT PARA USO TEMPORÁRIO
resource "digitalocean_ssh_key" "ssh" {
  name       = "aula-terraform" #NOME QUE SERÁ APRESENTADO DO PAINEL DIGITAL OCEAN
  public_key = file("~/.ssh/aula-terraform.pub") #LOCAL EM QUE JÁ EXISTE UMA CHAVE SSH CRIADA
}