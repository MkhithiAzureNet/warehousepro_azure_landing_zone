# ADR-011 – Align Bicep Module Boundaries with Azure Resource Ownership

**Status:** Accepted

**Date:** July 2026

**Decision Makers:** Nhlanhla M

---

# Context

During Sprint 03, the WarehousePro Azure Bicep implementation initially followed the same architecture as the Azure PowerShell implementation.

The networking layer was designed as:

- Workload Subnets
- Route Tables
- Route Table Associations
- Network Security Groups
- NSG Associations

This mirrored the imperative deployment workflow used in PowerShell.

While implementing `routeTableAssociations.bicep`, it became apparent that Azure Bicep models subnet configuration differently.

Azure Resource Manager considers Route Tables and Network Security Groups to be properties of a subnet rather than independent child resources.

Attempting to manage subnet associations as separate Bicep resources resulted in duplicate resource definitions and conflicted with Azure Resource Manager's declarative resource model.

---

# Decision

WarehousePro will align its Bicep module boundaries with Azure Resource ownership.

The following modules remain independent resources:

- Resource Groups
- Virtual Networks
- Route Tables
- Network Security Groups

Subnet configuration will be owned entirely by the Workload Subnets module.

The Workload Subnets module will become responsible for:

- Address Prefix
- Route Table Association
- Network Security Group Association
- Future Service Endpoints
- Future Delegations
- Future Private Endpoint Policies

Separate Route Table Association and NSG Association modules will not be implemented.

---

# Rationale

This design follows Azure Resource Manager's resource ownership model.

Benefits include:

- Single ownership of subnet configuration
- Elimination of duplicate subnet definitions
- Simpler module boundaries
- Reduced deployment complexity
- Better alignment with declarative Infrastructure as Code principles
- Improved maintainability
- Easier future enhancements

Each Azure resource has exactly one owning module.

---

# Consequences

## Positive

- Cleaner architecture
- Simpler deployment orchestration
- Reduced code duplication
- Easier maintenance
- Better scalability
- Better alignment with Azure best practices

## Negative

The Workload Subnets module becomes responsible for additional subnet configuration.

This is considered acceptable because Route Tables and Network Security Groups are intrinsic subnet properties.

---

# Updated Module Responsibilities

## Foundation

- Resource Groups

## Networking

- Hub Virtual Network
- Hub Subnets
- Spoke Virtual Networks
- Workload Subnets
- Route Tables
- Virtual Network Peerings

## Security

- Network Security Groups

---

# Alternatives Considered

## Option 1

Maintain separate Route Table Association and NSG Association modules.

**Rejected**

Reason:

Azure Resource Manager does not treat subnet associations as independent resources.

This approach introduced duplicate subnet definitions and conflicted with Bicep's declarative resource model.

---

## Option 2

Manage all subnet configuration within the Workload Subnets module.

**Accepted**

Reason:

This aligns module ownership with Azure resource ownership while maintaining a clean, reusable architecture.

---

# Impact

This decision changes the WarehousePro Azure Bicep architecture but does not affect the Azure CLI or Azure PowerShell implementations.

The Bicep implementation is intentionally optimized for declarative Infrastructure as Code rather than mirroring imperative deployment scripts.

---

# Related Documents

- ADR-001 – Architecture First Development
- ADR-003 – Modular Infrastructure Design
- WarehousePro Azure Bicep Standards
- Sprint 03 Roadmap