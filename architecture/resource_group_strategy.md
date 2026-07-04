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