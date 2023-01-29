variable "rg-name" {
  description = "The default resource group to use."
  default     = "sameed-playground"
}

variable "region" {
  type        = string
  description = "location 1 for the lab"
  default     = "westeurope"
}

variable "environment" {
  type        = string
  description = "Environment tag value"
  default     = "Sameed-vWAN-Lab"
}

variable "region-vnet-address-space" {
  type        = string
  description = "VNET address space for region"
  default     = "10.10.8.0/21"
}
variable "region-vnet-snet-range" {
  type        = string
  description = "Subnet address space for region"
  default     = "10.10.11.0/24"
}

variable "region_uk" {
  type        = string
  description = "location 1 for the lab"
  default     = "eastus"
}

variable "region-vnet-address-space_uk" {
  type        = string
  description = "VNET address space for region"
  default     = "10.20.8.0/21"
}
variable "region-vnet-snet-range_uk" {
  type        = string
  description = "Subnet address space for region"
  default     = "10.20.11.0/24"
}
variable "subnet_id" {
  default = ""
}

variable "lab-name" {
  default = "vWAN-Lab"
}

variable "vwan-region-hub_1-prefix_1" {
  default = ""
}

variable "vwan-region_2-hub_1-prefix_1" {
  default = ""
}