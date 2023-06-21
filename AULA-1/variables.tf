variable "do_token" {
  type = string
  description = "Token da API da Digital Ocean"
}

variable "droplet_name" {
  default = "vm-aula"
  type = string
  description = "Nome inicial do droplet"
}

variable "droplet_region" {
  default = "nyc1"
    type = string
  description = "Região que vai ser criada a infra"
}

variable "droplet_size" {
  default = "s-1vcpu-2gb"
  type = string
  description = "Perfil de máquina do droplets"
}

variable "ssh_key_name" {
  default = "ssh-terraform"
  type = string
  description = "Chave SSH que será utilizada"
}

variable "vms_count" {
  default     = 1
  type        = number
  description = "Quantidade de máquinas"
}
