# Sprint 03 Client Handover

---

## Project

WarehousePro Azure Landing Zone

---

## Sprint

Sprint 03 – Azure Bicep Infrastructure as Code

---

## Sprint Duration

06 July 2026 – 11 July 2026

---

## Prepared By

Nhlanhla M

Cloud Infrastructure Engineer

# Executive Summary

Sprint 03 successfully modernized the WarehousePro Azure Landing Zone by converting the existing Azure PowerShell deployment solution into a modular Azure Bicep Infrastructure as Code implementation.

The objective of this sprint was to establish a reusable, enterprise-ready Infrastructure as Code framework capable of deploying the complete Azure Landing Zone using Azure Bicep.

During implementation several architectural improvements were introduced. Azure Bicep modules were redesigned around Azure resource ownership, module interfaces were standardized, and reusable deployment patterns were adopted. Module communication was simplified through standardized outputs and Resource ID references while unnecessary deployment dependencies were removed following Azure Bicep best practices.

All modules were successfully deployed, validated, documented and committed to source control.

The Azure environment now supports fully modular Infrastructure as Code capable of supporting future platform expansion through reusable Azure Bicep modules.

# Sprint Objectives

The following objectives were defined during Sprint Planning.

| ID | Objective | Status |
|----|-----------|--------|
| OBJ-013 | Convert Azure PowerShell deployments to Azure Bicep | ✅ Complete |
| OBJ-014 | Create reusable Azure Bicep modules | ✅ Complete |
| OBJ-015 | Implement modular deployment orchestration | ✅ Complete |
| OBJ-016 | Parameterize Azure deployments | ✅ Complete |
| OBJ-017 | Standardize module interfaces | ✅ Complete |
| OBJ-018 | Validate Azure Bicep deployments | ✅ Complete |
| OBJ-019 | Update project documentation | ✅ Complete |

# Deliverables Completed

## Azure Bicep Modules

The following Azure Bicep modules were developed and successfully validated.

| Module | Purpose | Status |
|---------|---------|--------|
| resourceGroups.bicep | Deploy Resource Groups | ✅ |
| hubVirtualNetwork.bicep | Deploy Hub Virtual Network | ✅ |
| hubSubnets.bicep | Deploy Hub Subnets | ✅ |
| spokeVirtualNetworks.bicep | Deploy Regional Spoke Virtual Networks | ✅ |
| workloadSubnets.bicep | Deploy Workload Subnets | ✅ |
| routeTables.bicep | Deploy Route Tables | ✅ |
| vnetPeerings.bicep | Deploy Virtual Network Peerings | ✅ |
| networkSecurityGroups.bicep | Deploy Network Security Groups | ✅ |
| main.bicep | Deployment Orchestration | ✅ |
| main.prod.bicepparam | Production Parameters | ✅ |

# Azure Resources Validated

## Resource Groups

- RG-Networking-Prod

- RG-Identity-Prod

- RG-Management-Prod

- RG-Monitoring-Prod

- RG-SharedServices-Prod

- RG-WH-JHB-Prod

- RG-WH-DBN-Prod

- RG-WH-CPT-Prod

---

## Networking

Validated deployment of:

- Hub Virtual Network

- Hub Subnets

- Regional Spoke Virtual Networks

- Workload Subnets

- Route Tables

- Hub-and-Spoke Virtual Network Peerings

---

## Security

Validated deployment of:

- NSG-WH-JHB-Prod

- NSG-WH-DBN-Prod

- NSG-WH-CPT-Prod

# Architecture Improvements

Sprint 03 introduced significant Infrastructure as Code improvements.

The implemented design includes:

- Modular Azure Bicep architecture

- Subscription-level deployment orchestration

- Resource Group scoped modules

- Standardized module interfaces

- Resource ID based module communication

- Azure resource ownership aligned module boundaries

- Enterprise folder structure

- Reusable deployment modules

The architecture significantly improves maintainability, scalability and future platform expansion.

# Quality Assurance

The following validation activities were successfully completed.

| Validation | Status |
|------------|--------|
| Azure Bicep Build Validation | ✅ |
| Azure Deployment Validation | ✅ |
| Azure Portal Verification | ✅ |
| Visualizer Validation | ✅ |
| Module Interface Validation | ✅ |
| Azure Bicep Linter Validation | ✅ |
| Documentation Review | ✅ |

# Deployment Evidence

Deployment evidence has been captured and stored within the project repository.

Evidence includes:

- Azure Portal screenshots

- Azure deployment output

- Azure Bicep Visualizer screenshots

- Git commit history

- Updated architecture documentation

- ADR documentation

- Lessons Learned

- Sprint documentation

# Risks

Current project risks are considered low.

Potential future risks include:

- Increased module complexity as additional Azure services are introduced.

- Governance requirements as platform capabilities expand.

- Security configuration requirements during future platform hardening.

Mitigation strategies will be addressed during Sprint 04.

# Recommendations

The following recommendations are proposed.

- Continue Infrastructure as Code using Azure Bicep.

- Continue maintaining reusable module architecture.

- Continue documenting Architecture Decision Records.

- Maintain standardized module interfaces.

- Continue incremental deployment validation.

- Continue maintaining engineering documentation.

# Sprint Acceptance

Sprint 03 acceptance criteria have been satisfied.

| Deliverable | Status |
|-------------|--------|
| Azure Bicep Modules Complete | ✅ |
| Azure Deployments Verified | ✅ |
| Documentation Complete | ✅ |
| Architecture Validated | ✅ |
| Git Repository Updated | ✅ |
| Screenshots Captured | ✅ |

# Sprint Status

**Accepted**

# Planned Scope for Sprint 04

Sprint 04 will focus on Azure Security implementation.

Planned deliverables include:

- Configure Network Security Rules

- Implement Azure Firewall

- Deploy Azure Bastion

- Configure Private Endpoints

- Deploy Azure Key Vault

- Implement Managed Identities

- Apply Azure security best practices

- Update project documentation

# Client Sign-off

| Role | Name | Signature | Date |
|------|------|-----------|------|
| Cloud Infrastructure Engineer | Nhlanhla M | __________ | __________ |
| Infrastructure Manager | __________________ | __________ | __________ |
| Project Sponsor (CIO) | __________________ | __________ | __________ |

# Conclusion

Sprint 03 successfully transformed the WarehousePro Azure Landing Zone into a modular Azure Bicep Infrastructure as Code solution.

The Azure environment now supports reusable enterprise Infrastructure as Code through standardized Azure Bicep modules, subscription-level orchestration, parameterized deployments, and comprehensive engineering documentation.

Combined with the Azure Landing Zone foundation established during Sprint 01 and the enterprise networking platform delivered during Sprint 02, the project now provides a scalable, maintainable and enterprise-ready Infrastructure as Code platform prepared for advanced security implementation during Sprint 04.