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