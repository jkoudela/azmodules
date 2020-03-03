
# Create network interface
resource "azurerm_network_interface" "nic" {
  name                      = "${var.servername}-nic"
  location                  = var.location
  resource_group_name       = var.rgname

  ip_configuration {
    name                          = "${var.servername}-niccofg"
    subnet_id                     = var.subnetid
    private_ip_address_allocation = "dynamic"
    # public_ip_address_id          = azurerm_public_ip.dc01pubip.id
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg" {
  subnet_id                 = var.subnetid
  network_security_group_id = var.nsgid
}

# Create servers
resource "azurerm_windows_virtual_machine" "vm" {
  name                            = "${var.servername}-vm"
  resource_group_name             = var.rgname
  location                        = var.location
  size                            = "Standard_DS1_v2"
  admin_username                  = "vmadmin"
  admin_password                  = "Password12345+"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
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