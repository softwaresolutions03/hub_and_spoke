# Virtual Machines
#Public IPs
resource "azurerm_public_ip" "region_1-vm01-pip" {
  name                = "${var.region_1}-vm01-pip"
  resource_group_name = var.rg-name
  location            = var.region_1
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    Environment = var.environment_tag
  }
}
resource "azurerm_public_ip" "region_2-vm01-pip" {
  name                = "${var.region_2}-vm01-pip"
  resource_group_name = var.rg-name
  location            = var.region_2
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    Environment = var.environment_tag
  }
}
#Create NICs and associate the Public IPs
resource "azurerm_network_interface" "region_1-vm01-nic" {
  name                = "${var.region_1}-vm01-nic"
  location            = var.region_1
  resource_group_name = var.rg-name


  ip_configuration {
    name                          = "${var.region_1}-vm01-ipconfig"
    subnet_id                     = azurerm_subnet.region_1-vnet1-snet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.region_1-vm01-pip.id
  }

  tags = {
    Environment = var.environment_tag
  }
}
resource "azurerm_network_interface" "region_2-vm01-nic" {
  name                = "${var.region_2}-vm01-nic"
  location            = var.region_2
  resource_group_name = var.rg-name


  ip_configuration {
    name                          = "${var.region_2}-vm01-ipconfig"
    subnet_id                     = azurerm_subnet.region_2-vnet1-snet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.region_2-vm01-pip.id
  }

  tags = {
    Environment = var.environment_tag
  }
}
#Create VMs
resource "azurerm_windows_virtual_machine" "region_1-vm01" {
  name                = "${var.region_1}-vm01"
  depends_on          = [azurerm_key_vault.kv1]
  resource_group_name = var.rg-name
  location            = var.region_1
  size                = var.vmsize
  admin_username      = var.adminusername
  admin_password      = azurerm_key_vault_secret.vmpassword.value
  network_interface_ids = [
    azurerm_network_interface.region_1-vm01-nic.id,
  ]

  tags = {
    Environment = var.environment_tag
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}
resource "azurerm_windows_virtual_machine" "region_2-vm01" {
  name                = "${var.region_2}-vm01"
  depends_on          = [azurerm_key_vault.kv1]
  resource_group_name = var.rg-name
  location            = var.region_2
  size                = var.vmsize
  admin_username      = var.adminusername
  admin_password      = azurerm_key_vault_secret.vmpassword.value
  network_interface_ids = [
    azurerm_network_interface.region_2-vm01-nic.id,
  ]

  tags = {
    Environment = var.environment_tag
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}
# Setup Scripts for Apps and Windows Firewall
resource "azurerm_virtual_machine_extension" "region_1-vm01-vmsetup" {
  name                 = "${var.region_1}-vm01-vmsetup"
  virtual_machine_id   = azurerm_windows_virtual_machine.region_1-vm01.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  protected_settings = <<PROTECTED_SETTINGS
    {
      "commandToExecute": "powershell.exe -Command \"vm/./initialize_vm.ps1; exit 0;\""
    }
  PROTECTED_SETTINGS

  settings = <<SETTINGS
    {
        "fileUris": [
          "https://raw.githubusercontent.com/sameed03/Powershell/main/vm/initialize_vm.ps1"
        ]
    }
  SETTINGS
}
resource "azurerm_virtual_machine_extension" "region_2-vm01-vmsetup" {
  name                 = "${var.region_2}-vm01-vmsetup"
  virtual_machine_id   = azurerm_windows_virtual_machine.region_2-vm01.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  protected_settings = <<PROTECTED_SETTINGS
    {
      "commandToExecute": "powershell.exe -Command \"vm/./initialize_vm.ps1; exit 0;\""
    }
  PROTECTED_SETTINGS

  settings = <<SETTINGS
    {
        "fileUris": [
          "https://raw.githubusercontent.com/sameed03/Powershell/main/vm/initialize_vm.ps1"
        ]
    }
  SETTINGS
}