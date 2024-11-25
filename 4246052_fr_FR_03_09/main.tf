variable "security_rules" {
  description = "A list of security rules"
  type = list(object({
    name                     = string
    priority                 = number
    direction                = string
    access                   = string
    protocol                 = string
    source_port_range        = string
    destination_port_range   = string
    source_address_prefix    = string
    destination_address_prefix = string
  }))
  default = [
    {
      name                     = "allow-ssh"
      priority                 = 100
      direction                = "Inbound"
      access                   = "Allow"
      protocol                 = "Tcp"
      source_port_range        = "*"
      destination_port_range   = "22"
      source_address_prefix    = "*"
      destination_address_prefix = "VirtualNetwork"
    },
    {
      name                     = "allow-ssh"
      priority                 = 100
      direction                = "Inbound"
      access                   = "Allow"
      protocol                 = "Tcp"
      source_port_range        = "*"
      destination_port_range   = "80"
      source_address_prefix    = "*"
      destination_address_prefix = "VirtualNetwork"
    },
    {
      name                     = "allow-ssh"
      priority                 = 100
      direction                = "Inbound"
      access                   = "Allow"
      protocol                 = "Tcp"
      source_port_range        = "*"
      destination_port_range   = "443"
      source_address_prefix    = "*"
      destination_address_prefix = "VirtualNetwork"
    },

  ]
}

resource "azurerm_resource_group" "web" {
  name     = "web_rg"
  location = "West Europe"
}

resource "azurerm_network_security_group" "web_sg" {
  name                = "example-nsg"
  location            = azurerm_resource_group.web.location
  resource_group_name = azurerm_resource_group.web.name

  dynamic "security_rule" {
    for_each = var.security_rules

    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}


