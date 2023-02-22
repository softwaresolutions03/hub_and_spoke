#Providers
terraform {
  required_providers {
    azurerm = {
      # Specify what version of the provider we are going to utilise
      source  = "hashicorp/azurerm"
      version = "= 3.37.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.4.3"
    }
  }
}
# Features
provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}


module "kv1" {
  source = "./modules/keyvault"

  region_europe = var.region
  rg-name       = var.rg-name
  environment   = var.environment


}

module "kv1" {
  source = "./modules/keyvault"

  region_europe = var.region
  rg-name       = var.rg-name
  environment   = var.environment


}
module "region_1-vnet1" {
  source = "./modules/networks"

  region                    = var.region
  rg-name                   = var.rg-name
  environment               = var.environment
  region-vnet-address-space = var.region-vnet-address-space
  region-vnet-snet-range    = var.region-vnet-snet-range

}

module "region_2-vnet1" {
  source = "./modules/networks"

  region                    = var.region_uk
  rg-name                   = var.rg-name
  environment               = var.environment
  region-vnet-address-space = var.region-vnet-address-space_uk
  region-vnet-snet-range    = var.region-vnet-snet-range_uk

}

module "region_1-nsg" {
  source      = "./modules/nsg"
  region      = var.region
  rg-name     = var.rg-name
  environment = var.environment
  subnet_id   = module.region_1-vnet1.region-subnet-id
}

module "region_2-nsg" {
  source      = "./modules/nsg"
  region      = var.region_uk
  rg-name     = var.rg-name
  environment = var.environment
  subnet_id   = module.region_2-vnet1.region-subnet-id
}

module "virtual_wan" {
  source                       = "./modules/vwan"
  lab-name                     = var.lab-name
  region                       = var.region
  region_uk                    = var.region_uk
  rg-name                      = var.rg-name
  environment                  = var.environment
  vwan-region-hub_1-prefix_1   = "10.10.0.0/21"
  vwan-region_2-hub_1-prefix_1 = "10.20.0.0/21"
}

module "virtual_hub" {
   source      = "./modules/vwan"
 lab-name = var.lab-name
   region      = var.region
   region_uk = var.region_uk
   rg-name     = var.rg-name
   environment = var.environment
   vwan-region-hub_1-prefix_1 = "10.10.0.0/21"
   vwan-region_2-hub_1-prefix_1 = "10.20.0.0/21"
 }

 module "virtual_hub_2" {
   source      = "./modules/vwan"
 lab-name = var.lab-name
   region      = var.region
   rg-name     = var.rg-name
   environment = var.environment
   vwan-region-hub_1-prefix_1 = "10.20.0.0/21"
 }
 module "region_1-vnet1-snet1" {
   source = "./modules/networks"

   region               = var.region
   rg-name                = var.rg-name
   environment       = var.environment_tag
      region-vnet-snet-range = var.region-vnet-snet-range
 }


 module "region_2-vnet1" {
   source = "./modules/networks"

   region_2                     = var.region_2
   rg-name                      = var.rg-name
   environment_tag              = var.environment_tag
   region_2-vnet1-address-space = "10.20.8.0/21"

 }

 module "region_2-vnet1-snet1" {
   source = "./modules/networks"

   region_1                   = var.region_1
   rg-name                    = var.rg-name
   environment_tag            = var.environment_tag
   region_1-vnet1-snet1-range = "10.10.11.0/24"
 }


 module "region_2-nsg" {
   source            = "./modules/nsg"
   region1_subnet_s1 = module.region_2-vnet1.id
   region1_nsg_s1    = module.region_2-vnet1.nsg_id
   region_1          = var.region_1
   rg-name           = var.rg-name
 }

