# Variables
variable "lab-name" {
  type        = string
  description = "Name to be used for resources in this lab"
}

variable "rg-name" {
  description = "The default resource group to use."
  default     = "sameed-playground"
}

variable "environment" {
  type        = string
  description = "Environment tag value"
}
variable "region" {
  type        = string
  description = "location 1 for the lab"
}

variable "region_uk" {
  type        = string
  description = "location 1 for the lab"
}

variable "vwan-region-hub_1-prefix_1" {
  type        = string
  description = "Address space for vWAN Location 1 Hub 1"
}
variable "vwan-region_2-hub_1-prefix_1" {
  type        = string
  description = "Address space for vWAN Location 2 Hub 1"
}




# variable "region_1-vnet1-address-space" {
#   type        = string
#   description = "VNET address space for region 1 vnet"
# }
# variable "region_1-vnet1-snet1-range" {
#   type        = string
#   description = "Subnet address space for region 1 subnet"
# }
# variable "region_2-vnet1-address-space" {
#   type        = string
#   description = "VNET address space for region 2 vnet"
# }
# variable "region_2-vnet1-snet1-range" {
#   type        = string
#   description = "Subnet address space for region 2 subnet"
# }
# variable "vmsize" {
#   type        = string
#   description = "vm size"
# }
# variable "adminusername" {
#   type        = string
#   description = "admin username"
# }