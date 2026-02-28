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

# Marker used to identify lines managed by cygenv
$CygenvMarker = '# cygenv-managed'

function Add-SourceBlockIfNeeded
{
    param(
        [Parameter(Mandatory = $true)][string]$Dest,
        [Parameter(Mandatory = $true)][string]$Src,
        [Parameter(Mandatory = $true)][string]$SourceLine,
        [switch]$Force
    )

    if (-not (Test-Path $Src))
    {
        Write-Error "Source file not found: $Src"
        return
    }

    $destDir = Split-Path -Parent $Dest
    if ($destDir -and -not (Test-Path $destDir))
    {
        New-Item -ItemType Directory -Path $destDir -Force | Out-Null
    }

    if (Test-Path $Dest)
    {
        $content = Get-Content $Dest -Raw
        if ($content -and $content.Contains($CygenvMarker))
        {
            if ($Force)
            {
                # Remove the managed block: marker line and the following line
                $lines = Get-Content $Dest
                $filtered = @()
                $skip = $false
                foreach ($line in $lines)
                {
                    if ($line.Contains($CygenvMarker)) { $skip = $true; continue }
                    if ($skip) { $skip = $false; continue }
                    $filtered += $line
                }
                Set-Content -Path $Dest -Value $filtered
                Write-Host "Removed existing managed block from: $Dest"
            }
            else
            {
                Write-Host "Skipping (already managed by cygenv): $Dest"
                return
            }
        }
    }

    Add-Content -Path $Dest -Value ""
    Add-Content -Path $Dest -Value $CygenvMarker
    Add-Content -Path $Dest -Value $SourceLine
    Write-Host "Updated: $Dest -> sources $Src"
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


# Append source block for .bashrc
$sourceBash = Join-Path $ScriptDir '.bashrc'
$destBash = Join-Path $env:USERPROFILE '.bashrc'
Write-Host "Updating .bashrc at $destBash"
Add-SourceBlockIfNeeded -Dest $destBash -Src $sourceBash -SourceLine ". `"$sourceBash`""

# Append source block for PowerShell profile
$sourceProfile = Join-Path $ScriptDir 'Microsoft.PowerShell_profile.ps1'
$destProfile = Get-PreferredProfileDestination
Write-Host "Updating PowerShell profile at $destProfile"
Add-SourceBlockIfNeeded -Dest $destProfile -Src $sourceProfile -SourceLine ". `"$sourceProfile`""

Write-Host "Install script finished."

Write-Host ""
Write-Host "Press any key to close..."
[void][System.Console]::ReadKey($true)

