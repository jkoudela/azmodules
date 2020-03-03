

# Create network interface
resource "azurerm_network_interface" "dc01nic" {
  name                      = "dc01nic"
  location                  = azurerm_resource_group.rg.location
  resource_group_name       = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "dc01NICConfg"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = azurerm_public_ip.dc01pubip.id
  }
}

resource "azurerm_subnet_network_security_group_association" "aadcas" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.aadcnsg.id
}

# Create servers
resource "azurerm_windows_virtual_machine" "dc01" {
  name                            = "dc01-vm"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = "Standard_DS1_v2"
  admin_username                  = "vmadmin"
  admin_password                  = "Password12345+"
  network_interface_ids = [
    azurerm_network_interface.dc01nic.id,
  ]

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}