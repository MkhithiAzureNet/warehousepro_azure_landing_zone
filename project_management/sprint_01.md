## Sprint Design Decisions

| ID | Decision | Reason |
|----|----------|--------|
| SD-001 | Deploy Resource Groups by business capability | Simplifies lifecycle management |
| SD-002 | Use enterprise naming standard | Improves consistency |
| SD-003 | Apply mandatory tags | Supports governance and cost reporting |
| SD-004 | Deploy Hub VNet first | Shared networking must exist before workloads |

---

## Sprint Overview

Sprint 1 establishes the Azure Landing Zone foundation for WarehousePro Logistics.

This sprint focuses on governance, networking and standardization.

No production workloads will be deployed during this sprint.

The outcome of Sprint 1 is a secure, repeatable Azure foundation capable of supporting future enterprise services.

---

# Sprint 01

## Sprint Goal

Deploy the Azure Landing Zone Foundation.

---

## User Stories

### US-001

As a Cloud Infrastructure Engineer,

I want standardized Resource Groups

so that resources are organized consistently.

WarehousePro Azure Subscription
│
├── RG-Networking-Prod
│
├── RG-Identity-Prod
│
├── RG-Management-Prod
│
├── RG-Monitoring-Prod
│
├── RG-SharedServices-Prod
│
├── RG-WH-JHB-Prod
│
├── RG-WH-Durban-Prod
│
├── RG-WH-CPT-Prod
│
├── RG-WH-BFN-Prod
│
└── RG-WH-PLK-Prod 

---

### US-002

As a Cloud Infrastructure Engineer,

I want enterprise tagging

so Azure resources can be governed and tracked.

---

### US-003

As a Cloud Infrastructure Engineer,

I want a Hub Virtual Network

so shared networking services have a secure central location.

---

### US-004

As a Security Administrator,

I want standardized subnet allocation

so future Azure services can be deployed consistently.

---

## Tasks

- Create Resource Groups

- Apply Tags

- Deploy Hub VNet

- Deploy Hub Subnets

- Validate deployment

- Update GitHub

---

## Acceptance Criteria

✔ Resource Groups created

✔ Tags applied

✔ Hub deployed

✔ Subnets created

✔ Documentation updated

---

## Definition of Done

- Azure CLI complete

- PowerShell complete

- Documentation committed

- Screenshots captured

- README updated