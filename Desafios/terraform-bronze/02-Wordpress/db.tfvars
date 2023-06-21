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