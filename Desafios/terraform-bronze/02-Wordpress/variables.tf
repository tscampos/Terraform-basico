variable "do_token" {
}

variable "image_droplet" {
  default = "ubuntu-22-04-x64"
}

variable "size_droplet" {
  default = "s-1vcpu-2gb"
}

variable "size_db" {
  default = "db-s-1vcpu-1gb"
}

variable "region_droplet" {
  default = "nyc1"
}

variable "ssh_key_name" {
  default = "twitter-ssh"
}