# This dodgy script copies the profile script from the repository to the users $HOME\Documents folder.
# It then points the $Profile.CurrentUserAllHosts to the profile script in $HOME\Documents
# 

# Copy profile script to a 'central' user location
Write-Host "Copying profile script from repo to $HOME"
copy-item PsProfileConfig.ps1 "$HOME\Documents\PsProfileConfig.ps1"

# Add redirect to the system profile script
# This may need to be done for both powershell 5 and powershell 7+
Write-Host "Creating redirecting profile scripts"
Set-Content $PROFILE.CurrentUserAllHosts ". $HOME\Documents\PsProfileConfig.ps1"

# Copy custom themes from repo to oh-my-posh themes path
Copy-Item -path CustomThemes -Destination "$env:POSH_THEMES_PATH" -Recurse -Force

# Then re-run profile script.
Write-Host "Running profile script"
. $PROFILE.CurrentUserAllHosts

