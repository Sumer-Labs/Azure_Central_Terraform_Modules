provider "azurerm" {
  features {}
}

run "vnet_creates_expected_structure" {
  command = plan

  variables {
    name                = "test-vnet"
    location            = "Central India"
    resource_group_name = "test-rg"

    address_space = [
      "10.50.0.0/16"
    ]

    subnets = {
      aks = {
        address_prefixes = ["10.50.0.0/22"]
      }

      app-gateway = {
        address_prefixes = ["10.50.10.0/24"]
      }

      private-endpoint = {
        address_prefixes = ["10.50.20.0/24"]
      }
    }

    tags = {
      environment = "test"
      managed_by  = "terraform"
    }
  }

  assert {
    condition     = azurerm_virtual_network.this.name == var.name
    error_message = "VNet name does not match the requested name."
  }

  assert {
    condition = (
    toset(azurerm_virtual_network.this.address_space)
     == toset(var.address_space)
   )

     error_message = "VNet address space does not match the requested address space."
  }

  assert {
    condition = (
      length(azurerm_subnet.this) == length(var.subnets)
    )

    error_message = "The number of created subnets does not match the requested subnets."
  }

  assert {
    condition = (
      length(azurerm_network_security_group.this) == length(var.subnets)
    )

    error_message = "Every subnet must have a dedicated NSG."
  }

  assert {
    condition = (
      length(azurerm_subnet_network_security_group_association.this)
      == length(var.subnets)
    )

    error_message = "Every subnet must have an NSG association."
  }

  assert {
    condition = alltrue([
      for subnet_name, nsg in azurerm_network_security_group.this :
      nsg.name == "${subnet_name}-nsg"
    ])

    error_message = "NSG name must follow the <subnet-name>-nsg convention."
  }
}