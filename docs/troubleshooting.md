# Troubleshooting Log

---

# Issue ID

TS-004

---

# Date

12 July 2026

---

# Sprint

Sprint 04 – Azure Security

---

# Module

Network Security Rules

---

# Issue

Deployment of the `networkSecurityRules.bicep` module failed while creating the `Allow-Bastion` Network Security Rule.

Azure returned the following error:

```
SecurityRuleInvalidAddressPrefix

Value provided: AzureBastionSubnet
```

Although the deployment failed, the remaining valid security rules continued to deploy successfully.

---

# Symptoms

- Azure deployment reported a failed deployment.
- Only the `Deny-Internet` rule appeared in the Network Security Group.
- Azure Portal displayed partial deployment results.
- Azure CLI showed the successfully created rules.

---

# Investigation

The following validation steps were performed:

- Reviewed Azure deployment error details.
- Verified Network Security Group configuration in Azure Portal.
- Queried the Network Security Group using Azure CLI.

Command used:

```bash
az network nsg rule list \
    --resource-group RG-WH-JHB-Prod \
    --nsg-name NSG-WH-JHB-Prod \
    --output table
```

The Azure CLI confirmed that the successfully deployed rules were present.

---

# Root Cause

`AzureBastionSubnet` is the required subnet name used when deploying Azure Bastion.

It is **not** a valid Azure Network Security Rule source address prefix or service tag.

The Network Security Rule attempted to reference Azure Bastion before the Azure Bastion service had been deployed.

This created an architectural dependency that had not yet been satisfied.

---

# Resolution

The `Allow-Bastion` rule was temporarily removed from the deployment.

The remaining baseline security rules were redeployed successfully.

Implemented rules:

- Allow-AzureLoadBalancer
- Deny-Internet

Deployment completed successfully after removing the invalid rule.

---

# Validation

Validation completed using:

- Azure Bicep deployment output
- Azure Portal
- Azure CLI
- Network Security Group rule verification

Deployment Status:

✅ Successful

---

# Engineering Decision

Azure Bastion-specific Network Security Rules will be implemented only after Azure Bastion has been deployed.

This aligns the implementation sequence with actual Azure resource dependencies.

---

# Preventive Action

Before implementing security rules:

- Verify Azure service dependencies.
- Confirm Azure service tags and address prefixes are valid.
- Deploy dependent Azure services before creating related Network Security Rules.
- Validate Azure documentation when using Azure-reserved identifiers.

---

# References

- Microsoft Azure Network Security Groups Documentation

- Microsoft Azure Bastion Documentation

- WarehousePro Security Principles

- Sprint 04 Documentation

# Bicep Clean Subscription Deployment Troubleshooting

---

## Project

WarehousePro Azure Landing Zone

---

## Sprint

Sprint 04 – Security

---

## Troubleshooting ID

TRB-004

---

## Date

August 2026

---

## Status

Resolved

---

## Severity

Medium

---

## Technology

Azure Bicep

---

## Deployment Scope

Azure Subscription

---

# 1. Issue Summary

During Sprint 04, the WarehousePro Azure Bicep implementation was tested against a separate Azure subscription to determine whether the Infrastructure as Code implementation could deploy the environment independently.

The test exposed an architectural dependency that had not been obvious in the original Azure environment.

The Bicep deployment was able to create the required Resource Groups, but networking, security, and other child resources were not successfully deployed into those Resource Groups.

The deployment returned multiple:

`ResourceGroupNotFound`

errors.

The investigation identified that the Bicep implementation had unintentionally depended on Resource Groups and infrastructure that had previously been created using Azure PowerShell and Azure CLI.

The purpose of the clean-subscription test was therefore achieved: it exposed a weakness in the deployment orchestration.

The Bicep architecture was subsequently corrected so that the deployment can create its own Resource Groups and then deploy child resources into those Resource Groups.

The corrected implementation was successfully deployed.

---

# 2. Environment

| Item | Value |
|------|-------|
| Project | WarehousePro Azure Landing Zone |
| Sprint | Sprint 04 – Security |
| IaC Technology | Azure Bicep |
| Deployment Scope | Subscription |
| Environment | Production |
| Azure Region | South Africa North |
| Deployment Tool | Azure CLI |
| Development Environment | Visual Studio Code |
| Validation Environment | Separate / Clean Azure Subscription |

---

# 3. Objective of Testing

The objective was to determine whether the WarehousePro Bicep implementation could deploy the environment independently.

The deployment should not depend on:

- Azure PowerShell deployments
- Azure CLI deployments
- Previously created Resource Groups
- Previously created Virtual Networks
- Previously created Network Security Groups
- Previously created Route Tables
- Previously created VNet Peerings
- Any infrastructure created by another Infrastructure as Code technology

The desired architecture is:

```text
Clean Azure Subscription
        |
        v
    main.bicep
        |
        +-- Resource Groups
        |
        +-- Networking
        |
        +-- Security
        |
        +-- Monitoring
        |
        +-- Identity
        |
        +-- Governance