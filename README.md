<!-- BEGINNING OF PRE-COMMIT-OPENTOFU DOCS HOOK -->
# tf-azurerm-private-dns Module

[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-blue.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![OpenTofu Registry](https://img.shields.io/badge/opentofu-registry-yellow.svg)](https://search.opentofu.org/module/cloudastro/private-dns/azurerm/)

This module is designed to manage an Azure Private DNS zone, including its creation, linking it to one or more virtual networks, and managing various types of DNS records.

## Features

- **Private DNS Zone**: Creates a private DNS zone within the specified resource group.
- **Virtual Network Links**: Dynamically links the DNS zone to one or more virtual networks, with optional auto-registration of DNS records.
- **DNS Records**: Supports the creation of:
  - **A records** (IPv4 addresses)
  - **AAAA records** (IPv6 addresses)
  - **CNAME records** (canonical names)
  - **MX records** (mail exchange)
  - **PTR records** (reverse DNS)
  - **SRV records** (service location)
  - **TXT records** (text data)
  - **SOA records** (start of authority — configurable contact, TTLs, and retry/refresh policies)

## Example Usage

This example demonstrates how to use the `tf-azurerm-private-dns` module to create a private DNS zone and configure supported records.

```hcl
resource "azurerm_resource_group" "rg" {
  name     = "rg-private-dns-example"
  location = "germanywestcentral"
}

module "vnet" {
  source              = "CloudAstro/virtual-network/azurerm"
  name                = "vnet-example"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

module "private_dns_zone" {
  source              = "../.."
  name                = "mydomain.com"
  resource_group_name = azurerm_resource_group.rg.name

  soa_record = {
    email        = "admin.contoso.com"
    expire_time  = 604800
    minimum_ttl  = 300
    refresh_time = 3600
    retry_time   = 600
    ttl          = 3600
    tags         = { "environment" = "dev", "project" = "example" }
  }

  a_records = {
    "my-a-record-1" = {
      name    = "record1"
      ttl     = 3600
      records = ["10.0.0.4", "10.0.0.5"]
      tags    = { "environment" = "dev", "project" = "example" }
    },
    "my-a-record-2" = {
      name    = "record2"
      ttl     = 7200
      records = ["10.0.1.4"]
      tags    = { "environment" = "dev", "project" = "example" }
    }
  }

  aaaa_records = {
    "my-aaaa-record-1" = {
      name    = "record1"
      records = ["2001:0db8:85a3:0000:0000:8a2e:0370:7334"]
      ttl     = 3600
      tags    = { "environment" = "dev", "project" = "example" }
    }
  }

  cname_records = {
    "my-cname-record-1" = {
      name   = "record1"
      ttl    = 3600
      record = "example.com"
      tags   = { "environment" = "dev", "project" = "example" }
    }
  }

  mx_records = {
    "my-mx-record-1" = {
      name = "record1"
      record = {
        "mx1" = {
          preference = 10
          exchange   = "mail1.example.com"
        },
        "mx2" = {
          preference = 20
          exchange   = "mail2.example.com"
        }
      }
      ttl  = 3600
      tags = { "environment" = "dev", "project" = "example" }
    }
  }

  ptr_records = {
    "my-ptr-record-1" = {
      name    = "record1"
      ttl     = 3600
      records = ["ptr.example.com"]
      tags    = { "environment" = "dev", "project" = "example" }
    }
  }

  srv_records = {
    "my-srv-record-1" = {
      name = "_sip._tcp.example.com"
      ttl  = 3600
      record = {
        "srv1" = {
          priority = 10
          weight   = 5
          port     = 5060
          target   = "sipserver.example.com"
        },
        "srv2" = {
          priority = 20
          weight   = 10
          port     = 5060
          target   = "sipbackup.example.com"
        }
      }
      tags = { "environment" = "dev", "project" = "example" }
    }
  }

  txt_records = {
    "example-txt" = {
      name = "example"
      ttl  = 3600
      record = {
        "entry1" = {
          value = "v=spf1 include:example.com ~all"
        },
        "entry2" = {
          value = "some-other-verification=12345"
        }
      }
      tags = { "environment" = "dev", "project" = "example" }
    }
  }

  vnet_links = {
    "vnet-link-1" = {
      name                 = "con-example-vnet"
      virtual_network_id   = module.vnet.virtual_network.id
      registration_enabled = true
    }
  }

  tags = {
    env    = "dev"
    region = "gwc"
  }
}
```
<!-- markdownlint-disable MD033 -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 4.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_private_dns_a_record.a_records](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_aaaa_record.aaaa_records](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_aaaa_record) | resource |
| [azurerm_private_dns_cname_record.cname_records](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_cname_record) | resource |
| [azurerm_private_dns_mx_record.mx_records](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_mx_record) | resource |
| [azurerm_private_dns_ptr_record.ptr_records](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_ptr_record) | resource |
| [azurerm_private_dns_srv_record.srv_records](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_srv_record) | resource |
| [azurerm_private_dns_txt_record.txt_records](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_txt_record) | resource |
| [azurerm_private_dns_zone.private_dns](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.vnet_links](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |

<!-- markdownlint-disable MD013 -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | * `name` -  (Required) The name of the Private DNS Zone. Must be a valid domain name. Changing this forces a new resource to be created.<br/>  * -> **NOTE:** If you are going to be using the Private DNS Zone with a Private Endpoint the name of the Private DNS Zone must follow the Private DNS Zone name schema in the product documentation in order for the two resources to be connected successfully.<br/><br/>  Example Input:<pre>name = "privatelink.blob.core.windows.net"</pre> | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | * `resource_group_name` - (Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created.<br/><br/>  Example Input:<pre>resource_group_name = "rg-private-dns-dev"</pre> | `string` | n/a | yes |
| <a name="input_a_records"></a> [a\_records](#input\_a\_records) | * `name` - (Required) The name of the DNS A Record. Changing this forces a new resource to be created.<br/>  * `ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds.<br/>  * `records` - (Required) List of IPv4 Addresses.<br/>  * `tags` - (Optional) A mapping of tags to assign to the resource.<br/><br/>  Example Input:<pre>a_records = {<br/>    "my-a-record-1" = {<br/>      name    = "record1"<br/>      ttl     = 3600<br/>      records = ["10.0.0.4", "10.0.0.5"]<br/>      tags    = { "environment" = "dev", "project" = "example" }<br/>    },<br/>    "my-a-record-2" = {<br/>      name    = "record2"<br/>      ttl     = 7200<br/>      records = ["10.0.1.4"]<br/>      tags    = {}<br/>    }<br/>  }</pre> | <pre>map(object({<br/>    name    = string<br/>    ttl     = number<br/>    records = list(string)<br/>    tags    = optional(map(string))<br/>  }))</pre> | `null` | no |
| <a name="input_aaaa_records"></a> [aaaa\_records](#input\_aaaa\_records) | A map of objects where each object contains information to create a AAAA record.<br/>  The following arguments are supported:<br/>  * `name` - (Required) The name of the DNS A Record. Changing this forces a new resource to be created.<br/>  * `zone_name` - (Required) Specifies the Private DNS Zone where the resource exists. Changing this forces a new resource to be created.<br/>  * `ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds.<br/>  * `records` - (Required) A list of IPv6 Addresses.<br/>  * `tags` - (Optional) A mapping of tags to assign to the resource.<br/><br/>  Example Input:<pre>aaaa_records = {<br/>    "my-aaaa-record-1" = {<br/>      name      = "record1"<br/>      zone_name = "privatelink.blob.core.windows.net"<br/>      records   = ["2001:0db8:85a3:0000:0000:8a2e:0370:7334"]<br/>      ttl       = 3600<br/>      tags      = { "environment" = "dev", "project" = "example" }<br/>    }<br/>  }</pre> | <pre>map(object({<br/>    name      = string<br/>    zone_name = optional(string)<br/>    ttl       = number<br/>    records   = list(string)<br/>    tags      = optional(map(string))<br/>  }))</pre> | `null` | no |
| <a name="input_cname_records"></a> [cname\_records](#input\_cname\_records) | A map of objects where each object contains information to create a CNAME record.<br/>  The following arguments are supported:<br/>  * `name` - (Required) The name of the DNS CNAME Record. Changing this forces a new resource to be created.<br/>  * `zone_name` - (Required) Specifies the Private DNS Zone where the resource exists. Changing this forces a new resource to be created.<br/>  * `ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds. Possible values are between 0 and 2147483647.<br/>  * `record` - (Required) The target of the CNAME.<br/>  * `tags` - (Optional) A mapping of tags to assign to the resource.<br/><br/>  Example Input:<pre>cname_records = {<br/>    "my-cname-record-1" = {<br/>      name                = "record1"<br/>      zone_name           = "privatelink.blob.core.windows.net"<br/>      ttl                 = 3600<br/>      record              = "example.com"<br/>      tags                = { "environment" = "dev", "project" = "example" }<br/>    }<br/>  }</pre> | <pre>map(object({<br/>    name      = string<br/>    zone_name = optional(string)<br/>    ttl       = number<br/>    record    = string<br/>    tags      = optional(map(string))<br/>  }))</pre> | `null` | no |
| <a name="input_mx_records"></a> [mx\_records](#input\_mx\_records) | A map of objects where each object contains information to create a MX record.<br/>  The following arguments are supported:<br/>  * `name` - (Optional) The name of the DNS MX Record. Changing this forces a new resource to be created. Default to '@' for root zone entry.<br/>  * `resource_group_name` - (Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created.<br/>  * `zone_name` - (Required) Specifies the Private DNS Zone where the resource exists. Changing this forces a new resource to be created.<br/>  * `record` - (Required) One or more record blocks as defined below.<br/>  * `ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds.<br/>  * `tags` - (Optional) A mapping of tags to assign to the resource.<br/>  A record block supports the following:<br/>  * `preference` - (Required) The preference of the MX record.<br/>  * `exchange` - (Required) The FQDN of the exchange to MX record points to.<br/><br/>  Example Input:<pre>mx_records = {<br/>    "my-mx-record-1" = {<br/>      name      = "record1"<br/>      zone_name = "privatelink.blob.core.windows.net"<br/>      record = {<br/>        "mx1" = {<br/>          preference = 10<br/>          exchange   = "mail1.example.com"<br/>        },<br/>        "mx2" = {<br/>          preference = 20<br/>          exchange   = "mail2.example.com"<br/>        }<br/>      }<br/>      ttl  = 3600<br/>      tags = { "environment" = "dev", "project" = "example" }<br/>    }<br/>  }</pre> | <pre>map(object({<br/>    name      = optional(string, "@")<br/>    zone_name = optional(string)<br/>    record = map(object({<br/>      preference = number<br/>      exchange   = string<br/>    }))<br/>    ttl  = number<br/>    tags = optional(map(string))<br/>  }))</pre> | `null` | no |
| <a name="input_ptr_records"></a> [ptr\_records](#input\_ptr\_records) | A map of objects where each object contains information to create a PTR record.<br/>  The following arguments are supported:<br/>  * `name` - (Required) The name of the DNS PTR Record. Changing this forces a new resource to be created.<br/>  * `resource_group_name` - (Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created.<br/>  * `zone_name` - (Required) Specifies the Private DNS Zone where the resource exists. Changing this forces a new resource to be created.<br/>  * `ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds.<br/>  * `records` - (Required) List of Fully Qualified Domain Names.<br/>  * `tags` - (Optional) A mapping of tags to assign to the resource.<br/><br/>  Example Input:<pre>ptr_records = {<br/>    "my-ptr-record-1" = {<br/>      name      = "record1"<br/>      zone_name = "privatelink.blob.core.windows.net"<br/>      ttl       = 3600<br/>      records   = ["ptr.example.com"]<br/>      tags      = { "environment" = "dev", "project" = "example" }<br/>    }<br/>  }</pre> | <pre>map(object({<br/>    name      = string<br/>    zone_name = optional(string)<br/>    ttl       = number<br/>    records   = list(string)<br/>    tags      = optional(map(string))<br/>  }))</pre> | `null` | no |
| <a name="input_soa_record"></a> [soa\_record](#input\_soa\_record) | * `email` - (Required) The email contact for the SOA record.<br/>  * `expire_time` - (Optional) The expire time for the SOA record. Defaults to 2419200.<br/>  * `minimum_ttl` - (Optional) The minimum Time To Live for the SOA record. By convention, it is used to determine the negative caching duration. Defaults to 10.<br/>  * `refresh_time` - (Optional) The refresh time for the SOA record. Defaults to 3600.<br/>  * `retry_time` - (Optional) The retry time for the SOA record. Defaults to 300.<br/>  * `ttl` - (Optional) The Time To Live of the SOA Record in seconds. Defaults to 3600.<br/>  * `tags` - (Optional) A mapping of tags to assign to the Record Set.<br/><br/>  Example Input:<pre>soa_record = {<br/>    email         = "admin.contoso.com"<br/>    expire_time   = 604800<br/>    minimum_ttl   = 300<br/>    refresh_time  = 3600<br/>    retry_time    = 600<br/>    ttl           = 3600<br/>  }</pre> | <pre>object({<br/>    email        = string<br/>    expire_time  = optional(number)<br/>    minimum_ttl  = optional(number)<br/>    refresh_time = optional(number)<br/>    retry_time   = optional(number)<br/>    ttl          = optional(number)<br/>    tags         = optional(map(string))<br/>  })</pre> | `null` | no |
| <a name="input_srv_records"></a> [srv\_records](#input\_srv\_records) | A map of objects where each object contains information to create a SRV record..<br/>  The following arguments are supported:<br/>  * `name` - (Required) The name of the DNS PTR Record. Changing this forces a new resource to be created.<br/>  * `resource_group_name` - (Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created.<br/>  * `zone_name` - (Required) Specifies the Private DNS Zone where the resource exists. Changing this forces a new resource to be created.<br/>  * `ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds.<br/>  * `record` - (Required) List of Fully Qualified Domain Names.<br/>  * `tags` - (Optional) A mapping of tags to assign to the resource.<br/>  A record block supports the following:<br/>  * `priority` - (Required) The priority of the SRV record.<br/>  * `weight` - (Required) The Weight of the SRV record.<br/>  * `port` - (Required) The Port the service is listening on.<br/>  * `target` - (Required) The FQDN of the service.<br/><br/>  Example Input:<pre>srv_records = {<br/>    "my-srv-record-1" = {<br/>      name      = "_sip._tcp.example.com"<br/>      zone_name = "privatelink.blob.core.windows.net"<br/>      ttl       = 3600<br/>      record = {<br/>        "srv1" = {<br/>          priority = 10<br/>          weight   = 5<br/>          port     = 5060<br/>          target   = "sipserver.example.com"<br/>        },<br/>        "srv2" = {<br/>          priority = 20<br/>          weight   = 10<br/>          port     = 5060<br/>          target   = "sipbackup.example.com"<br/>        }<br/>      }<br/>      tags = { "environment" = "dev", "project" = "example" }<br/>    }</pre> | <pre>map(object({<br/>    name      = string<br/>    zone_name = optional(string)<br/>    ttl       = number<br/>    record = map(object({<br/>      priority = number<br/>      weight   = number<br/>      port     = number<br/>      target   = string<br/>    }))<br/>    tags = optional(map(string))<br/>  }))</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | * `tags` - (Optional) A mapping of tags to assign to the resource.<br/><br/>  Example input:<pre>tags = {<br/>    env     = prod<br/>    region  = gwc<br/>  }</pre> | `map(string)` | `null` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | * `timeouts` - The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/docs/configuration/resources.html#timeouts) for certain actions:<br/>  * `create` - (Defaults to 30 minutes) Used when creating the Container App.<br/>  * `delete` - (Defaults to 30 minutes) Used when deleting the Container App.<br/>  * `read` - (Defaults to 5 minutes) Used when retrieving the Container App.<br/>  * `update` - (Defaults to 30 minutes) Used when updating the Container App.<br/><br/> Example Input:<pre>container_app_timeouts = {<br/>  create = "45m"<br/>  delete = "30m"<br/>  read   = "10m"<br/>  update = "40m"<br/> }</pre> | <pre>object({<br/>    create = optional(string)<br/>    delete = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_txt_records"></a> [txt\_records](#input\_txt\_records) | A map of objects where each object contains information to create a TXT record.<br/>  The following arguments are supported:<br/>  * `name` - (Required) The name of the DNS TXT Record. Changing this forces a new resource to be created.<br/>  * `resource_group_name` - (Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created.<br/>  * `zone_name` - (Required) Specifies the Private DNS Zone where the resource exists. Changing this forces a new resource to be created.<br/>  * `record` - (Required) One or more record blocks as defined below.<br/>  * `ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds.<br/>  * `tags` - (Optional) A mapping of tags to assign to the resource.<br/>  A record block supports the following:<br/>  * `value` - (Required) The value of the TXT record. Max length: 1024 characters<br/><br/>  Example Input:<pre>txt_records = {<br/>    "example-txt" = {<br/>      name      = "example"<br/>      zone_name = "example.com"<br/>      ttl       = 3600<br/>      record = {<br/>        "entry1" = {<br/>          value = "v=spf1 include:example.com ~all"<br/>        },<br/>        "entry2" = {<br/>          value = "some-other-verification=12345"<br/>        }<br/>      }<br/>      tags = { "environment" = "dev", "project" = "example" }<br/>    }<br/>  }</pre> | <pre>map(object({<br/>    name      = string<br/>    zone_name = optional(string)<br/>    ttl       = number<br/>    record = map(object({<br/>      value = string<br/>    }))<br/>    tags = optional(map(string))<br/>  }))</pre> | `null` | no |
| <a name="input_vnet_links"></a> [vnet\_links](#input\_vnet\_links) | Dynamically links the DNS zone to one or more virtual link networks with optional auto-registration of DNS records.<br/>  The following arguments are supported:<br/>  * `name` - (Required) The name of the Private DNS Zone Virtual Network Link. Changing this forces a new resource to be created.<br/>  * `virtual_network_id` - (Required) The ID of the Virtual Network that should be linked to the DNS Zone. Changing this forces a new resource to be created.<br/>  * `registration_enabled` - (Optional) Is auto-registration of virtual machine records in the virtual network in the Private DNS zone enabled? Defaults to false.<br/><br/>  Example input:<pre>vnet_links = {<br/>    "vnet-link-1" = {<br/>      virtual_network_id   = "/subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.Network/virtualNetworks/vnet1"<br/>      registration_enabled = true<br/>    },<br/>    "vnet-link-2" = {<br/>      virtual_network_id   = "/subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.Network/virtualNetworks/vnet2"<br/>      registration_enabled = false<br/>    }<br/>  }</pre> | <pre>map(object({<br/>    name                 = string<br/>    virtual_network_id   = string<br/>    registration_enabled = optional(bool, false)<br/>  }))</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_a_records"></a> [a\_records](#output\_a\_records) | Blocks containing configuration of each A record. |
| <a name="output_aaaa_records"></a> [aaaa\_records](#output\_aaaa\_records) | Blocks containing configuration of each AAAA record. |
| <a name="output_cname_records"></a> [cname\_records](#output\_cname\_records) | Blocks containing configuration of each CNAME record. |
| <a name="output_mx_records"></a> [mx\_records](#output\_mx\_records) | Blocks containing configuration of each MX record. |
| <a name="output_private_dns"></a> [private\_dns](#output\_private\_dns) | * `name` - The name of the Private DNS Zone.<br/>  * `resource_group_name` - The name of the resource group in which the DNS zone is created.<br/>  * `id` - The resource ID of the Private DNS Zone.<br/>  * `tags` - A mapping of tags assigned to the Private DNS Zone.<br/><br/>  Example output usage:<br/>  output "private\_dns\_zone\_name" {<br/>    value = module.module\_name.private\_dns.name<br/>  } |
| <a name="output_ptr_records"></a> [ptr\_records](#output\_ptr\_records) | Blocks containing configuration of each PTR record. |
| <a name="output_srv_records"></a> [srv\_records](#output\_srv\_records) | Blocks containing configuration of each SRV record. |
| <a name="output_txt_records"></a> [txt\_records](#output\_txt\_records) | Blocks containing configuration of each TXT record. |
| <a name="output_virtual_network_link_id"></a> [virtual\_network\_link\_id](#output\_virtual\_network\_link\_id) | Virtual network link id. |

## Modules

No modules.

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
<!-- END OF PRE-COMMIT-OPENTOFU DOCS HOOK -->