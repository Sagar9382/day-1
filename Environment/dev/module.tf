module "azurerm_resource_group" {
  source = "../../Child_Modules/resource_group"
  rg     = var.resource_groups
}

module "azurerm_virtual_network" {
  depends_on = [module.azurerm_resource_group]
  source     = "../../Child_Modules/vnet"
  vnets      = var.vnets
}

module "azurerm_subnet" {
  depends_on = [module.azurerm_virtual_network]
  source     = "../../Child_Modules/subnet"
  subnets    = var.subnets
}

module "azurerm_public_ip" {
  depends_on = [module.azurerm_resource_group]
  source     = "../../Child_Modules/public_ip"
  public_ips = var.public_ips
}

module "azurerm_network_security_group" {
  depends_on = [module.azurerm_resource_group]
  source     = "../../Child_Modules/network_security_group"
  nsgs       = var.nsgs
}

module "azurerm_network_interface" {
  depends_on = [module.azurerm_subnet, module.azurerm_public_ip, module.azurerm_network_security_group]
  source     = "../../Child_Modules/network_interface"
  nics       = var.nics
  subnets    = module.azurerm_subnet.subnet_output
  public_ips = module.azurerm_public_ip.public_ip_output
  nsgs       = module.azurerm_network_security_group.nsg_output
}

module "azurerm_virtual_machine" {
  depends_on = [module.azurerm_network_interface]
  source     = "../../Child_Modules/virtual_machine"
  vms        = var.vms
  nics       = module.azurerm_network_interface.nic_output
}
