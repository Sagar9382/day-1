resource "azurerm_network_interface" "nic" {
  for_each            = var.nics
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnets[each.value.subnet_key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = lookup(each.value, "public_ip_key", null) != null ? var.public_ips[each.value.public_ip_key].id : null
  }
}

resource "azurerm_network_interface_security_group_association" "nic_nsg_assoc" {
  for_each                  = { for k, v in var.nics : k => v if lookup(v, "nsg_key", null) != null }
  network_interface_id      = azurerm_network_interface.nic[each.key].id
  network_security_group_id = var.nsgs[each.value.nsg_key].id
}
