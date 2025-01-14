# windowsprofile


## setup.ps1

Run this script to setup windows profile
Installs oh-my-posh, nerd fonts, terminal icons, etc.

## UpdateProfile.ps1

 This script updates the local profile script with the version in the repository
 It copies the profile script from the repository to the users $HOME\Documents folder.
 It then points the $Profile.CurrentUserAllHosts to the profile script in $HOME\Documents.

 Run this when the repo version of the profile script has been updated and you want to update the version on the local machine.

 ## PsProfileConfig.ps1

 The actual profile script.
 Imports the installed modules, runs oh-my-posh, etc.
