# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

This repository is a Windows PowerShell profile configuration system. It installs shell enhancement modules and a custom oh-my-posh theme, then deploys a profile script that loads on every PowerShell session.

## Script Roles

- **`setup.ps1`** — One-time machine setup. Installs oh-my-posh (via winget), posh-git, Terminal-Icons, and PSReadLine modules, downloads and installs the CascadiaCode Nerd Font, then calls `UpdateProfile.ps1`.
- **`UpdateProfile.ps1`** — Deploys the profile. Copies `PsProfileConfig.ps1` to `$HOME\Documents\`, writes a dot-source redirect into `$PROFILE.CurrentUserAllHosts`, copies `CustomThemes\` into `$env:POSH_THEMES_PATH\CustomThemes\`, and re-sources the profile.
- **`PsProfileConfig.ps1`** — The actual profile script (dot-sourced on every shell start). Imports posh-git and Terminal-Icons, then initializes oh-my-posh with the `bluecloud` theme from `$env:POSH_THEMES_PATH\CustomThemes\bluecloud.omp.yaml`.
- **`CustomThemes/bluecloud.omp.yaml`** — oh-my-posh theme definition (path, git status, language versions, Azure context, exit-code indicator).

## Running the Scripts

Run these from the repository root in an elevated PowerShell session:

```powershell
# Full first-time setup (installs modules + font, then deploys profile)
.\setup.ps1

# Re-deploy profile only (no module/font install)
.\UpdateProfile.ps1
```

`setup.ps1` calls `UpdateProfile.ps1` at the end, so running setup is sufficient for a fresh machine.

## Key Constraints

- All scripts use `$PSScriptRoot` for paths — they must be run from the repo directory, not dot-sourced from an arbitrary location.
- `UpdateProfile.ps1` overwrites `$PROFILE.CurrentUserAllHosts` with a single dot-source line. Any existing content in that profile file will be replaced.
- The theme is resolved at profile load time via `$env:POSH_THEMES_PATH`, which oh-my-posh sets during its own initialization. If oh-my-posh is not installed, theme loading silently fails.
- Nerd font must be configured separately in each terminal emulator (Windows Terminal, VS Code terminal/editor) for glyphs to render correctly.

## Theme Customization

Edit `CustomThemes/bluecloud.omp.yaml` to change prompt appearance, then re-run `UpdateProfile.ps1` to deploy. The theme schema is validated against the oh-my-posh JSON schema referenced at the top of the file. The theme uses a powerline/diamond segment style with color-coded git status:

| Git state | Color |
|---|---|
| Clean | Green `#80fe61` |
| Dirty (unstaged/staged changes) | Orange `#f77622` |
| Ahead + Behind | Red `#e43b44` |
| Ahead only | Cyan `#2ce8f5` |
| Behind only | Yellow `#ffee00` |
