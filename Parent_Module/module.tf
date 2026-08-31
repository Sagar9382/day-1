module "azurerm_resource_group" {
  source = "../Child_Modules/azurerm_resource_group"
  rg     = var.resource_groups
}