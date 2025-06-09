## 🌐 Additional Information  

For comprehensive guidance on Azure Private DNS and configuration scenarios, refer to the [Azure Private DNS documentation](https://learn.microsoft.com/en-us/azure/dns/private-dns-overview).  
This module helps you manage a Private DNS zone and dynamically link it to one or more virtual networks (via virtual network links).

## 📚 Resources  

- [Terraform AzureRM Provider – `azurerm_private_dns_zone`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone)  
- [Azure Private DNS Overview](https://learn.microsoft.com/en-us/azure/dns/private-dns-overview)

## ⚠️ Notes  

- A single Private DNS zone can be linked to multiple virtual networks, enabling cross-VNet name resolution.  
- Billing is based on the number of Private DNS zones, queries, and virtual network links.  
- Always validate and test your Terraform plans to ensure resources are provisioned and linked correctly.

## 🧾 License  

This module is released under the **MIT License**. See the [LICENSE](./LICENSE) file for full details.
