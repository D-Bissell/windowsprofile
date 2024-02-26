
# PowerShell Profile Configuration Repository

This repository contains scripts for configuring and enhancing the PowerShell environment on Windows systems. 
This repository contains scripts and themes for configuring and enhancing the PowerShell environment in Windows. It includes customizations for the shell prompt, theme, and other useful modules and customisations for an improved command-line experience.

## Contents

1. **PsProfileConfig.ps1** - This script configures the PowerShell profile with custom settings. It includes:
   - Importing the posh-git and Terminal-Icons modules.
   - Initializing oh-my-posh with a custom theme.
   - Enabling PowerShell support for Git and Azure.

2. **setup.ps1** - A setup script to install necessary modules and fonts for the Powershell profile. It performs the following actions:
   - Installs oh-my-posh, posh-git, Terminal-Icons, and PSReadLine modules.
   - Downloads and installs a Nerd Font (CascadiaCode) for enhanced terminal aesthetics.
   - Cleans up temporary files and runs the `UpdateProfile.ps1` script.

3. **UpdateProfile.ps1** - This script updates the user's PowerShell profile. Its functions include:
   - Copying `PsProfileConfig.ps1` to the user's `Documents` directory.
   - Redirecting the system profile script to source the `PsProfileConfig.ps1` script.
   - Copying custom oh-my-posh themes to the appropriate directory.
   - Re-executing the profile script to apply configurations immediately.

## Installation and Setup

To use these scripts, clone this repository to your local machine. Run the `setup.ps1` script first to install all necessary modules and the Nerd Font. This script will automatically call `UpdateProfile.ps1`, which sets up the PowerShell profile with the configurations defined in `PsProfileConfig.ps1`.

### Enabling Glyphs

To enable glyphs (the little icons in text) in any terminal or editor, a "Nerd font" must be configured in the settings for that terminal or editor.  This includes:
- Windows Terminal
- VSCode Terminal
- VSCode Editor

## Customization

You can customize your PowerShell environment by modifying the `PsProfileConfig.ps1` script. This script can be edited to change the shell theme, prompt behavior, and other settings as per your preference.

