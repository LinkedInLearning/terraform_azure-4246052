variable "vnet_name" {
    type = string
    default = "default_vnet_name"
}
variable "location" {
    type = string
    default = "West Europe"
}
variable "vnet_address_space" {
    type = string
    default = "9.0.0.0/16"
}
variable "resource_group_name" {
    type = string
    default = "default_rg"
}
variable "subnet_name" {
    type = string
    default = "default_subnet"
}
variable "subnet_address_space" {
    type = string
    default = "9.0.2.0/24"
}


