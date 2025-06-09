resource "azurerm_resource_group" "rg" {
  name     = "rg-private-dns-example"
  location = "germanywestcentral"
}

module "private_dns_zone" {
  source              = "../.."
  name                = "mydomain.com"
  resource_group_name = azurerm_resource_group.rg.name
}
