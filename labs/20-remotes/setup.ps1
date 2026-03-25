$ErrorActionPreference = "Stop"
. ..\utils\make-exercise-repo.ps1

# --- Lokales Repo mit Inhalt ---
Set-Content README.md @"
# Mein Projekt

Ein Beispiel-Repository zum Lernen von Git Remotes.
"@

git add README.md
git commit -m "Initial commit: add README"

Set-Content greeting.txt "hello world"
git add greeting.txt
git commit -m "Add greeting file"

Set-Content config.txt "version: 1.0"
git add config.txt
git commit -m "Add config file"

# Cleanup local user config (only unset if set by setup script)
if ((git config --local user.name 2>$null) -eq "git-katas trainer bot") { git config --local --unset user.name }
if ((git config --local user.email 2>$null) -eq "git-katas@example.com") { git config --local --unset user.email }
git config --local --unset commit.gpgsign 2>$null
git config --local --unset tag.gpgsign 2>$null

# --- Bare-Remote aus exercise erstellen ---
Set-Location ..
if (Test-Path .\remote.git) {
    Remove-Item .\remote.git -Force -Recurse
}
if (Test-Path .\kollege) {
    Remove-Item .\kollege -Force -Recurse
}
git clone --bare exercise remote.git 2>$null

# --- Lokales Repo mit Remote verbinden ---
Set-Location .\exercise
git remote add origin ../remote.git

# --- Kollegen-Klon erstellen ---
Set-Location ..
git clone remote.git kollege 2>$null

Write-Host ""
Write-Host "=================================================="
Write-Host "  REMOTES LAB"
Write-Host "=================================================="
Write-Host ""
Write-Host "  Lokales Repo:    exercise/"
Write-Host "  Bare Remote:     remote.git/"
Write-Host "  Kollegen-Klon:   kollege/"
Write-Host ""
Write-Host "  Der Remote 'origin' ist bereits konfiguriert."
Write-Host "=================================================="
