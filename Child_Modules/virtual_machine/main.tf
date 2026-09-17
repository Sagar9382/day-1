resource "azurerm_linux_virtual_machine" "vm" {
  for_each                        = var.vms
  name                            = each.value.name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = lookup(each.value, "size", "Standard_F1as_v7")
  admin_username                  = lookup(each.value, "admin_username", "azureuser")
  admin_password                  = lookup(each.value, "admin_password", "Password1234!")
  disable_password_authentication = lookup(each.value, "disable_password_authentication", false)
  network_interface_ids           = [var.nics[each.value.nic_key].id]

  os_disk {
    caching              = lookup(each.value, "os_disk_caching", "ReadWrite")
    storage_account_type = lookup(each.value, "os_disk_storage_account_type", "Standard_LRS")
  }

  source_image_reference {
    publisher = lookup(each.value, "image_publisher", "Canonical")
    offer     = lookup(each.value, "image_offer", "0001-com-ubuntu-server-jammy")
    sku       = lookup(each.value, "image_sku", "22_04-lts-gen2")
    version   = lookup(each.value, "image_version", "latest")
  }
}
