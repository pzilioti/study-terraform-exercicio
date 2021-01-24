resource "azurerm_virtual_network" "vnet" {
    name                = "vnet"
    address_space       = ["10.80.0.0/16"]
    location            = "eastus"
    resource_group_name = azurerm_resource_group.terraform_exercicio.name
}

resource "azurerm_subnet" "subnet" {
    name                 = "subnet"
    resource_group_name  = azurerm_resource_group.terraform_exercicio.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes       = ["10.80.4.0/24"]
}

resource "azurerm_public_ip" "publicip" {
    name                         = "publicip"
    location                     = "eastus"
    resource_group_name          = azurerm_resource_group.terraform_exercicio.name
    allocation_method            = "Dynamic"
}

resource "azurerm_network_security_group" "security_group" {
    name                = "security_group"
    location            = "eastus"
    resource_group_name = azurerm_resource_group.terraform_exercicio.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
    security_rule {
        name                       = "MySQL"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3306"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

}

resource "azurerm_network_interface" "nic" {
    name                      = "nic"
    location                  = "eastus"
    resource_group_name       = azurerm_resource_group.terraform_exercicio.name

    ip_configuration {
        name                          = "myNicConfiguration"
        subnet_id                     = azurerm_subnet.subnet.id
        private_ip_address_allocation = "Static"
        private_ip_address            = "10.80.4.11"
        public_ip_address_id          = azurerm_public_ip.publicip.id
    }
}

resource "azurerm_network_interface_security_group_association" "nicsq" {
    network_interface_id      = azurerm_network_interface.nic.id
    network_security_group_id = azurerm_network_security_group.security_group.id
}