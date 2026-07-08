# WarehousePro Azure Bicep Standards

Version: 1.0

Author: Nhlanhla M

---

# Purpose

This document defines the Azure Bicep development standards used throughout the WarehousePro Azure Landing Zone project.

The objective is to ensure all Infrastructure as Code modules are:

- Consistent
- Reusable
- Readable
- Maintainable
- Enterprise-ready

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
    ├── networking/
    ├── security/
    ├── identity/
    ├── monitoring/
    ├── storage/
    └── compute/
```

---

# Module Layout

Every Bicep module must follow the same structure.

```
Header

Target Scope

Module Information

Parameters

Variables

Existing Resources

Resources

Outputs
```

The main deployment file replaces the Resources section with Deployment Stages.

---

# Project Header Standard

Every module must include:

- Project
- Sprint
- Module
- Version
- Author
- Description

---

# Module Information Standard

Every module must include:

- Scope
- Depends On
- Deploys
- Returns

Example:

```
Scope      : Subscription
Depends On : None
Deploys    : Resource Groups
Returns    : Resource Group Names
```

---

# Naming Standards

## Parameters

Use camelCase.

Example:

- location
- environment
- addressPrefix

---

## Variables

Variables containing collections should end with "Names".

Example:

- resourceGroupNames
- subnetNames
- routeTableNames

---

## Resources

Resource names should use plural nouns.

Example:

- resourceGroups
- virtualNetworks
- subnets
- networkSecurityGroups

---

## Outputs

Outputs should clearly describe the returned value.

Example:

- deployedResourceGroups
- hubVirtualNetworkId
- subnetIds

---

# Deployment Stages

The main deployment file uses the following stages.

Stage 1 – Foundation

Stage 2 – Networking

Stage 3 – Security

Stage 4 – Identity

Stage 5 – Monitoring

Stage 6 – Storage

Stage 7 – Compute

---

# Parameter Files

Environment configuration must be separated from deployment logic.

Example:

- main.dev.bicepparam
- main.test.bicepparam
- main.prod.bicepparam

---

# Module Design Principles

Every module should:

- Perform a single responsibility.

- Accept parameters instead of hard-coded values.

- Return outputs where appropriate.

- Be reusable across multiple environments.

- Follow enterprise naming conventions.

---

## Module Granularity

Modules should deploy a single logical resource or capability.

Avoid designing modules that deploy multiple independent resources when orchestration can be performed by `main.bicep`.

This improves:

- Reusability
- Maintainability
- Scalability
- Testing
- Deployment flexibility

---

## Configuration Ownership

Business-specific configuration should remain in the orchestration layer (`main.bicep` or parameter files).

Reusable modules should accept parameters rather than hard-coded values.

This keeps modules generic and reusable across multiple environments and projects.

---

# Documentation

Every module should contain sufficient comments to explain:

- Purpose

- Dependencies

- Outputs

- Scope

---

# Repository Principles

WarehousePro follows an architecture-first approach.

Infrastructure is organised into logical platform capabilities rather than individual Azure resources.

The solution is designed to support future expansion using Azure Bicep, Terraform, Azure DevOps, and enterprise landing zone practices.

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | July 2026 | Initial WarehousePro Azure Bicep Standards |

---

# Output Design Standards

Outputs should only expose information that is useful to other modules or deployment reporting.

## Guidelines

- Return Resource IDs when another module references the resource.
- Return Resource Names when useful for validation or reporting.
- Keep output names descriptive.
- Do not expose unnecessary implementation details.

Example:

```
output hubVirtualNetworkId string = hubVirtualNetwork.id

output hubVirtualNetworkName string = hubVirtualNetwork.name
```

---

# Deployment Validation Standards

Every module must satisfy the following before being committed.

- No Bicep syntax errors.
- Bicep Build completes successfully.
- Azure deployment completes successfully.
- Resources verified in Azure Portal.
- Deployment committed to Git.

---

# Module Delivery Workflow

Every Bicep module follows the same delivery lifecycle.

1. Design
2. Implement
3. Build
4. Deploy
5. Validate
6. Capture deployment evidence
7. Update documentation
8. Commit to Git

This incremental approach minimizes deployment risk and simplifies troubleshooting by validating each module before progressing to the next.