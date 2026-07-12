# WarehousePro Azure Bicep

## Overview

This directory contains the Azure Bicep implementation of the WarehousePro Azure Landing Zone.

The objective is to deploy a complete enterprise Azure networking foundation using modular Infrastructure as Code (IaC).

The Bicep implementation follows Microsoft best practices by separating infrastructure into reusable modules orchestrated through a single deployment entry point.

---

# Architecture

```
main.prod.bicepparam
            │
            ▼
      main.bicep
            │
            ├──────────────────────────────┐
            ▼                              ▼

    Foundation                     Platform Services

            │

    Resource Groups

            │

        Networking

            │

    Hub Virtual Network

            │

      Hub Subnets

            │

    Regional Spoke VNets

            │

    Workload Subnets

            │

      Route Tables

            │

Network Security Groups

            │

      VNet Peerings
```

---

# Project Structure

```
bicep/
│
├── main.bicep
├── main.prod.bicepparam
├── README.md
│
└── modules/
    ├── foundation/
    │   └── resourceGroups.bicep
    │
    ├── networking/
    │   ├── hubVirtualNetwork.bicep
    │   ├── hubSubnets.bicep
    │   ├── spokeVirtualNetworks.bicep
    │   ├── workloadSubnets.bicep
    │   ├── routeTables.bicep
    │   └── vnetPeerings.bicep
    │
    ├── security/
    │   └── networkSecurityGroups.bicep
    │
    ├── identity/
    │
    ├── monitoring/
    │
    ├── storage/
    │
    └── compute/
```

---

# Deployment Stages

| Stage | Capability |
|--------|------------|
| Stage 1 | Foundation |
| Stage 2 | Networking |
| Stage 3 | Security |
| Stage 4 | Identity |
| Stage 5 | Monitoring |
| Stage 6 | Storage |
| Stage 7 | Compute |

---

# Current Sprint Progress

## Sprint 03

### Completed

- Resource Groups Module

- Hub Virtual Network Module

- Regional Spoke Networks

- Workload Subnets

- Route Tables

- Network Security Groups

- VNet Peerings

### In Progress

- Completed

---

# Deployment

Deploy using:

```bash
az deployment sub create \
    --location "southafricanorth" \
    --parameters main.prod.bicepparam
```

---

# Module Standards

All modules follow the WarehousePro Azure Bicep Standards.

See:

```
documentation/bicep_standards.md
```

---

# Design Principles

The implementation follows these principles:

- Modular Infrastructure as Code

- Single Responsibility Modules

- Environment Parameterization

- Enterprise Naming Standards

- Architecture-first Design

- Reusable Deployments

- Incremental Development

---

# Validation

Each module follows the same deployment lifecycle.

1. Build Bicep

2. Deploy

3. Validate

4. Capture Screenshots

5. Commit to Git

6. Update Documentation

---

# Technologies

- Azure Bicep

- Azure Resource Manager

- Azure CLI

- Microsoft Azure

---

# Author

Nhlanhla M

WarehousePro Azure Landing Zone Project

2026