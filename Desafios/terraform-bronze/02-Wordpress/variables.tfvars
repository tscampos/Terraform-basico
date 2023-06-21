variable "do_token" {
}

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