variable "aws_reg" {
  description = "This is aws region"
  default     = "us-east-1"
  type        = string
}

variable "username" {
  description = "DB username"
  default     = "admin"
}

variable "password" {
  default     = "admin"
  description = "DB password"
}

variable "dbname" {
  default     = "mydb"
  description = "db name"
}

variable "ssh_key" {
  default     = "~/.ssh/id_rsa.pub"
  description = "Default pub key"
}

variable "ssh_priv_key" {
  default     = "~/.ssh/id_rsa"
  description = "Default private key"
}
