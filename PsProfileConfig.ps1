<#
.SYNOPSIS
    This script configures the PowerShell profile with shell enhancements

.DESCRIPTION
    This is a powershell profile script. It imports and runs
    - Terminal-Icons
    - Oh-My-Posh
    - Posh-git
    
.EXAMPLE
    . $HOME\Documents\PsProfileConfig.ps1
    This example shows how to source this script from your PowerShell profile.

.NOTES
    This script should be placed in $HOME\Documents and dot sourced from the PowerShell profile script.
#>


$ThemeName = "bluecloud"

function Import-ModuleWithCheck {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ModuleName
    )

    try {
        if (Get-Module -ListAvailable -Name $ModuleName) {
            Import-Module $ModuleName -ErrorAction Stop
        } else {
            Write-Error "Module '$ModuleName' not found. Please install it first."
        }
    } catch {
        Write-Error "An error occurred while importing module '$ModuleName': $_"
    }
}

function Initialize-OhMyPosh {
    try {
        $ThemePath = "$env:POSH_THEMES_PATH\CustomThemes\$ThemeName.omp.yaml"
        if (Test-Path $ThemePath) {
            oh-my-posh init pwsh --config $ThemePath | Invoke-Expression
        } else {
            Write-Warning "Oh-My-Posh theme not found at '$ThemePath', using default."
            oh-my-posh init pwsh | Invoke-Expression
        }
    } catch {
        Write-Error "An error occurred while initializing Oh-My-Posh: $_"
    }
}

# Main script execution
try {
    Import-ModuleWithCheck -ModuleName "posh-git"
    Import-ModuleWithCheck -ModuleName "Terminal-Icons"

    Initialize-OhMyPosh

    $env:POSH_GIT_ENABLED = "false"
    $env:POSH_AZURE_ENABLED = "true"
} catch {
    Write-Error "An error occurred during PowerShell profile configuration: $_"
}

