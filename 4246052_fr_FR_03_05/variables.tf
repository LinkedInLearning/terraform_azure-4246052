variable "public_key_file" {
    type = string
    sensitive = true
}

variable "username" {
    type = string
    sensitive = true
}

variable "rg" {
  type = string
  description  = "Resource group name"
}

variable "region" {
  type = string
  description  = "Location"
  default = "West Europe"
}

variable "environment" {
  type = string
  description  = "Environnement"
  default = "dev"
}
