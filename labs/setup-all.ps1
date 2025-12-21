$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$OriginalLocation = Get-Location

Get-ChildItem -Path $ScriptDir -Directory | Where-Object { $_.Name -match '^\d' } | Sort-Object Name | ForEach-Object {
    $labDir = $_.FullName
    $labName = $_.Name
    $setupFile = Join-Path $labDir "setup.ps1"

    if (-not (Test-Path $setupFile)) {
        Write-Host "SKIP  $labName (kein setup.ps1 vorhanden)"
        return
    }

    Write-Host "SETUP $labName ..."
    try {
        Set-Location $labDir
        & .\setup.ps1
        Write-Host "OK    $labName"
        Write-Host ""
    }
    finally {
        Set-Location $OriginalLocation
    }
}

Write-Host "Alle Labs wurden aufgesetzt."
