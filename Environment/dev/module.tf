module "azurerm_resource_group" {
  source = "../../Child_Modules/resource_group"
  rg     = var.resource_groups
}
