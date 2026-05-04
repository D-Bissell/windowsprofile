# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

This repository is a Windows PowerShell profile configuration system. It installs shell enhancement modules and a custom oh-my-posh theme, then deploys a profile script that loads on every PowerShell session.

## Script Roles

- **`setup.ps1`** — One-time machine setup (requires elevation). Installs oh-my-posh (via winget), posh-git, Terminal-Icons, and PSReadLine modules, downloads and installs the CascadiaCode Nerd Font, then calls `UpdateProfile.ps1`.
- **`UpdateProfile.ps1`** — Deploys the profile (no elevation required). Copies `PsProfileConfig.ps1` to `$HOME\Documents\`, writes a dot-source redirect into `$PROFILE.CurrentUserAllHosts`, copies `CustomThemes\` into `$env:POSH_THEMES_PATH\CustomThemes\`, and re-sources the profile.
- **`PsProfileConfig.ps1`** — The actual profile script (dot-sourced on every shell start). Imports posh-git and Terminal-Icons via `Import-ModuleWithCheck`, then initializes oh-my-posh via `Initialize-OhMyPosh`. Sets `POSH_GIT_ENABLED=false` (git display delegated to oh-my-posh, not posh-git directly) and `POSH_AZURE_ENABLED=true`.
- **`CustomThemes/bluecloud.omp.yaml`** — oh-my-posh theme definition.

## Running the Scripts

Run these from the repository root in PowerShell:

```powershell
# Full first-time setup (installs modules + font, then deploys profile) — requires elevation
.\setup.ps1

# Re-deploy profile only (no module/font install) — no elevation required
.\UpdateProfile.ps1
```

`setup.ps1` calls `UpdateProfile.ps1` at the end. If both PowerShell 5 and PowerShell 7+ are installed, `UpdateProfile.ps1` must be run once in each version, since `$PROFILE.CurrentUserAllHosts` resolves to different paths per version.

## Key Constraints

- All scripts use `$PSScriptRoot` for paths — they must be run from the repo directory, not dot-sourced from an arbitrary location.
- `UpdateProfile.ps1` overwrites `$PROFILE.CurrentUserAllHosts` with a single dot-source line. Any existing content in that profile file will be replaced.
- The theme is resolved at profile load time via `$env:POSH_THEMES_PATH`, which oh-my-posh sets during its own initialization. If oh-my-posh is not installed, theme loading silently fails and `Initialize-OhMyPosh` falls back to the default theme.
- Nerd font must be configured separately in each terminal emulator (Windows Terminal, VS Code terminal/editor) for glyphs to render correctly.

## Theme Customization

Edit `CustomThemes/bluecloud.omp.yaml` to change prompt appearance, then re-run `UpdateProfile.ps1` to deploy. The theme schema is validated against the oh-my-posh JSON schema referenced at the top of the file.

The theme has a left prompt and a right prompt:

**Left prompt segments** (powerline/diamond style, left-to-right):
- `path` — current directory (agnoster_short style)
- `git` — branch, status, stash count; color-coded by state:

  | Git state | Color |
  |---|---|
  | Clean | Green `#80fe61` |
  | Dirty (unstaged/staged changes) | Orange `#f77622` |
  | Ahead + Behind | Red `#e43b44` |
  | Ahead only | Cyan `#2ce8f5` |
  | Behind only | Yellow `#ffee00` |

- `node`, `go`, `julia`, `python`, `ruby` — language version (shown when relevant files detected)
- `azfunc` — Azure Functions version (shown when function app files detected)
- `aws` — AWS profile (shown when active)
- `status` — exit code indicator; blue when success, red on non-zero exit, yellow crown when running as admin

**Right prompt segments:**
- `az` (cli) — Azure CLI active subscription name
- `az` (pwsh) — Azure PowerShell active subscription name
