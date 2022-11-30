resource "azurerm_resource_group" "azure_wth_resource_group" {
  name     = "wth-resources"
  location = "eastus"
}

resource "azurerm_network_security_group" "wth_security_group" {
  name                = "wth-security-group"
  location            = azurerm_resource_group.azure_wth_resource_group.location
  resource_group_name = azurerm_resource_group.azure_wth_resource_group.name

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
}

resource "azurerm_virtual_network" "wth_vnet" {
  name                = "wth-network"
  location            = azurerm_resource_group.azure_wth_resource_group.location
  resource_group_name = azurerm_resource_group.azure_wth_resource_group.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
}

