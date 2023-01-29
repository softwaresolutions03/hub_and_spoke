output "testing_from_module" {
  value = module.kv1.key_vault_name
}

output "region-vnet-address-space" {
  value = module.region_1-vnet1.region-vnet-address-space
}

output "region-vnet-snet-range" {
  value = module.region_1-vnet1.region-vnet-snet-range
}

output "region_2-vnet-address-space" {
  value = module.region_2-vnet1.region-vnet-address-space
}

output "region_2-vnet-snet-range" {
  value = module.region_2-vnet1.region-vnet-snet-range
}

output "nsg_name" {
  value = module.region_1-nsg.nsg_name
}
output "nsg_name_2" {
  value = module.region_2-nsg.nsg_name
}

output "subnet-id" {
  value = module.region_1-vnet1.region-subnet-id
}
output "subnet-id-2" {
  value = module.region_2-vnet1.region-subnet-id
}

output "nsg-id" {
  value = module.region_1-nsg.nsg_id
}
output "nsg-id-2" {
  value = module.region_2-nsg.nsg_id
}