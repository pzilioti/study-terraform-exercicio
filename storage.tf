resource "azurerm_storage_account" "storage_db" {
    name                        = "pziliotistdb"
    resource_group_name         = azurerm_resource_group.terraform_exercicio.name
    location                    = "eastus"
    account_tier                = "Standard"
    account_replication_type    = "LRS"
}