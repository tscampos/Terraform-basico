output "meu-output_IP" {
  value = digitalocean_droplet.VM_aula[*].ipv4_address
}