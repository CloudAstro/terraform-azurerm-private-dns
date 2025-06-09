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
