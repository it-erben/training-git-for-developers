$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Get-ChildItem -Path $ScriptDir -Directory | Where-Object { $_.Name -match '^\d' } | Sort-Object Name | ForEach-Object {
    $labName = $_.Name
    $exerciseDir = Join-Path $_.FullName "exercise"

    if (Test-Path $exerciseDir) {
        Remove-Item $exerciseDir -Recurse -Force
        Write-Host "CLEAN $labName"
    }
}

Write-Host ""
Write-Host "Alle exercise-Verzeichnisse wurden entfernt."
