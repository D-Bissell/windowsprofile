# Run this script to setup windows profile

# Install modules
winget install JanDeDobbeleer.OhMyPosh
install-module posh-git

# Copy profile script to 'central' user location
copy-item PsProfileConfig.ps1 "$HOME\Documents\PsProfileConfig.ps1"


# Add redirect to the system profile script
# This may need to be done for both powershell 5 and powershell 7+
Set-Content $PROFILE.CurrentUserAllHosts ". $HOME\Documents\PsProfileConfig.ps1"

# then re-run profile .$PROFILE
