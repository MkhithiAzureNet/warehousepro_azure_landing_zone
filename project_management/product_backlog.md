# Product Backlog

## PB-001 – Standardize PowerShell Counter Scope

### Priority
Medium

### Sprint
Future Sprint (Technical Debt)

### Description

During development of the PowerShell deployment framework, deployment counters (Successful, Failed, Skipped) were observed not to increment correctly inside deployment functions.

The deployment logic functions correctly, however the counters require investigation to determine whether PowerShell variable scoping (`$script:`) should be used across the framework.

### Impact

- Deployment succeeds successfully.
- Summary statistics may report incorrect values.
- No impact to Azure resources.

### Proposed Solution

Investigate PowerShell variable scope.

Potential implementation:

```powershell
$script:Successful++
$script:Skipped++
$script:Failed++
```

Standardize the chosen approach across all WarehousePro PowerShell deployment scripts.

### Acceptance Criteria

- Successful deployments increment correctly.
- Skipped deployments increment correctly.
- Failed deployments increment correctly.
- Deployment summary reflects actual execution results.
- Solution applied consistently across all PowerShell scripts.

### PB-002

Title:
Correct deployment counters in PowerShell automation

Priority:
Low

Description:
Scripts currently increment deployment counters inconsistently due to PowerShell variable scope inside functions.

Affected Scripts:
- 07_vnet_peering.ps1
- 08_network_security_groups.ps1
- 09_route_tables.ps1

Proposed Resolution:
Refactor deployment scripts to use script-scoped variables or return status objects instead of incrementing local variables.

Status:
Open