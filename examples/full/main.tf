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
