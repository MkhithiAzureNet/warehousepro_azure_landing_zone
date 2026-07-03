# ADR-010: Adopt a Standardized Enterprise Virtual Network Addressing Strategy

## Status

Approved

---

## Date

03 July 2026

---

## Decision Drivers

- Enterprise Network Standardization
- Business Growth
- Scalability
- Network Isolation
- Predictable Routing
- Future Expansion

---

## Decision Owners

Cloud Infrastructure Engineer - Nhlanhla M

Project Sponsor (CIO)

Infrastructure Team

---

# Context

WarehousePro Logistics has successfully established its Azure Landing Zone foundation using a centralized Hub Virtual Network.

The next phase of the cloud migration requires each warehouse location to receive its own dedicated Virtual Network connected to the Hub using Azure Virtual Network Peering.

The business intends to expand operations into additional South African regions over the coming years while maintaining a consistent network architecture.

A standardized IP addressing strategy is therefore required to ensure that future expansion can occur without network redesign or IP address conflicts.

---

# Problem Statement

A decision must be made regarding how Virtual Network address spaces will be allocated across WarehousePro's Azure environment.

Several addressing strategies were considered.

The selected strategy must:

- Prevent overlapping address spaces

- Support future warehouse expansion

- Simplify routing

- Improve documentation

- Align with Microsoft Azure networking best practices

---

# Decision

WarehousePro Logistics will adopt a hierarchical enterprise IP addressing strategy.

Each regional site will receive its own dedicated /16 Virtual Network.

The following address allocation has been approved.

| Site | Virtual Network | Address Space | Status |
|------|-----------------|---------------|--------|
| Hub | VNET-Hub-Prod | 10.0.0.0/16 | Active |
| Johannesburg | VNET-WH-JHB-Prod | 10.1.0.0/16 | Active |
| Durban | VNET-WH-DBN-Prod | 10.2.0.0/16 | Active |
| Cape Town | VNET-WH-CPT-Prod | 10.3.0.0/16 | Active |
| Bloemfontein | Reserved | 10.4.0.0/16 | Reserved |
| Gqeberha | Reserved | 10.5.0.0/16 | Reserved |
| Pretoria | Reserved | 10.6.0.0/16 | Reserved |
| Richards Bay | Reserved | 10.7.0.0/16 | Reserved |
| East London| Reserved | 10.8.0.0/16 | Reserved |
| Camps Bay | Reserved | 10.9.0.0/16 | Reserved |

No Virtual Networks may be deployed outside this addressing standard without an approved Architecture Decision Record.

---

# Business Justification

The standardized addressing strategy provides several business advantages.

## Scalability

New warehouse locations can be deployed without redesigning the Azure network.

Reserved address ranges support future acquisitions and regional expansion.

---

## Simplified Routing

Predictable addressing simplifies route management, VNet Peering, Azure Firewall configuration, and future hybrid connectivity.

---

## Improved Troubleshooting

Engineers can immediately identify a site's location based on its IP range.

This improves operational efficiency and reduces troubleshooting time.

---

## Governance

Standardized IP allocation ensures consistency across all environments and simplifies infrastructure documentation.

---

## Disaster Recovery

Reserved address ranges provide flexibility for future Disaster Recovery regions and secondary Azure deployments.

---

# Alternatives Considered

## Option 1 – Random Address Allocation

### Description

Assign IP ranges as new Virtual Networks are created.

### Advantages

- Minimal planning

### Disadvantages

- High risk of overlapping address spaces

- Difficult documentation

- Poor scalability

- Increased operational complexity

Decision:

Rejected

---

## Option 2 – Small Address Spaces

### Description

Allocate /24 or /20 address spaces to each Virtual Network.

### Advantages

- Conserves private IP space

### Disadvantages

- Limited future growth

- Possible network redesign

- Reduced flexibility

Decision:

Rejected

---

## Option 3 – Standardized /16 Regional Allocation

### Description

Allocate one dedicated /16 Virtual Network to each regional site using a structured enterprise addressing model.

### Advantages

- Highly scalable

- Predictable routing

- Easier documentation

- Supports business growth

- Simplifies network management

Decision:

Approved

---

# Consequences

Positive Outcomes

- Predictable enterprise IP addressing

- Simplified Azure networking

- Easier VNet Peering

- Improved operational consistency

- Supports future automation

- Supports regional expansion

Potential Trade-offs

- Larger IP ranges allocated initially

- Some address space remains unused during early deployment

These trade-offs are acceptable because they significantly reduce future operational complexity.

---

# Future Considerations

The addressing strategy supports future implementation of:

- ExpressRoute

- Azure Virtual WAN

- Azure Route Server

- Multi-region deployments

- Regional Disaster Recovery

- International warehouse expansion

without requiring changes to the existing IP addressing model.

---

# References

Microsoft Cloud Adoption Framework

Microsoft Azure Well-Architected Framework

Azure Virtual Network Design Best Practices

Azure Landing Zone Design Principles

---

## Approval

Status:

Approved

Implementation Phase:

Phase 3 – Regional Virtual Networks