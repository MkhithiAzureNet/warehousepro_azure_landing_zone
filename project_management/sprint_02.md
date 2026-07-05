# Sprint Design Decisions

| ID | Decision | Reason |
|----|----------|--------|
| SD-005 | Deploy regional Spoke Virtual Networks | Isolates warehouse workloads from the Hub |
| SD-006 | Use Hub-and-Spoke topology | Enables centralized connectivity and security |
| SD-007 | Implement VNet Peering using Azure PowerShell | Azure PowerShell provides reliable VNet peering automation |
| SD-008 | Separate networking components into individual deployment scripts | Improves maintainability and reusability |
| SD-009 | Validate Azure resources before deployment | Prevents deployment failures and duplicate resources |
| SD-010 | Standardize deployment summaries across scripts | Provides consistent operational reporting |

---

## Sprint Overview

Sprint 02 expands the Azure Landing Zone by deploying the regional warehouse networking infrastructure.

This sprint introduces enterprise Hub-and-Spoke networking by deploying regional Virtual Networks, establishing secure VNet Peerings, and preparing the environment for network security and routing.

The networking foundation created during this sprint enables secure communication between the Hub and all WarehousePro regional sites while maintaining a scalable architecture suitable for future growth.

---

# Sprint 02

## Sprint Goal

Deploy Enterprise Hub-and-Spoke Networking.

---

## User Stories

### US-006

As a Cloud Infrastructure Engineer,

I want dedicated Spoke Virtual Networks

so each warehouse location is logically isolated while remaining connected to the enterprise Hub.

```
Warehouse Network

JHB
10.1.0.0/16

DBN
10.2.0.0/16

CPT
10.3.0.0/16
```

---

### US-007

As a Network Engineer,

I want secure Hub-and-Spoke VNet Peerings

so regional warehouses can communicate with centralized services.

---

### US-008

As a Security Administrator,

I want Network Security Groups

so network traffic can be controlled using enterprise security policies.

---

### US-009

As a Network Engineer,

I want Route Tables

so traffic follows enterprise routing standards.

---

### US-010

As a Cloud Infrastructure Engineer,

I want deployment validation

so networking resources are verified after deployment.

---

### US-011

As a Solutions Architect,

I want the Hub-and-Spoke architecture documented

so future engineers understand the enterprise network design.

```
             Azure Hub
          VNET-Hub-Prod
          10.0.0.0/16
                |
    -------------------------
    |          |           |
    |          |           |
 JHB        DBN         CPT
10.1/16   10.2/16    10.3/16
```
---

## Tasks

- Deploy Regional Spoke Virtual Networks

- Configure Hub and Spoke VNet Peerings

- Deploy Network Security Groups

- Deploy Route Tables

- Associate Route Tables

- Validate Enterprise Networking

- Update GitHub Repository

---

## Acceptance Criteria

✔ Regional Virtual Networks created

✔ Hub-and-Spoke Peerings configured

✔ Network Security Groups deployed

✔ Route Tables deployed

✔ Spoke Subnets deployed

✔ Route Tables associated

✔ Connectivity validated

✔ Documentation updated

---

## Definition of Done

- Azure CLI deployment completed

- Azure PowerShell deployment completed

- Networking validated

- Documentation committed

- Screenshots captured

- README updated

- GitHub repository updated