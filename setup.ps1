# Run this script to setup windows profile

$centralProfilePath = '$HOME\Documents\PsProfileConfig.ps1'

# Install modules
winget install JanDeDobbeleer.OhMyPosh -Scope CurrentUser
install-module poshgit

# Copy profile script to 'central' user location
copy-item PsProfileConfig.ps1 $centralProfilePath


# Add redirect to the system profile script
# This may need to be done for both powershell 5 and powershell 7+
Set-Content $PROFILE.CurrentUserAllHosts ". $centralProfilePath"

# then re-run profile .$PROFILE


