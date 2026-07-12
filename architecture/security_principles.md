## Security Principles
For this project:

* No production VM receives a public IP.
* All internet traffic is inspected by Azure Firewall.
* Administrators use Azure Bastion.
* RDP (3389) and SSH (22) are never exposed directly to the Internet.
* Secrets are stored in Azure Key Vault.
* Least privilege RBAC is applied to every identity.
* All storage uses Private Endpoints.
* Monitoring enabled on every critical resource.
* Diagnostic logs sent to Log Analytics.
* NSGs follow a default-deny approach.
* East-West traffic between spoke networks is denied by default.