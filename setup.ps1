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
Write-Host "Installing Nerd Font"
$FontName = 'CascadiaCode'
$NerdFontsURI = 'https://github.com/ryanoasis/nerd-fonts/releases'
try {
    Write-Host "Resolving latest Nerd Fonts release version"
    $response = Invoke-WebRequest -Uri "$NerdFontsURI/latest" -MaximumRedirection 10
    $LatestVersion = Split-Path -Path $response.BaseResponse.ResponseUri -Leaf

    Write-Host "Downloading $FontName $LatestVersion"
    Invoke-WebRequest -Uri "$NerdFontsURI/download/$LatestVersion/$FontName.zip" -OutFile "$PSScriptRoot\$FontName.zip"

    Write-Host "Extracting font archive"
    Expand-Archive -Path "$PSScriptRoot\$FontName.zip" -DestinationPath "$PSScriptRoot\$FontName"

    Write-Host "Installing fonts"
    $ShellApplication = New-Object -ComObject shell.application
    $Fonts = $ShellApplication.NameSpace(0x14)
    Get-ChildItem -Path "$PSScriptRoot\$FontName" -Include '*.ttf' -Recurse | ForEach-Object {
        $Fonts.CopyHere($_.FullName)
    }
    Write-Host "Nerd Font installed successfully."
} catch {
    Write-Error "Font installation failed: $_"
} finally {
    Write-Host "Removing temp font files"
    Remove-Item -Path "$PSScriptRoot\$FontName*" -Confirm:$false -Recurse -ErrorAction SilentlyContinue
}

. "$PSScriptRoot\UpdateProfile.ps1"
