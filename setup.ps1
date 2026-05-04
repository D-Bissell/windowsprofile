#Requires -RunAsAdministrator
# Run this script to setup windows profile

# Install modules
Write-Host "Installing oh-my-posh"
winget install JanDeDobbeleer.OhMyPosh

Set-PSResourceRepository -Name PSGallery -Trusted

Write-Host "Installing posh-git"
Install-PSResource -Name posh-git -Scope AllUsers

Write-Host "Installing Terminal-Icons"
Install-PSResource -Name Terminal-Icons -Scope AllUsers -Reinstall

Write-Host "Installing PSReadLine"
Install-PSResource -Name PSReadLine -Scope AllUsers

# Install Nerd font
$FontName = 'CascadiaCode'
$NerdFontsURI = 'https://github.com/ryanoasis/nerd-fonts/releases'

try {
    Write-Host "Resolving latest Nerd Fonts release version"
    $response = Invoke-WebRequest -Uri "$NerdFontsURI/latest" -MaximumRedirection 10
    $LatestVersion = Split-Path -Path $response.BaseResponse.RequestMessage.RequestUri -Leaf

    Write-Host "Downloading $FontName $LatestVersion"
    Invoke-WebRequest -Uri "$NerdFontsURI/download/$LatestVersion/$FontName.zip" -OutFile "$PSScriptRoot\$FontName.zip"

    Write-Host "Extracting font archive"
    Expand-Archive -Path "$PSScriptRoot\$FontName.zip" -DestinationPath "$PSScriptRoot\$FontName"

    Write-Host "Installing fonts"
    $fontsDir = "$env:WINDIR\Fonts"
    $regPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"
    $installed = 0
    $skipped = 0
    Get-ChildItem -Path "$PSScriptRoot\$FontName" -Include '*.ttf' -Recurse | ForEach-Object {
        if (Test-Path "$fontsDir\$($_.Name)") {
            $skipped++
        } else {
            Copy-Item $_.FullName "$fontsDir\$($_.Name)" -Force
            New-ItemProperty -Path $regPath -Name "$($_.BaseName) (TrueType)" -Value $_.Name -PropertyType String -Force | Out-Null
            $installed++
        }
    }
    Write-Host "Nerd Font installation complete ($installed installed, $skipped already present)."
} catch {
    Write-Error "Font installation failed: $_"
} finally {
    Write-Host "Removing temp font files"
    Remove-Item -Path "$PSScriptRoot\$FontName*" -Confirm:$false -Recurse -ErrorAction SilentlyContinue
}

. "$PSScriptRoot\UpdateProfile.ps1"
