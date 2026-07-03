# ADR-002: Adopt Dedicated Spoke Virtual Networks for Each Warehouse

## Status

Approved

---

## Date

01 July 2026

---

## Decision Drivers

- Business Expansion
- Security
- Operational Isolation
- Governance
- Scalability
- Disaster Recovery
- Least Privilege
- Business Continuity

---

## Decision Owners

Cloud Infrastructure Engineer - Nhlanhla M

Chief Information Officer

Infrastructure Team

---

# Context

WarehousePro Logistics currently operates multiple warehouse facilities across South Africa, with additional warehouse acquisitions planned over the next five years.

Each warehouse operates semi-independently with local management, warehouse supervisors, inventory systems and operational staff.

Although all warehouses connect to the same enterprise applications, each location represents its own operational boundary.

The Azure network architecture must support:

- Secure warehouse isolation
- Independent administration
- Future warehouse acquisitions
- Standardized deployment
- Simplified troubleshooting
- Controlled communication between business units

A decision was required regarding how warehouse networking should be designed within Azure.

---

# Problem Statement

Two primary architectural options were considered.

Option A

Deploy every warehouse into a single Warehouse Virtual Network.

Option B

Deploy each warehouse into its own dedicated spoke Virtual Network connected to the Hub.

The chosen design must remain scalable for future business growth while reducing operational complexity.

---

# Decision

WarehousePro Logistics will deploy each warehouse into its own dedicated spoke Virtual Network.

Each warehouse will receive:

- Dedicated Resource Group
- Dedicated Virtual Network
- Dedicated Subnets
- Independent NSGs
- Independent Route Tables
- Independent Monitoring
- Independent RBAC Assignments

All warehouse spoke networks will connect only to the Hub Network through Virtual Network Peering.

Communication between warehouses will not be allowed unless explicitly required by business applications.

---

# Business Justification

## Security Isolation

Each warehouse represents a separate security boundary.

If one warehouse experiences a cyber security incident, workloads in other warehouses remain isolated.

This significantly reduces the potential blast radius of an attack.

---

## Operational Ownership

Each warehouse can be administered independently.

Future regional IT teams can be granted access only to the resources supporting their assigned warehouse.

This aligns with the principle of least privilege.

---

## Scalability

The company plans to acquire additional warehouse facilities.

Using dedicated spoke networks allows new warehouses to be onboarded by repeating an existing deployment pattern without redesigning the network architecture.

This supports long-term business expansion.

---

## Governance

Each warehouse can have:

- Separate Azure Policies
- Separate RBAC assignments
- Separate Cost Management
- Separate Resource Locks
- Separate Monitoring

Governance becomes significantly easier as the organization grows.

---

## Standardization

Every warehouse follows the same architecture.

Example:

VNET-WH-JHB-Prod

↓

VNET-WH-DBN-Prod

↓

VNET-WH-CPT-Prod

↓

VNET-WH-BFN-Prod

↓

Future Warehouse...

Infrastructure becomes predictable and repeatable.

---

## Disaster Recovery

Recovering or rebuilding a warehouse environment becomes simpler because each warehouse is logically independent.

Recovery operations affect only the impacted warehouse instead of the entire organization.

---

# Alternatives Considered

## Option 1 – Shared Warehouse Virtual Network

### Description

Deploy every warehouse into a single large Virtual Network.

### Advantages

- Simpler initial deployment
- Fewer Virtual Networks
- Lower administrative overhead during early deployment

### Disadvantages

- Large security blast radius
- Difficult RBAC delegation
- More complex NSG management
- Harder troubleshooting
- Difficult future expansion
- Limited governance flexibility

Decision:

Rejected

---

## Option 2 – Dedicated Warehouse Spokes

### Description

Deploy each warehouse into its own spoke Virtual Network.

### Advantages

- Strong security isolation
- Simplified governance
- Easier RBAC implementation
- Predictable architecture
- Supports acquisitions
- Easier troubleshooting
- Standardized deployments
- Better disaster recovery planning

### Disadvantages

- Slightly higher deployment complexity
- Additional Virtual Network Peerings
- More Route Tables
- More NSGs to manage

Decision:

Approved

---

# Consequences

Positive Outcomes

- Supports long-term business growth
- Enables independent warehouse management
- Improves security posture
- Simplifies troubleshooting
- Aligns with Azure Landing Zone design principles
- Supports future Infrastructure as Code deployments

Trade-offs

- Increased number of Azure resources
- Additional network planning required
- Slightly more operational documentation

These trade-offs are considered acceptable when compared to the long-term operational benefits.

---

# Future Considerations

The dedicated spoke architecture supports future implementation of:

- Azure Virtual WAN
- ExpressRoute
- Regional warehouse subscriptions
- Multi-region deployments
- Azure Policy initiatives
- Landing Zones
- Subscription segmentation by business unit

without requiring redesign of the enterprise network.

---

# References

Microsoft Cloud Adoption Framework

Azure Enterprise Landing Zones

Azure Well-Architected Framework

Azure Virtual Network Design Best Practices

---

# Approval

Status

Approved

Implementation Phase

Phase 2 – Enterprise Networking