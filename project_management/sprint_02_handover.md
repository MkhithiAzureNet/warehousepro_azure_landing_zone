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

# Azure Resources Deployed

## Regional Virtual Networks

| Virtual Network | Address Space |
|-----------------|---------------|
| VNET-WH-JHB-Prod | 10.1.0.0/16 |
| VNET-WH-DBN-Prod | 10.2.0.0/16 |
| VNET-WH-CPT-Prod | 10.3.0.0/16 |

---

## Warehouse Subnets

| Virtual Network | Subnet | Address Prefix |
|-----------------|--------|----------------|
| VNET-WH-JHB-Prod | WarehouseSubnet | 10.1.1.0/24 |
| VNET-WH-DBN-Prod | WarehouseSubnet | 10.2.1.0/24 |
| VNET-WH-CPT-Prod | WarehouseSubnet | 10.3.1.0/24 |

---

## Network Security Groups

- NSG-WH-JHB-Prod

- NSG-WH-DBN-Prod

- NSG-WH-CPT-Prod

---

## Route Tables

- RT-WH-JHB-Prod

- RT-WH-DBN-Prod

- RT-WH-CPT-Prod

---

## Hub-and-Spoke Peerings

- Hub ↔ Johannesburg

- Hub ↔ Durban

- Hub ↔ Cape Town

# Architecture Implemented

Sprint 02 completed the enterprise Hub-and-Spoke networking architecture.

The implemented design includes:

- Regional warehouse Virtual Networks

- Dedicated Warehouse Subnets

- Bidirectional Hub-and-Spoke Virtual Network Peerings

- Dedicated Network Security Groups per warehouse

- Dedicated Route Tables per warehouse

- Route Table associations to workload subnets

- Automated post-deployment connectivity validation

The architecture provides secure network segmentation while allowing centralized connectivity through the Hub Virtual Network.

# Quality Assurance

The following validation activities were successfully completed.

| Validation | Status |
|------------|--------|
| Azure Login Validation | ✅ |
| Resource Group Validation | ✅ |
| Virtual Network Validation | ✅ |
| Subnet Validation | ✅ |
| Network Security Group Validation | ✅ |
| Route Table Validation | ✅ |
| Route Table Association Validation | ✅ |
| Hub-and-Spoke Peering Validation | ✅ |
| Azure Portal Verification | ✅ |

# Deployment Evidence

Deployment evidence has been captured and stored within the project repository.

Evidence includes:

- Azure Portal screenshots

- Azure PowerShell deployment output

- Connectivity validation output

- Git commit history

- Updated architecture documentation

- Sprint documentation

# Risks

Current project risks are considered low.

Potential future risks include:

- Increased routing complexity as additional warehouse locations are added.

- Azure networking costs as advanced services are introduced.

- Future security policy requirements.

Mitigation strategies will be addressed during Sprint 03 and future networking enhancements.

# Recommendations

The following recommendations are proposed.

- Continue using reusable PowerShell automation.

- Maintain Architecture Decision Records.

- Continue Infrastructure as Code using Azure Bicep.

- Continue Infrastructure as Code using Terraform.

- Expand post-deployment validation automation.

- Maintain evidence collection after every sprint.

# Sprint Acceptance

Sprint 02 acceptance criteria have been satisfied.

| Deliverable | Status |
|-------------|--------|
| PowerShell Automation Complete | ✅ |
| Azure Resources Verified | ✅ |
| Connectivity Validated | ✅ |
| Documentation Complete | ✅ |
| Git Repository Updated | ✅ |
| Screenshots Captured | ✅ |

Sprint Status

**Accepted**

# Planned Scope for Sprint 03

Sprint 03 will focus on Azure Bicep implementation.

Planned deliverables include:

- Convert PowerShell deployments into Azure Bicep modules

- Create reusable Bicep templates

- Parameterize deployments

- Modularize networking components

- Deploy complete environment using Infrastructure as Code

- Validate Azure Bicep deployments

- Update project documentation

# Client Sign-off

| Role | Name | Signature | Date |
|------|------|-----------|------|
| Cloud Infrastructure Engineer | Nhlanhla M | __________ | __________ |
| Infrastructure Manager | __________________ | __________ | __________ |
| Project Sponsor (CIO) | __________________ | __________ | __________ |

# Conclusion

Sprint 02 successfully delivered the enterprise networking layer for the WarehousePro Azure Landing Zone.

The Azure environment now includes a fully connected Hub-and-Spoke architecture with dedicated warehouse Virtual Networks, workload subnets, Network Security Groups, Route Tables, and automated deployment validation.

Combined with the Azure Landing Zone foundation established during Sprint 01, the platform now provides a secure, scalable, and standardized networking environment ready for Infrastructure as Code modernization in Sprint 03 using Azure Bicep.