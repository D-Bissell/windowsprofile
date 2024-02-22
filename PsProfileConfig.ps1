# Powershell profile configuration.
# Download this script to $HOME\Documents\PsProfileConfig.ps1

# Dot source this script from profile script $PROFILE.CurrentUserAllHosts for powershell 7 and 5
## . $HOME\Documents\PsProfileConfig.ps1

# Add posh-git
Import-Module posh-git
Import-Module Terminal-Icons


# Add oh-my-posh and set the theme
oh-my-posh init pwsh | Invoke-Expression
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/CustomThemes/bluecloud.omp.yaml" | Invoke-Expression
$env:POSH_GIT_ENABLED = $false

# Enable PowerShell support for Az module
# https://ohmyposh.dev/docs/segments/az
$env:POSH_AZURE_ENABLED = $true

