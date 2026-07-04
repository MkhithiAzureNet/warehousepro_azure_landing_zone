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