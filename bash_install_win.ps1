$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

if ($PSScriptRoot)
{
    $ScriptDir = $PSScriptRoot
}
else
{
    $ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
}

function Confirm-Overwrite
{
    param(
        [Parameter(Mandatory = $true)]
        [string] $Path
    )

    if (-not (Test-Path $Path))
    {
        return $true
    }

    while ($true)
    {
        $response = Read-Host "File '$Path' exists. Overwrite? (Y/N)"
        switch ($response.ToUpper())
        {
            'Y' { return $true }
            'N' { return $false }
            default { Write-Host "Please type Y or N." }
        }
    }
}

function Copy-WithConfirm
{
    param(
        [Parameter(Mandatory = $true)][string]$Source,
        [Parameter(Mandatory = $true)][string]$Destination
    )

    if (-not (Test-Path $Source))
    {
        Write-Error "Source file not found: $Source"
        return
    }

    $doCopy = Confirm-Overwrite -Path $Destination
    if (-not $doCopy)
    {
        Write-Host "Skipped: $Destination"
        return
    }

    $destDir = Split-Path -Parent $Destination

    if (-not (Test-Path $destDir))
    {
        New-Item -ItemType Directory -Path $destDir -Force | Out-Null
    }

    Copy-Item -LiteralPath $Source -Destination $Destination -Force
    Write-Host "Copied: $Source -> $Destination"
}

function Get-PreferredProfileDestination
{
    # Prefer an existing profile file if present. Otherwise return a sensible default.
    $candidate1 = $PROFILE.CurrentUserAllHosts
    $candidate2 = Join-Path (Join-Path $env:USERPROFILE 'Documents') 'WindowsPowerShell\Microsoft.PowerShell_profile.ps1'

    if ($candidate1 -and (Test-Path $candidate1)) { return $candidate1 }
    if ($candidate2 -and (Test-Path $candidate2)) { return $candidate2 }

    if ($candidate1) { return $candidate1 }
    return $candidate2
}


# Copy .bashrc to Windows home
$sourceBash = Join-Path $ScriptDir '.bashrc'
$destBash = Join-Path $env:USERPROFILE '.bashrc'
Write-Host "Installing .bashrc to $destBash"
Copy-WithConfirm -Source $sourceBash -Destination $destBash

# Copy PowerShell profile (CurrentUserAllHosts)
$sourceProfile = Join-Path $ScriptDir 'Microsoft.PowerShell_profile.ps1'
$destProfile = Get-PreferredProfileDestination
Write-Host "Installing PowerShell profile to $destProfile"
Copy-WithConfirm -Source $sourceProfile -Destination $destProfile

Write-Host "Install script finished."

Write-Host ""
Write-Host "Press any key to close..."
[void][System.Console]::ReadKey($true)

