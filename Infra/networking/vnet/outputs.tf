output "vnet_id" {
  description = "Resource ID of the Virtual Network."
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "Name of the Virtual Network."
  value       = azurerm_virtual_network.this.name
}

output "subnet_ids" {
  description = "Map of subnet names to subnet resource IDs."
  value = {
    for name, subnet in azurerm_subnet.this :
    name => subnet.id
  }
}

output "subnet_names" {
  description = "Map of subnet names."
  value = {
    for name, subnet in azurerm_subnet.this :
    name => subnet.name
  }
}

output "nsg_ids" {
  description = "Map of subnet names to dedicated NSG resource IDs."
  value = {
    for name, nsg in azurerm_network_security_group.this :
    name => nsg.id
  }
}

output "nsg_names" {
  description = "Map of subnet names to dedicated NSG names."
  value = {
    for name, nsg in azurerm_network_security_group.this :
    name => nsg.name
  }
}