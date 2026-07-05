# Sprint Design Decisions

| ID | Decision | Reason |
|----|----------|--------|
| SD-005 | Use Azure Bicep as the primary Infrastructure as Code language | Aligns with Microsoft best practices |
| SD-006 | Develop reusable Bicep modules | Encourages modular and maintainable deployments |
| SD-007 | Parameterize all deployments | Supports Dev, Test and Production environments |
| SD-008 | Separate orchestration from resource modules | Simplifies maintenance and scalability |
| SD-009 | Maintain compatibility with existing Azure PowerShell deployment | Enables technology comparison and validation |

---

## Sprint Overview

Sprint 03 focuses on modernizing the WarehousePro Azure Landing Zone by implementing Infrastructure as Code using Azure Bicep.

The networking architecture deployed during Sprint 02 will be recreated using reusable, parameterized Bicep modules while maintaining the same enterprise design principles.

The outcome of Sprint 03 will be a fully modular Azure Bicep solution capable of deploying the complete networking foundation through a single orchestrated deployment.

---

# Sprint 03

## Sprint Goal

Implement the WarehousePro Azure Landing Zone using modular Azure Bicep templates.

---

## User Stories

### US-013

As a Cloud Infrastructure Engineer,

I want reusable Bicep modules

so that Azure resources can be deployed consistently across multiple environments.

---

### US-014

As a Cloud Infrastructure Engineer,

I want parameterized deployments

so that Dev, Test and Production environments can share the same Infrastructure as Code.

---

### US-015

As a Cloud Infrastructure Engineer,

I want a centralized deployment template

so that the complete Azure Landing Zone can be deployed from a single entry point.

---

### US-016

As a Cloud Infrastructure Engineer,

I want modular networking components

so that networking resources can be maintained independently.

---

### US-017

As a Cloud Infrastructure Engineer,

I want deployment validation

so that Infrastructure as Code deployments can be verified automatically.

---

## Tasks

- Create Bicep project structure

- Create Resource Group module

- Create Hub Virtual Network module

- Create Hub Subnets module

- Create Regional Spoke Network module

- Create Workload Subnet module

- Create Network Security Group module

- Create Route Table module

- Create VNet Peering module

- Create Main deployment template

- Create parameter file

- Validate Bicep deployment

- Update GitHub

---

## Acceptance Criteria

✔ Modular Bicep project created

✔ Resource Group module deployed

✔ Hub Network module deployed

✔ Hub Subnets module deployed

✔ Regional Spoke Network module deployed

✔ Workload Subnet module deployed

✔ Network Security Group module deployed

✔ Route Table module deployed

✔ VNet Peering module deployed

✔ Main deployment executed successfully

✔ Azure Bicep deployment validated

✔ Documentation updated

---

## Definition of Done

- Modular Azure Bicep solution complete

- Infrastructure deployed successfully

- Validation completed

- Documentation committed

- Screenshots captured

- README updated

- Git repository updated