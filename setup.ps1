# Run this script to setup windows profile

# Install modules
Write-Host "Installing oh-my-posh"
winget install JanDeDobbeleer.OhMyPosh

Set-PSRepository PSGallery -InstallationPolicy Trusted

Write-Host "Installing posh-git"
Install-module -Name posh-git -Scope CurrentUser

Write-Host "Installing Terminal-Icons"
Install-Module -Name Terminal-Icons -Repository PSGallery -Scope CurrentUser

Write-Host "Installing PSReadLine"
Install-Module -Name PSReadLine -Scope CurrentUser

# Install Nerd font
Write-Host "Installing Nerd Font (Ignore the 302 error)"
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

# Delete temp font files
Write-Host "Removing Temp font files"
Remove-item -Path "$FontName*" -Confirm:$false -Recurse

. .\UpdateProfile.ps1
