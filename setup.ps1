# Run this script to setup windows profile

# Install modules
winget install JanDeDobbeleer.OhMyPosh

Set-PSRepository PSGallery -InstallationPolicy Trusted
Install-module -Name posh-git
Install-Module -Name Terminal-Icons -Repository PSGallery
Install-Module -Name PSReadLine

# Copy profile script to 'central' user location
copy-item PsProfileConfig.ps1 "$HOME\Documents\PsProfileConfig.ps1"


# Add redirect to the system profile script
# This may need to be done for both powershell 5 and powershell 7+
Set-Content $PROFILE.CurrentUserAllHosts ". $HOME\Documents\PsProfileConfig.ps1"

# then re-run profile .$PROFILE
