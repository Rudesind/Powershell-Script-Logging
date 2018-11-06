# Powershell-Script-Logging

---

Module: LOG.psm1
Updated: 11/06/2018
Author: Zach Nybo
Version: 1.0

This module is used to create and write to a log file. This log file can used to document any type of process.

Use `Get-Help` to view information for a particular function.

NOTE: When creating a modular function, PowerShell prefers to use certain verbs. Use `Get-Verb` to see a list of preferred verbs.

Disclosure:
The idea for the below function was taken from the following article:
https://stackoverflow.com/questions/7834656/create-log-file-in-powershell

## Installation

```powershell
Import-Module <path>\LOG.psm1
```

## Syntax

```powershell
Initialize-Log [-File] <path> [-Name] <name>
```

```powershell
Write-Log [-LogMessage] <message>
```

## Examples

```powershell
Initialize-Log ".\" "Test_Log"

Write-Log "Logging Start"
```

## Error Codes

(-1): The script could not be initialized.
Initialize-Log - LOG_INITIALIZE_FAILED (4000): Could not initialize the log file
Write-Log - LOG_WRITE_FAILED (4000): Could not write to the log file

## References

[Usage Syntax](https://stackoverflow.com/questions/9725675/is-there-a-standard-format-for-command-line-shell-help-text)
[CmdletBinding](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_cmdletbindingattribute?view=powershell-6)
[Advanced Function Parameters](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters?view=powershell-6)
[Anatomy of a PowerShell Advanced Function](https://www.petri.com/anatomy-powershell-advanced-function)
[Script Modules](https://stackoverflow.com/questions/27138483/how-can-i-re-use-import-script-code-in-powershell-scripts)
[Powershell Scope](https://stackoverflow.com/questions/14439431/variables-in-modules-in-powershell)
