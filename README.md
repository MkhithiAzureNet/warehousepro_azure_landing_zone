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

## Naming Standard
<ResourceType>-<BusinessUnit>-<Environment>-<Number>
| Resource        | Name               |
| --------------- | ------------------ |
| Resource Group  | RG-Networking-Prod |
| Resource Group  | RG-Warehouse-Prod  |
| Virtual Network | VNET-Hub-Prod      |
| VM              | VM-DC01            |
| VM              | VM-WEB01           |
| Firewall        | FW-Hub-Prod        |
| Bastion         | BAS-Hub-Prod       |
| Key Vault       | KV-Warehouse-Prod  |
| Log Analytics   | LAW-Prod           |
| Recovery Vault  | RSV-Prod           |

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

## IP Address Plan
| VNet            | Address Space |
| --------------- | ------------- |
| Hub             | 10.0.0.0/16   |
| Identity        | 10.1.0.0/16   |
| Warehouse       | 10.2.0.0/16   |
| Finance         | 10.3.0.0/16   |
| Management      | 10.4.0.0/16   |
| Shared Services | 10.5.0.0/16   |

For the Hub:
| Subnet              | Network      |
| ------------------- | ------------ |
| AzureFirewallSubnet | 10.0.1.0/24  |
| AzureBastionSubnet  | 10.0.2.0/24  |
| GatewaySubnet       | 10.0.3.0/24  |
| Shared Services     | 10.0.10.0/24 |

## Security Principles
For this project:

* No production VM receives a public IP.
* All internet traffic is inspected by Azure Firewall.
* Administrators use Azure Bastion.
* Secrets are stored in Azure Key Vault.
* Least privilege RBAC.
* All storage uses Private Endpoints.
* Monitoring enabled on every critical resource.
* Diagnostic logs sent to Log Analytics.
* NSGs follow a default-deny approach.