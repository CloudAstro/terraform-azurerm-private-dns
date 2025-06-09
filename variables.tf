variable "name" {
  type        = string
  description = <<DESCRIPTION
  * `name` -  (Required) The name of the Private DNS Zone. Must be a valid domain name. Changing this forces a new resource to be created.
  * -> **NOTE:** If you are going to be using the Private DNS Zone with a Private Endpoint the name of the Private DNS Zone must follow the Private DNS Zone name schema in the product documentation in order for the two resources to be connected successfully.

  Example Input:
  ```
  name = "privatelink.blob.core.windows.net"
  ```
  DESCRIPTION
}

variable "resource_group_name" {
  type        = string
  description = <<DESCRIPTION
  * `resource_group_name` - (Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created.

  Example Input:
  ```
  resource_group_name = "rg-private-dns-dev"
  ```
  DESCRIPTION
}

variable "soa_record" {
  type = object({
    email        = string
    expire_time  = optional(number)
    minimum_ttl  = optional(number)
    refresh_time = optional(number)
    retry_time   = optional(number)
    ttl          = optional(number)
    tags         = optional(map(string))
  })
  default     = null
  description = <<DESCRIPTION
  * `email` - (Required) The email contact for the SOA record.
  * `expire_time` - (Optional) The expire time for the SOA record. Defaults to 2419200.
  * `minimum_ttl` - (Optional) The minimum Time To Live for the SOA record. By convention, it is used to determine the negative caching duration. Defaults to 10.
  * `refresh_time` - (Optional) The refresh time for the SOA record. Defaults to 3600.
  * `retry_time` - (Optional) The retry time for the SOA record. Defaults to 300.
  * `ttl` - (Optional) The Time To Live of the SOA Record in seconds. Defaults to 3600.
  * `tags` - (Optional) A mapping of tags to assign to the Record Set.

  Example Input:
  ```
  soa_record = {
    email         = "admin.contoso.com"
    expire_time   = 604800
    minimum_ttl   = 300
    refresh_time  = 3600
    retry_time    = 600
    ttl           = 3600
  }
  ```
  DESCRIPTION
}

variable "tags" {
  type        = map(string)
  default     = null
  description = <<DESCRIPTION
  * `tags` - (Optional) A mapping of tags to assign to the resource.

  Example input:
  ```
  tags = {
    env     = prod
    region  = gwc
  }

  ```
  DESCRIPTION
}

variable "a_records" {
  type = map(object({
    name    = string
    ttl     = number
    records = list(string)
    tags    = optional(map(string))
  }))
  default     = null
  description = <<DESCRIPTION
  * `name` - (Required) The name of the DNS A Record. Changing this forces a new resource to be created.
  * `ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds.
  * `records` - (Required) List of IPv4 Addresses.
  * `tags` - (Optional) A mapping of tags to assign to the resource.

  Example Input:
  ```
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
      tags    = {}
    }
  }
  ```
  DESCRIPTION
}

variable "aaaa_records" {
  type = map(object({
    name      = string
    zone_name = optional(string)
    ttl       = number
    records   = list(string)
    tags      = optional(map(string))
  }))
  default     = null
  description = <<DESCRIPTION
  A map of objects where each object contains information to create a AAAA record.
  The following arguments are supported:
  * `name` - (Required) The name of the DNS A Record. Changing this forces a new resource to be created.
  * `zone_name` - (Required) Specifies the Private DNS Zone where the resource exists. Changing this forces a new resource to be created.
  * `ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds.
  * `records` - (Required) A list of IPv6 Addresses.
  * `tags` - (Optional) A mapping of tags to assign to the resource.

  Example Input:
  ```
  aaaa_records = {
    "my-aaaa-record-1" = {
      name      = "record1"
      zone_name = "privatelink.blob.core.windows.net"
      records   = ["2001:0db8:85a3:0000:0000:8a2e:0370:7334"]
      ttl       = 3600
      tags      = { "environment" = "dev", "project" = "example" }
    }
  }
  ```
  DESCRIPTION
}

variable "cname_records" {
  type = map(object({
    name      = string
    zone_name = optional(string)
    ttl       = number
    record    = string
    tags      = optional(map(string))
  }))
  default     = null
  description = <<DESCRIPTION
  A map of objects where each object contains information to create a CNAME record.
  The following arguments are supported:
  * `name` - (Required) The name of the DNS CNAME Record. Changing this forces a new resource to be created.
  * `zone_name` - (Required) Specifies the Private DNS Zone where the resource exists. Changing this forces a new resource to be created.
  * `ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds. Possible values are between 0 and 2147483647.
  * `record` - (Required) The target of the CNAME.
  * `tags` - (Optional) A mapping of tags to assign to the resource.

  Example Input:
  ```
  cname_records = {
    "my-cname-record-1" = {
      name                = "record1"
      zone_name           = "privatelink.blob.core.windows.net"
      ttl                 = 3600
      record              = "example.com"
      tags                = { "environment" = "dev", "project" = "example" }
    }
  }
  ```
  DESCRIPTION
}

variable "mx_records" {
  type = map(object({
    name      = optional(string, "@")
    zone_name = optional(string)
    record = map(object({
      preference = number
      exchange   = string
    }))
    ttl  = number
    tags = optional(map(string))
  }))
  default     = null
  description = <<DESCRIPTION
  A map of objects where each object contains information to create a MX record.
  The following arguments are supported:
  * `name` - (Optional) The name of the DNS MX Record. Changing this forces a new resource to be created. Default to '@' for root zone entry.
  * `resource_group_name` - (Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created.
  * `zone_name` - (Required) Specifies the Private DNS Zone where the resource exists. Changing this forces a new resource to be created.
  * `record` - (Required) One or more record blocks as defined below.
  * `ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds.
  * `tags` - (Optional) A mapping of tags to assign to the resource.
  A record block supports the following:
  * `preference` - (Required) The preference of the MX record.
  * `exchange` - (Required) The FQDN of the exchange to MX record points to.

  Example Input:
  ```
  mx_records = {
    "my-mx-record-1" = {
      name      = "record1"
      zone_name = "privatelink.blob.core.windows.net"
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
  ```
  DESCRIPTION
}

