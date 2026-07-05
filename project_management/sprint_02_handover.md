# Sprint 02 Client Handover

---

## Project

WarehousePro Azure Landing Zone

---

## Sprint

Sprint 02 – Enterprise Networking

---

## Sprint Duration

04 July 2026 – 05 July 2026

---

## Prepared By

Nhlanhla M

Cloud Infrastructure Engineer

# Executive Summary

Sprint 02 successfully expanded the Azure Landing Zone by implementing the enterprise networking layer for WarehousePro Logistics.

The objective of this sprint was to deploy regional warehouse Virtual Networks, establish Hub-and-Spoke connectivity, implement network segmentation through Network Security Groups and Route Tables, and validate the complete networking infrastructure using automated PowerShell deployment scripts.

During implementation, an architecture review identified the need for dedicated spoke subnets. This enhancement was incorporated into the sprint through an additional deployment script, ensuring that Route Tables could be correctly associated with workload subnets.

All networking components were successfully deployed, validated, and committed to source control.

The Azure environment now provides a fully connected enterprise Hub-and-Spoke topology ready to support future workloads and cloud-native services.

# Sprint Objectives

The following objectives were defined during Sprint Planning.

| ID | Objective | Status |
|----|-----------|--------|
| OBJ-006 | Deploy regional Spoke Virtual Networks | ✅ Complete |
| OBJ-007 | Configure Hub-and-Spoke VNet Peerings | ✅ Complete |
| OBJ-008 | Deploy Network Security Groups | ✅ Complete |
| OBJ-009 | Deploy Route Tables | ✅ Complete |
| OBJ-010 | Deploy Spoke Subnets | ✅ Complete |
| OBJ-011 | Associate Route Tables with Subnets | ✅ Complete |
| OBJ-012 | Validate Enterprise Network Connectivity | ✅ Complete |

# Deliverables Completed

## Azure PowerShell Automation

The following deployment scripts were developed and successfully tested.

| Script | Purpose | Status |
|---------|---------|--------|
| 06_spoke_virtual_networks.sh| Deploy Regional Spoke VNets | ✅ |
| 07_vnet_peering.ps1 | Configure Hub-and-Spoke Peerings | ✅ |
| 08_network_security_groups.ps1 | Deploy Network Security Groups | ✅ |
| 09_route_tables.ps1 | Deploy Route Tables | ✅ |
| 09A_spoke_subnets.ps1 | Deploy Warehouse Subnets | ✅ |
| 10_route_table_associations.ps1 | Associate Route Tables with Subnets | ✅ |
| 11_connectivity_validation.ps1 | Validate Enterprise Network | ✅ |