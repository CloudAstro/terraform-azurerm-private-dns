output "private_dns" {
  value       = azurerm_private_dns_zone.private_dns
  description = <<DESCRIPTION
  * `name` - The name of the Private DNS Zone.
  * `resource_group_name` - The name of the resource group in which the DNS zone is created.
  * `id` - The resource ID of the Private DNS Zone.
  * `tags` - A mapping of tags assigned to the Private DNS Zone.

  Example output usage:
  output "private_dns_zone_name" {
    value = module.module_name.private_dns.name
  }
  DESCRIPTION
}
output "virtual_network_link_id" {
  value       = { for key, vlink in azurerm_private_dns_zone_virtual_network_link.vnet_links : key => { id = vlink.id } }
  description = "Virtual network link id."
}

output "a_records" {
  value       = { for record_name, record in azurerm_private_dns_a_record.a_records : record_name => { id = record.id, fqdn = record.fqdn } }
  description = "Blocks containing configuration of each A record."
}

output "aaaa_records" {
  value       = { for record_name, record in azurerm_private_dns_aaaa_record.aaaa_records : record.name => { id = record.id, fqdn = record.fqdn } }
  description = "Blocks containing configuration of each AAAA record."
}

output "cname_records" {
  value       = { for record_name, record in azurerm_private_dns_cname_record.cname_records : record.name => { id = record.id, fqdn = record.fqdn } }
  description = "Blocks containing configuration of each CNAME record."
}

output "mx_records" {
  value       = { for record_name, record in azurerm_private_dns_mx_record.mx_records : record.name => { id = record.id, fqdn = record.fqdn } }
  description = "Blocks containing configuration of each MX record."
}

output "ptr_records" {
  value       = { for record_name, record in azurerm_private_dns_ptr_record.ptr_records : record.name => { id = record.id, fqdn = record.fqdn } }
  description = "Blocks containing configuration of each PTR record."
}

output "srv_records" {
  value       = { for record_name, record in azurerm_private_dns_srv_record.srv_records : record.name => { id = record.id, fqdn = record.fqdn } }
  description = "Blocks containing configuration of each SRV record."
}

output "txt_records" {
  value       = { for record_name, record in azurerm_private_dns_txt_record.txt_records : record.name => { id = record.id, fqdn = record.fqdn } }
  description = "Blocks containing configuration of each TXT record."
}
