$ErrorActionPreference = "Stop"
. ..\utils\make-exercise-repo.ps1

New-Item -ItemType Directory -Force -Path src, test | Out-Null

Set-Content app.json @"
{
  "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "name": "BC Review Demo",
  "publisher": "Schulung",
  "version": "1.0.0.0",
  "runtime": "14.0",
  "target": "Cloud"
}
"@

Set-Content .gitignore @"
.alpackages/
*.app
.alcache/
.vscode/launch.json
rad.json
*.g.xlf
"@

Set-Content src/CustomerListExt.al @"
pageextension 50100 CustomerListExt extends "Customer List"
{
    layout
    {
        addafter(Name)
        {
            field("Phone No."; Rec."Phone No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
"@

git add .
git commit -m "Initial commit: AL project structure"

# Cleanup local user config
git config --local --unset user.name
git config --local --unset user.email
git config --local --unset commit.gpgsign
git config --local --unset tag.gpgsign

Write-Host ""
Write-Host "=================================================="
Write-Host "  CODE REVIEW DOJO"
Write-Host "=================================================="
Write-Host ""
Write-Host "Basis-Repository erstellt."
Write-Host ""
Write-Host "Naechste Schritte:"
Write-Host "  1. Erstelle ein Repository auf GitHub/GitLab"
Write-Host "  2. Fuege den Remote hinzu:"
Write-Host "     git remote add origin <url>"
Write-Host "  3. Pushe:"
Write-Host "     git push -u origin master"
Write-Host "  4. Lade deinen Partner als Collaborator ein"