variable "ptr_records" {
  type = map(object({
    name      = string
    zone_name = optional(string)
    ttl       = number
    records   = list(string)
    tags      = optional(map(string))
  }))
  default     = null
  description = <<DESCRIPTION
  A map of objects where each object contains information to create a PTR record.
  The following arguments are supported:
  * `name` - (Required) The name of the DNS PTR Record. Changing this forces a new resource to be created.
  * `resource_group_name` - (Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created.
  * `zone_name` - (Required) Specifies the Private DNS Zone where the resource exists. Changing this forces a new resource to be created.
  * `ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds.
  * `records` - (Required) List of Fully Qualified Domain Names.
  * `tags` - (Optional) A mapping of tags to assign to the resource.

  Example Input:
  ```
  ptr_records = {
    "my-ptr-record-1" = {
      name      = "record1"
      zone_name = "privatelink.blob.core.windows.net"
      ttl       = 3600
      records   = ["ptr.example.com"]
      tags      = { "environment" = "dev", "project" = "example" }
    }
  }
  ```
  DESCRIPTION
}

variable "srv_records" {
  type = map(object({
    name      = string
    zone_name = optional(string)
    ttl       = number
    record = map(object({
      priority = number
      weight   = number
      port     = number
      target   = string
    }))
    tags = optional(map(string))
  }))
  default     = null
  description = <<DESCRIPTION
  A map of objects where each object contains information to create a SRV record..
  The following arguments are supported:
  * `name` - (Required) The name of the DNS PTR Record. Changing this forces a new resource to be created.
  * `resource_group_name` - (Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created.
  * `zone_name` - (Required) Specifies the Private DNS Zone where the resource exists. Changing this forces a new resource to be created.
  * `ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds.
  * `record` - (Required) List of Fully Qualified Domain Names.
  * `tags` - (Optional) A mapping of tags to assign to the resource.
  A record block supports the following:
  * `priority` - (Required) The priority of the SRV record.
  * `weight` - (Required) The Weight of the SRV record.
  * `port` - (Required) The Port the service is listening on.
  * `target` - (Required) The FQDN of the service.

  Example Input:
  ```
  srv_records = {
    "my-srv-record-1" = {
      name      = "_sip._tcp.example.com"
      zone_name = "privatelink.blob.core.windows.net"
      ttl       = 3600
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
  ```
  DESCRIPTION
}

variable "txt_records" {
  type = map(object({
    name      = string
    zone_name = optional(string)
    ttl       = number
    record = map(object({
      value = string
    }))
    tags = optional(map(string))
  }))
  default     = null
  description = <<DESCRIPTION
  A map of objects where each object contains information to create a TXT record.
  The following arguments are supported:
  * `name` - (Required) The name of the DNS TXT Record. Changing this forces a new resource to be created.
  * `resource_group_name` - (Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created.
  * `zone_name` - (Required) Specifies the Private DNS Zone where the resource exists. Changing this forces a new resource to be created.
  * `record` - (Required) One or more record blocks as defined below.
  * `ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds.
  * `tags` - (Optional) A mapping of tags to assign to the resource.
  A record block supports the following:
  * `value` - (Required) The value of the TXT record. Max length: 1024 characters

  Example Input:
  ```
  txt_records = {
    "example-txt" = {
      name      = "example"
      zone_name = "example.com"
      ttl       = 3600
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
  ```
  DESCRIPTION
}

variable "vnet_links" {
  type = map(object({
    name                 = string
    virtual_network_id   = string
    registration_enabled = optional(bool, false)
  }))
  default     = null
  description = <<DESCRIPTION
  Dynamically links the DNS zone to one or more virtual link networks with optional auto-registration of DNS records.
  The following arguments are supported:
  * `name` - (Required) The name of the Private DNS Zone Virtual Network Link. Changing this forces a new resource to be created.
  * `virtual_network_id` - (Required) The ID of the Virtual Network that should be linked to the DNS Zone. Changing this forces a new resource to be created.
  * `registration_enabled` - (Optional) Is auto-registration of virtual machine records in the virtual network in the Private DNS zone enabled? Defaults to false.

  Example input:
  ```
  vnet_links = {
    "vnet-link-1" = {
      virtual_network_id   = "/subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.Network/virtualNetworks/vnet1"
      registration_enabled = true
    },
    "vnet-link-2" = {
      virtual_network_id   = "/subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.Network/virtualNetworks/vnet2"
      registration_enabled = false
    }
  }
  ```
  DESCRIPTION
}

variable "timeouts" {
  type = object({
    create = optional(string)
    delete = optional(string)
    read   = optional(string)
    update = optional(string)
  })
  default     = null
  description = <<DESCRIPTION
 * `timeouts` - The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/docs/configuration/resources.html#timeouts) for certain actions:
  * `create` - (Defaults to 30 minutes) Used when creating the Container App.
  * `delete` - (Defaults to 30 minutes) Used when deleting the Container App.
  * `read` - (Defaults to 5 minutes) Used when retrieving the Container App.
  * `update` - (Defaults to 30 minutes) Used when updating the Container App.

 Example Input:
 ```
 container_app_timeouts = {
  create = "45m"
  delete = "30m"
  read   = "10m"
  update = "40m"
 }
 ```
 DESCRIPTION
}
