terraform{
    required_providers{
        azurerm={
            source = "hashicorp/azurerm"
            version = "4.81.0"
        }
    }


    backend "azurerm"{
        resource_group_name = "fruit"
        storage_account_name = "fruitstorage1"
        container_name = "fruitcontainer"
        key = "dev.terraform.tfstate"
    }
}



provider "azurerm"{
    features{}

}