# ADR-001: Adopt a Hub-and-Spoke Network Topology

## Status

Approved

---

## Date

01 July 2026

---

## Decision Drivers

- Business Growth
- Security
- Scalability
- Operational Simplicity
- Governance
- Cost Optimization

---

## Decision Owners

Cloud Infrastructure Engineer - Nhlanhla M

Project Sponsor (CIO)

Infrastructure Team

---

# Context

WarehousePro Logistics is undertaking a phased migration from its on-premises datacenter to Microsoft Azure.

The business currently operates multiple warehouses distributed across South Africa, with plans to acquire additional warehouses over the next five years.

Each warehouse requires secure connectivity to Azure-hosted applications while maintaining isolation between business units and allowing centralized management of shared network services.

The proposed Azure environment must support:

- Secure connectivity between all business units
- Centralized security controls
- Future business expansion
- High availability
- Operational simplicity
- Standardized network management
- Secure remote administration

---

# Problem Statement

A decision must be made regarding the Azure network topology.

Several network models were considered, including:

- Flat Network
- Full Mesh Network
- Hub-and-Spoke Network

The selected architecture must satisfy both current business requirements and future growth without requiring major redesign.

---

# Decision

WarehousePro Logistics will adopt a Hub-and-Spoke network topology.

The Hub Virtual Network will host shared infrastructure services including:

- Azure Firewall
- VPN Gateway
- Azure Bastion
- Shared DNS services
- Shared networking services

Each major business function will receive its own Spoke Virtual Network.

Examples include:

- Identity
- Finance
- Shared Services
- Management
- Warehouse Johannesburg
- Warehouse Durban
- Warehouse Cape Town

All communication between spokes will be controlled through the Hub.

---

# Business Justification

The Hub-and-Spoke model provides several business advantages.

## Improved Security

Centralizing security appliances within the Hub enables all traffic to be inspected before reaching production workloads.

This supports the company's Zero Trust security strategy.

---

## Scalability

Future warehouse acquisitions can be onboarded by deploying a new spoke network and connecting it to the existing Hub.

No redesign of the core network architecture is required.

---

## Operational Simplicity

Shared infrastructure such as Azure Firewall, VPN Gateway, Azure Bastion, and monitoring services only need to be deployed once.

This reduces operational complexity and infrastructure costs.

---

## Network Isolation

Each business unit remains logically isolated.

Security policies can be applied independently to:

- Finance

- Identity

- Warehouses

- Shared Services

This reduces the potential impact of security incidents.

---

## Governance

Resource ownership aligns naturally with Resource Groups, RBAC assignments, and Azure Policies.

Individual teams can manage their own workloads without affecting other departments.

---

# Alternatives Considered

## Option 1 - Flat Network

### Description

Deploy all workloads inside a single Virtual Network.

### Advantages

- Easy to deploy

- Minimal configuration

### Disadvantages

- Poor scalability

- Weak security isolation

- Difficult governance

- Large blast radius during incidents

Decision:

Rejected

---

## Option 2 - Full Mesh Peering

### Description

Peer every Virtual Network directly with every other Virtual Network.

### Advantages

- Direct communication

### Disadvantages

- Complex routing

- High administrative overhead

- Difficult to scale

Decision:

Rejected

---

## Option 3 - Hub-and-Spoke

### Description

Central Hub containing shared infrastructure.

Business workloads deployed into isolated spoke networks.

### Advantages

- Highly scalable

- Centralized security

- Easier governance

- Supports business expansion

- Reduced operational overhead

Decision:

Approved

---

# Consequences

Positive Outcomes

- Centralized firewall management

- Simplified routing

- Improved security

- Easier onboarding of new warehouses

- Better RBAC implementation

- Supports future automation

Potential Trade-offs

- Slightly more complex initial deployment

- Additional routing configuration

- Firewall becomes a critical shared service

These trade-offs are considered acceptable given the long-term operational benefits.

---

# Future Considerations

As WarehousePro continues to expand, the Hub-and-Spoke architecture can support:

- ExpressRoute connectivity

- Multiple Azure regions

- Disaster Recovery sites

- Azure Virtual WAN

- Azure Firewall Premium

- Network Virtual Appliances

without significant redesign.

---

# References

Microsoft Cloud Adoption Framework

Microsoft Azure Well-Architected Framework

Azure Landing Zone Design Principles

---

## Approval

Status:

Approved

Implementation Phase:

Phase 2 – Enterprise Networking