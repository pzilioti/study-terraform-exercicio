resource "azurerm_linux_virtual_machine" "vm_db_mysql" {
    name                  = "vm_db_mysql"
    location              = "eastus"
    resource_group_name   = azurerm_resource_group.terraform_exercicio.name
    network_interface_ids = [azurerm_network_interface.nic.id]
    size                  = "Standard_DS1_v2"

    os_disk {
        name              = "myOsDBDisk"
        caching           = "ReadWrite"
        storage_account_type = "Premium_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    computer_name  = "myvmdb"
    admin_username = "mysqluser"
    admin_password = "imp@cta2021"
    disable_password_authentication = false

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.storage_db.primary_blob_endpoint
    }
}