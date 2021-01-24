resource "azurerm_network_interface" "nic_aula_ansible" {
    name                      = "myNICAnsible"
    location                  = "eastus"
    resource_group_name       = azurerm_resource_group.terraform_exercicio.name

    ip_configuration {
        name                          = "myNicConfigurationAnsible"
        subnet_id                     = azurerm_subnet.subnet.id
        private_ip_address_allocation = "Static"
        private_ip_address            = "10.80.4.14"
        public_ip_address_id          = azurerm_public_ip.publicip_aula_ansible.id
    }
}

resource "azurerm_public_ip" "publicip_aula_ansible" {
    name                         = "myPublicIPAnsible"
    location                     = "eastus"
    resource_group_name          = azurerm_resource_group.terraform_exercicio.name
    allocation_method            = "Static"
    idle_timeout_in_minutes = 30
}

resource "azurerm_network_interface_security_group_association" "nicsq_aula_ansible" {
    network_interface_id      = azurerm_network_interface.nic_aula_ansible.id
    network_security_group_id = azurerm_network_security_group.security_group.id
}

data "azurerm_public_ip" "ip_aula_ansible_data" {
  name                = azurerm_public_ip.publicip_aula_ansible.name
  resource_group_name = azurerm_resource_group.terraform_exercicio.name
}