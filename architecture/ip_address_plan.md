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