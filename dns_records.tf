resource "azurerm_private_dns_a_record" "a_records" {
  for_each = var.a_records == null ? {} : var.a_records

  name                = each.value.name
  resource_group_name = var.resource_group_name
  zone_name           = azurerm_private_dns_zone.private_dns.name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = each.value.tags

  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]

    content {
      read = timeouts.value.read
    }
  }
}

resource "azurerm_private_dns_aaaa_record" "aaaa_records" {
  for_each = var.aaaa_records == null ? {} : var.aaaa_records

  name                = each.value.name
  resource_group_name = var.resource_group_name
  zone_name           = azurerm_private_dns_zone.private_dns.name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = each.value.tags

  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]

    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
      update = timeouts.value.update
    }
  }
}

resource "azurerm_private_dns_cname_record" "cname_records" {
  for_each = var.cname_records == null ? {} : var.cname_records

  name                = each.value.name
  resource_group_name = var.resource_group_name
  zone_name           = azurerm_private_dns_zone.private_dns.name
  ttl                 = each.value.ttl
  record              = each.value.record
  tags                = each.value.tags

  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]

    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
      update = timeouts.value.update
    }
  }
}

resource "azurerm_private_dns_mx_record" "mx_records" {
  for_each = var.mx_records == null ? {} : var.mx_records

  name                = each.value.name
  resource_group_name = var.resource_group_name
  zone_name           = azurerm_private_dns_zone.private_dns.name
  ttl                 = each.value.ttl
  tags                = each.value.tags

  dynamic "record" {
    for_each = each.value.record

    content {
      preference = record.value.preference
      exchange   = record.value.exchange
    }
  }

  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]

    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
      update = timeouts.value.update
    }
  }
}

resource "azurerm_private_dns_ptr_record" "ptr_records" {
  for_each = var.ptr_records == null ? {} : var.ptr_records

  name                = each.value.name
  resource_group_name = var.resource_group_name
  zone_name           = azurerm_private_dns_zone.private_dns.name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = each.value.tags

  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]

    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
      update = timeouts.value.update
    }
  }
}

resource "azurerm_private_dns_srv_record" "srv_records" {
  for_each = var.srv_records == null ? {} : var.srv_records

  name                = each.value.name
  resource_group_name = var.resource_group_name
  zone_name           = azurerm_private_dns_zone.private_dns.name
  ttl                 = each.value.ttl
  tags                = each.value.tags

  dynamic "record" {
    for_each = each.value.record

    content {
      priority = record.value.priority
      weight   = record.value.weight
      port     = record.value.port
      target   = record.value.target
    }
  }

  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]

    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
      update = timeouts.value.update
    }
  }
}

resource "azurerm_private_dns_txt_record" "txt_records" {
  for_each = var.txt_records == null ? {} : var.txt_records

  name                = each.value.name
  resource_group_name = var.resource_group_name
  zone_name           = azurerm_private_dns_zone.private_dns.name
  ttl                 = each.value.ttl
  tags                = each.value.tags

  dynamic "record" {
    for_each = each.value.record

    content {
      value = record.value.value
    }
  }

  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]

    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
      update = timeouts.value.update
    }
  }
}
