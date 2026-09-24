terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "sumerlabsterraformstate"
    container_name       = "{{STATE_CONTAINER}}"
    key                  = "{{STATE_KEY}}"

    use_azuread_auth = true
  }
}
