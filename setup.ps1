# Run this script to setup windows profile

# Install modules
winget install JanDeDobbeleer.OhMyPosh

Set-PSRepository PSGallery -InstallationPolicy Trusted
Install-module -Name posh-git
Install-Module -Name Terminal-Icons -Repository PSGallery
Install-Module -Name PSReadLine

# Install Nerd font
$FontName = 'CascadiaCode'
$NerdFontsURI = 'https://github.com/ryanoasis/nerd-fonts/releases'
Invoke-WebRequest -Uri "$NerdFontsURI/latest" -MaximumRedirection 0 -ErrorVariable err
$LatestVersion = Split-Path -Path $err.InnerException.Response.Headers.Location -Leaf
Invoke-WebRequest -Uri "$NerdFontsURI/download/$LatestVersion/$FontName.zip" -OutFile "$FontName.zip"
Expand-Archive -Path "$FontName.zip"
$ShellApplication = New-Object -ComObject shell.application
$Fonts = $ShellApplication.NameSpace(0x14)
Get-ChildItem -Path ".\$FontName" -Include '*.ttf' -Recurse | ForEach-Object -Process {
    $Fonts.CopyHere($_.FullName)
}

# Copy profile script to 'central' user location
copy-item PsProfileConfig.ps1 "$HOME\Documents\PsProfileConfig.ps1"


# Add redirect to the system profile script
# This may need to be done for both powershell 5 and powershell 7+
Set-Content $PROFILE.CurrentUserAllHosts ". $HOME\Documents\PsProfileConfig.ps1"

# then re-run profile .$PROFILE


