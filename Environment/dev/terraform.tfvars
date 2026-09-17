resource_groups = {
  "rg-landingzone-eastus" = {
    name     = "rg-landingzone-eastus"
    location = "eastus"
  }
}

vnets = {
  "vnet-landingzone-dev" = {
    name                = "vnet-landingzone-dev"
    location            = "eastus"
    resource_group_name = "rg-landingzone-eastus"
    address_space       = ["10.0.0.0/16"]
  }
}

subnets = {
  "frontend-subnet" = {
    name                 = "frontend-subnet"
    resource_group_name  = "rg-landingzone-eastus"
    virtual_network_name = "vnet-landingzone-dev"
    address_prefixes     = ["10.0.1.0/24"]
  }
  "backend-subnet" = {
    name                 = "backend-subnet"
    resource_group_name  = "rg-landingzone-eastus"
    virtual_network_name = "vnet-landingzone-dev"
    address_prefixes     = ["10.0.2.0/24"]
  }
  "database-subnet" = {
    name                 = "database-subnet"
    resource_group_name  = "rg-landingzone-eastus"
    virtual_network_name = "vnet-landingzone-dev"
    address_prefixes     = ["10.0.3.0/24"]
  }
}

public_ips = {
  "pip-frontend" = {
    name                = "pip-frontend"
    location            = "eastus"
    resource_group_name = "rg-landingzone-eastus"
    allocation_method   = "Static"
    sku                 = "Standard"
  }
  "pip-backend" = {
    name                = "pip-backend"
    location            = "eastus"
    resource_group_name = "rg-landingzone-eastus"
    allocation_method   = "Static"
    sku                 = "Standard"
  }
  "pip-database" = {
    name                = "pip-database"
    location            = "eastus"
    resource_group_name = "rg-landingzone-eastus"
    allocation_method   = "Static"
    sku                 = "Standard"
  }
}

nsgs = {
  "nsg-ssh" = {
    name                = "nsg-ssh"
    location            = "eastus"
    resource_group_name = "rg-landingzone-eastus"
    security_rules = [
      {
        name                       = "AllowSSH"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
}

nics = {
  "nic-frontend" = {
    name                = "nic-frontend"
    location            = "eastus"
    resource_group_name = "rg-landingzone-eastus"
    subnet_key          = "frontend-subnet"
    public_ip_key       = "pip-frontend"
    nsg_key             = "nsg-ssh"
  }
  "nic-backend" = {
    name                = "nic-backend"
    location            = "eastus"
    resource_group_name = "rg-landingzone-eastus"
    subnet_key          = "backend-subnet"
    public_ip_key       = "pip-backend"
    nsg_key             = "nsg-ssh"
  }
  "nic-database" = {
    name                = "nic-database"
    location            = "eastus"
    resource_group_name = "rg-landingzone-eastus"
    subnet_key          = "database-subnet"
    public_ip_key       = "pip-database"
    nsg_key             = "nsg-ssh"
  }
}

vms = {
  "vm-frontend" = {
    name                            = "vm-frontend"
    location                        = "eastus"
    resource_group_name             = "rg-landingzone-eastus"
    nic_key                         = "nic-frontend"
    size                            = "Standard_F1as_v7"
    admin_username                  = "azureuser"
    admin_password                  = "Password1234!"
    disable_password_authentication = false
    os_disk_caching                 = "ReadWrite"
    os_disk_storage_account_type    = "Standard_LRS"
    image_publisher                 = "Canonical"
    image_offer                     = "0001-com-ubuntu-server-jammy"
    image_sku                       = "22_04-lts-gen2"
    image_version                   = "latest"
  }
  "vm-backend" = {
    name                            = "vm-backend"
    location                        = "eastus"
    resource_group_name             = "rg-landingzone-eastus"
    nic_key                         = "nic-backend"
    size                            = "Standard_F1as_v7"
    admin_username                  = "azureuser"
    admin_password                  = "Password1234!"
    disable_password_authentication = false
    os_disk_caching                 = "ReadWrite"
    os_disk_storage_account_type    = "Standard_LRS"
    image_publisher                 = "Canonical"
    image_offer                     = "0001-com-ubuntu-server-jammy"
    image_sku                       = "22_04-lts-gen2"
    image_version                   = "latest"
  }
  "vm-database" = {
    name                            = "vm-database"
    location                        = "eastus"
    resource_group_name             = "rg-landingzone-eastus"
    nic_key                         = "nic-database"
    size                            = "Standard_F1as_v7"
    admin_username                  = "azureuser"
    admin_password                  = "Password1234!"
    disable_password_authentication = false
    os_disk_caching                 = "ReadWrite"
    os_disk_storage_account_type    = "Standard_LRS"
    image_publisher                 = "Canonical"
    image_offer                     = "0001-com-ubuntu-server-jammy"
    image_sku                       = "22_04-lts-gen2"
    image_version                   = "latest"
  }
}
