# Enterprise Azure Landing Zone

## Project Overview

WarehousePro Logistics is a fictional logistics and warehousing company migrating from an on-premises datacenter to Microsoft Azure.

This project demonstrates how to design, deploy, secure and manage an enterprise Azure environment using industry best practices.

The environment is built using:

- Azure Portal
- Azure CLI
- Azure PowerShell
- Terraform (later phase)

The goal is to simulate a real production deployment suitable for a medium-sized enterprise.


## Business Requirements
| ID     | Requirement                              |
| ------ | ---------------------------------------- |
| BR-001 | Migrate infrastructure to Azure          |
| BR-002 | Secure all production workloads          |
| BR-003 | Provide secure remote administration     |
| BR-004 | Support future warehouse expansion       |
| BR-005 | Centralize monitoring and logging        |
| BR-006 | Implement disaster recovery capabilities |
| BR-007 | Minimize operational costs               |
| BR-008 | Use least-privilege access               |



## Tagging Standard
| Tag          | Example        |
| ------------ | -------------- |
| Environment  | Production     |
| Project      | WarehousePro   |
| Owner        | Cloud Team     |
| Department   | IT             |
| CostCenter   | Infrastructure |
| ManagedBy    | AzureCLI       |
| BusinessUnit | Logistics      |

## Resource Group Strategy
Instead of putting everything into one RG, I have organized by responsibilty.
It helps with RBAC.
| Resource Group         | Purpose                               |
| ---------------------- | ------------------------------------- |
| RG-Networking-Prod     | VNets, Firewall, Bastion, VPN         |
| RG-Identity-Prod       | Domain Controllers, DNS               |
| RG-Production-Prod     | Warehouse Applications                |
| RG-Finance-Prod        | Finance Applications                  |
| RG-Management-Prod     | Jump Box, Automation                  |
| RG-Monitoring-Prod     | Log Analytics, Monitor, Alerts        |
| RG-SharedServices-Prod | Storage, Key Vault, Recovery Services |
