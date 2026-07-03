# Sprint 01 Client Handover

---

## Project

WarehousePro Azure Landing Zone

---

## Sprint

Sprint 01 – Foundation Deployment

---

## Sprint Duration

01 July 2026 – 03 July 2026

---

## Prepared By

Nhlanhla M

Cloud Infrastructure Engineer

---

# Executive Summary

Sprint 01 successfully established the foundational Azure Landing Zone for WarehousePro Logistics.

The objective of this sprint was to create a secure, scalable, and standardized Azure foundation aligned with Microsoft Cloud Adoption Framework and Azure Landing Zone design principles.

The environment now contains the core networking infrastructure that will support future business workloads, warehouse connectivity, identity services, monitoring, and shared platform services.

All deliverables were completed successfully and are ready to support Sprint 02.

---

# Sprint Objectives

The following objectives were defined during Sprint Planning.

| ID | Objective | Status |
|----|-----------|--------|
| OBJ-001 | Create Azure Landing Zone foundation | ✅ Complete |
| OBJ-002 | Deploy enterprise Resource Groups | ✅ Complete |
| OBJ-003 | Apply enterprise governance tags | ✅ Complete |
| OBJ-004 | Deploy Hub Virtual Network | ✅ Complete |
| OBJ-005 | Deploy Hub Subnets | ✅ Complete |

---

# Deliverables Completed

## Azure CLI Automation

The following deployment scripts were developed and tested.

| Script | Purpose | Status |
|---------|---------|--------|
| 01_foundation.sh | Environment validation | ✅ |
| 02_resource_groups.sh | Enterprise Resource Groups | ✅ |
| 03_security.sh | Enterprise resource tagging | ✅ |
| 04_hub_network.sh | Hub Virtual Network deployment | ✅ |
| 05_hub_subnets.sh | Hub subnet deployment | ✅ |

---

## Azure Resources Deployed

### Resource Groups

- RG-Networking-Prod

- RG-Identity-Prod

- RG-Management-Prod

- RG-Monitoring-Prod

- RG-SharedServices-Prod

- RG-WH-JHB-Prod

- RG-WH-Durban-Prod

- RG-WH-CPT-Prod

---

### Hub Virtual Network

Resource

VNET-Hub-Prod

Address Space

10.0.0.0/16

Location

South Africa North

---

### Hub Subnets

| Subnet | Address Space |
|---------|---------------|
| AzureFirewallSubnet | 10.0.0.0/24 |
| AzureBastionSubnet | 10.0.1.0/26 |
| GatewaySubnet | 10.0.2.0/27 |
| SharedServicesSubnet | 10.0.10.0/24 |
| ManagementSubnet | 10.0.20.0/24 |

---

# Architecture Decisions Implemented

The following Architecture Decision Records were approved and implemented during Sprint 01.

| ADR | Description | Status |
|------|-------------|--------|
| ADR-001 | Hub-and-Spoke Network Topology | ✅ |
| ADR-002 | Dedicated Warehouse Spokes | ✅ |
| ADR-003 | Lifecycle-Based Resource Groups | ✅ |
| ADR-004 | Azure Naming Standards | ✅ |
| ADR-005 | Enterprise Resource Tagging | ✅ |
| ADR-006 | Private Networking Strategy | ✅ |
| ADR-007 | Azure Bastion Strategy | ✅ |
| ADR-008 | Enterprise Networking Principles | ✅ |
| ADR-009 | Hierarchical Hub Subnet Design | ✅ |

---

# Governance Implemented

Sprint 01 introduced the following governance controls.

- Enterprise naming convention

- Standard Resource Group structure

- Enterprise resource tagging

- Standardized IP addressing

- Centralized networking foundation

- Repeatable deployment scripts

- Git version control

- Architecture documentation

- Sprint documentation

---

# Quality Assurance

The following validation activities were completed.

| Validation | Status |
|------------|--------|
| Azure CLI validation | ✅ |
| Resource Group verification | ✅ |
| Resource tagging verification | ✅ |
| Hub Virtual Network verification | ✅ |
| Hub subnet verification | ✅ |
| Azure Portal verification | ✅ |

---

# Deployment Evidence

Deployment evidence has been captured and stored within the project repository.

Evidence includes:

- Azure Portal screenshots

- Azure CLI deployment output

- Verification output

- Git commit history

- Architecture documentation

---

# Issues Encountered

During Sprint 01 several implementation issues were encountered and successfully resolved.

| Issue | Resolution |
|--------|------------|
| Bash syntax errors | Corrected script structure and control flow |
| Git repository initialization | Configured local repository and GitHub integration |
| Azure CLI validation improvements | Standardized validation across deployment scripts |
| Deployment script consistency | Established WarehousePro Azure CLI Script Standard v1.0 |

No unresolved issues remain.

---

# Lessons Learned

Sprint 01 provided several important engineering lessons.

- Build reusable deployment functions.

- Validate Azure resources before deployment.

- Maintain consistent script structure.

- Separate deployment logic from reusable functions.

- Document architecture decisions before implementation.

- Use Git commits to represent meaningful project milestones.

---

# Risks

Current project risks are considered low.

Potential future risks include:

- Azure resource quota limitations.

- Cost growth as additional services are deployed.

- Network complexity as warehouse spokes increase.

Mitigation strategies will be addressed during future sprints.

---

# Recommendations

The following recommendations are proposed.

- Continue using reusable deployment functions.

- Maintain Architecture Decision Records.

- Validate all Azure resources after deployment.

- Capture deployment evidence for every sprint.

- Continue implementing Infrastructure as Code using Azure CLI, PowerShell, and Terraform.

---

# Sprint Acceptance

Sprint 01 acceptance criteria have been satisfied.

| Deliverable | Status |
|-------------|--------|
| Documentation Complete | ✅ |
| Azure CLI Complete | ✅ |
| Azure Resources Verified | ✅ |
| Git Repository Updated | ✅ |
| Screenshots Captured | ✅ |

Sprint Status

**Accepted**

---

# Planned Scope for Sprint 02

Sprint 02 will focus on enterprise networking.

Planned deliverables include:

- Deploy Johannesburg Spoke Virtual Network

- Deploy Durban Spoke Virtual Network

- Deploy Cape Town Spoke Virtual Network

- Configure VNet Peering

- Deploy Network Security Groups

- Deploy Route Tables

- Validate End-to-End Connectivity

---

# Client Sign-off

| Role | Name | Signature | Date |
|------|------|-----------|------|
| Cloud Infrastructure Engineer | Nhlanhla M | __________ | __________ |
| Infrastructure Manager | __________________ | __________ | __________ |
| Project Sponsor (CIO) | __________________ | __________ | __________ |

---

# Conclusion

Sprint 01 successfully established the Azure Landing Zone foundation for WarehousePro Logistics.

The environment now provides a secure, standardized, and scalable networking platform capable of supporting future warehouse expansion, enterprise workloads, and cloud-native services.

The project remains on schedule and is ready to proceed with Sprint 02 – Enterprise Spoke Networking.