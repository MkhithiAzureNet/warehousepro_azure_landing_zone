# Lessons Learned

Sprint 02 reinforced several important engineering practices.

- Validate prerequisites before deployment.

- Build automation incrementally.

- Keep deployment scripts idempotent.

- Separate configuration from deployment logic.

- Validate infrastructure after deployment.

- Document architecture changes as they occur.

- Use Git commits to represent completed engineering milestones.

# Lessons Learned

## Sprint 03

Sprint 03 focused on designing and implementing the WarehousePro Azure Landing Zone using Azure Bicep.

Throughout the sprint, several important engineering lessons were learned while building, validating, refactoring, and documenting the infrastructure.

---

# Infrastructure Design

- Design the architecture before writing Infrastructure as Code.

- Align Bicep modules with Azure resource ownership rather than deployment convenience.

- Keep every module responsible for a single Azure resource type.

- Allow `main.bicep` to orchestrate deployments while individual modules remain reusable.

- Enterprise Infrastructure as Code should prioritize maintainability over short-term convenience.

---

# Azure Networking

- Plan Virtual Network address spaces before creating subnets.

- Use structured subnet addressing.

Example:

```
VNET-WH-JHB
10.1.0.0/16

WorkloadSubnet
10.1.1.0/24
```

- Virtual Network Peerings are bidirectional and require two peering resources.

- Child resources inherit properties from their parent resources where appropriate.

---

# Azure Bicep

- Build reusable modules instead of deployment-specific modules.

- Prefer Resource IDs over hard-coded resource names.

- Standardize module outputs across similar Azure resources.

Example:

```
output virtualNetworkId string

output virtualNetworkName string
```

- Keep module interfaces consistent to simplify orchestration.

- Separate reusable deployment logic from environment configuration.

- Store environment-specific values inside parameter files.

---

# Dependency Management

- Allow Bicep to infer dependencies through module outputs whenever possible.

- Only use `dependsOn` when an implicit dependency cannot be determined.

- Trust Bicep Linter recommendations.

During Sprint 03 unnecessary `dependsOn` statements were removed after successful validation.

---

# Module Development

Every module should follow the same lifecycle.

1. Design
2. Implement
3. Validate
4. Deploy
5. Verify
6. Document
7. Commit

Incremental delivery significantly reduced troubleshooting time.

---

# Validation

Every module should be validated before moving to the next.

Validation included:

- Visualizer validation

- Successful Azure deployment

- Azure Portal verification

- Bicep Linter review

- Documentation updates

---

# Repository Standards

- Organize modules by platform capability rather than Azure resource type.

Example:

```
modules/

foundation/

networking/

security/

monitoring/

identity/

storage/

compute/
```

- Keep documentation synchronized with implementation.

- Record architectural decisions using ADRs.

- Capture completed engineering milestones using Git.

---

# Architecture Decisions

Several architectural improvements were made during implementation.

## ADR-011

Infrastructure modules were redesigned to align with Azure resource ownership.

This resulted in:

- Smaller modules

- Improved reusability

- Simpler orchestration

- Better maintainability

---

## Standardized Module Interfaces

Initially Virtual Network modules exposed different outputs.

Example:

```
hubVirtualNetworkId

spokeVirtualNetworkId
```

These were standardized to:

```
virtualNetworkId

virtualNetworkName
```

This allows every Virtual Network module to expose the same interface regardless of its purpose.

---

## Virtual Network Peering Design

The original implementation attempted to create peerings using a subscription-scoped design.

During implementation the design was simplified.

The final architecture creates a single peering per module using Resource Group scope.

This better reflects Azure's resource model and improves module reusability.

---

# Development Workflow Improvements

Sprint 03 reinforced several engineering habits.

- Refactor when implementation reveals a cleaner architecture.

- Keep modules small and reusable.

- Remove redundant code instead of leaving technical debt.

- Treat linter warnings as opportunities to improve code quality.

- Validate each deployment before progressing.

- Trust Azure deployment results instead of assumptions.

---

# Enterprise Engineering Principles

Sprint 03 demonstrated that successful Infrastructure as Code is not simply about deploying Azure resources.

Successful Infrastructure as Code should be:

- Reusable

- Modular

- Readable

- Maintainable

- Incrementally validated

- Fully documented

- Architecture driven

---

# Sprint 03 Outcome

Sprint 03 successfully delivered:

- Azure Bicep modular architecture

- Subscription-level orchestration

- Resource Group scoped modules

- Hub-and-Spoke networking

- Hub Virtual Network

- Regional Spoke Virtual Networks

- Hub Subnets

- Workload Subnets

- Route Tables

- Virtual Network Peerings

- Network Security Groups

- Standardized module interfaces

- Architecture Decision Records

- Enterprise documentation standards

---

# Final Lesson

The most important lesson from Sprint 03 was:

> Enterprise Infrastructure as Code is not about getting a deployment to succeed once. It is about designing reusable, maintainable, well-documented infrastructure that can evolve as the platform grows.