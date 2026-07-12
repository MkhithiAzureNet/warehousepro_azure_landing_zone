## Status

Approved

---

## Date

11 July 2026

---

## Decision Drivers

- Infrastructure as Code
- Maintainability
- Simplicity
- Azure Best Practices
- Scalability
- Reusability

---

## Decision Owners

Cloud Infrastructure Engineer - Nhlanhla M

Project Sponsor (CIO)

Infrastructure Team

---

# Context

During Sprint 03, WarehousePro Logistics transitioned its Azure infrastructure from Azure PowerShell deployment scripts to Azure Bicep Infrastructure as Code.

The initial Bicep implementation closely mirrored the Azure PowerShell deployment process by treating Route Table Associations and Network Security Group Associations as independent deployment modules.

As implementation progressed, it became evident that Azure Resource Manager models subnet associations differently. Route Tables and Network Security Groups are not independent child resources of a Virtual Network but are configuration properties owned by the subnet resource itself.

Attempting to deploy subnet associations as separate Bicep modules resulted in duplicate subnet definitions and conflicts with Azure Resource Manager's declarative resource model.

The Bicep architecture therefore required refinement to better align with Azure resource ownership.

---

# Problem Statement

A decision must be made regarding how Azure Bicep modules should be organized.

Two approaches were considered:

- Design modules around deployment tasks.
- Design modules around Azure resource ownership.

The selected approach must promote reusable Infrastructure as Code while remaining aligned with Azure Resource Manager and Azure Bicep best practices.

---

# Decision

WarehousePro Logistics will align Azure Bicep module boundaries with Azure resource ownership.

Each Azure resource will have a single owning module responsible for its complete lifecycle.

The resulting module ownership is:

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

The Workload Subnets module becomes the sole owner of subnet configuration including:

- Address Prefix

- Route Table Association

- Network Security Group Association

- Service Endpoints

- Delegations

- Private Endpoint Policies

Separate Route Table Association and Network Security Group Association modules will not be implemented.

---

# Business Justification

Designing modules around Azure resource ownership provides several long-term benefits.

## Improved Maintainability

Each Azure resource is managed by a single module, eliminating duplicated resource definitions and simplifying future enhancements.

---

## Improved Reusability

Modules become independent building blocks that can be reused across multiple projects and environments.

---

## Reduced Complexity

Infrastructure orchestration becomes simpler because configuration remains within the owning resource instead of being distributed across multiple modules.

---

## Azure Best Practice Alignment

The architecture aligns with Azure Resource Manager's declarative deployment model and Microsoft Azure Bicep design guidance.

---

## Future Scalability

Additional subnet capabilities can be introduced without redesigning the module structure.

Future enhancements include:

- Service Endpoints

- Private Endpoint Policies

- Delegations

- NAT Gateway integration

---

# Alternatives Considered

## Option 1 - Deployment Task Based Modules

### Description

Create separate modules for Route Table Associations and Network Security Group Associations.

### Advantages

- Similar structure to Azure PowerShell deployments.

- Easy transition from imperative scripts.

### Disadvantages

- Duplicate subnet definitions.

- Conflicts with Azure Resource Manager.

- Increased deployment complexity.

- Reduced maintainability.

Decision:

Rejected

---

## Option 2 - Azure Resource Ownership

### Description

Allow each Azure resource to own all of its associated configuration.

### Advantages

- Cleaner architecture.

- Single ownership model.

- Better alignment with Azure Resource Manager.

- Improved maintainability.

- Greater module reuse.

Decision:

Approved

---

# Consequences

Positive Outcomes

- Simplified module architecture.

- Elimination of duplicate subnet resources.

- Reduced deployment complexity.

- Cleaner orchestration.

- Improved scalability.

- Better alignment with Azure best practices.

Potential Trade-offs

- Workload Subnets module becomes responsible for additional subnet configuration.

This trade-off is considered acceptable because subnet configuration naturally belongs to the subnet resource.

---

# Future Considerations

Future subnet enhancements can be implemented within the Workload Subnets module without requiring architectural redesign.

Potential future capabilities include:

- Azure Firewall integration

- NAT Gateway

- Private Endpoints

- Service Endpoints

- Delegated Subnets

- Network Intent Policies

---

# References

Microsoft Azure Bicep Documentation

Microsoft Azure Resource Manager Documentation

Microsoft Cloud Adoption Framework

Azure Well-Architected Framework

WarehousePro Azure Bicep Standards

---

## Approval

Status:

Approved

Implementation Phase:

Phase 3 – Azure Bicep Infrastructure as Code