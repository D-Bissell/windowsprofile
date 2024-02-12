# Powershell profile configuration.
# Download this script to $HOME\Documents\PsProfileConfig.ps1

# Dot source this script from profile script $PROFILE.CurrentUserAllHosts for powershell 7 and 5

# 
## . $HOME\Documents\PsProfileConfig.ps1

# Add post-git
Import-Module posh-git
import-Module Terminal-Icons


# Add oh-my-posh and set the theme
oh-my-posh init pwsh | Invoke-Expression
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/gruvbox.omp.json" | Invoke-Expression



#Cloud native azure good but too much stuff
# Gruvbox

#I want
# path
# NOT user
# Git branch
# Git status
# azure sub on the right
