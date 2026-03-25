$ErrorActionPreference = "Stop"
. ..\utils\make-exercise-repo.ps1

# --- Sauberer erster Commit ---
New-Item -ItemType Directory -Force -Path src, test, .vscode, .alpackages | Out-Null

Set-Content app.json @"
{
  "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "name": "BC Demo App",
  "publisher": "Schulung",
  "version": "1.0.0.0",
  "runtime": "14.0",
  "target": "Cloud"
}
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
git commit -m "Initial commit: add AL project structure"

# --- Problem 1: Dateien getrackt, die nicht hineingehoeren ---
Set-Content .alpackages/Microsoft.app "Riesige Binaerdaten (50MB Symbole)"
Set-Content .vscode/launch.json '{"server":"https://bc-server","password":"gehe1m!"}'
git add .alpackages/Microsoft.app .vscode/launch.json
git commit -m "Add dependencies and config"

# --- Problem 2: Monster-Commit mit 5 unabhaengigen Aenderungen ---
# Aenderung A: Version bump
(Get-Content app.json) -replace '"version": "1.0.0.0"', '"version": "1.1.0.0"' | Set-Content app.json

# Aenderung B: Neues Feature
Set-Content src/VendorListExt.al @"
pageextension 50101 VendorListExt extends "Vendor List"
{
    layout
    {
        addafter(Name)
        {
            field("Balance (LCY)"; Rec."Balance (LCY)")
            {
                ApplicationArea = All;
            }
        }
    }
}
"@

# Aenderung C: Bugfix in bestehendem Code
(Get-Content src/CustomerListExt.al) -replace 'Phone No\.', 'Phone No.2' | Set-Content src/CustomerListExt.al

# Aenderung D: Test-Datei
Set-Content test/TestCustomer.al @"
codeunit 50100 "Test Customer"
{
    Subtype = Test;

    [Test]
    procedure TestCustomerFields()
    begin
        // TODO: implement
    end;
}
"@

# Aenderung E: Konfigurationsdatei
Set-Content .vscode/settings.json @"
{
    "al.enableCodeAnalysis": true,
    "editor.formatOnSave": true
}
"@

git add .
git commit -m "Did stuff"

# --- Problem 3: Schlechte Commit Message ---
Set-Content src/ItemCard.al @"
pageextension 50102 ItemCardExt extends "Item Card"
{
    layout
    {
        addafter(Description)
        {
            field("Unit Cost"; Rec."Unit Cost")
            {
                ApplicationArea = All;
            }
        }
    }
}
"@

git add .
git commit -m "asdf"

# --- Problem 4: Gestashte Arbeit ---
Set-Content src/SalesOrderExt.al @"
pageextension 50103 SalesOrderExt extends "Sales Order"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
"@

git add src/SalesOrderExt.al
git stash save "WIP: Sales Order Extension (fast fertig!)"

# --- Problem 5: Unnoetige Datei im Staging ---
Set-Content TODO.txt "temporaere Notiz"
git add TODO.txt

# Cleanup local user config (only unset if set by setup script)
if ((git config --local user.name 2>$null) -eq "git-katas trainer bot") { git config --local --unset user.name }
if ((git config --local user.email 2>$null) -eq "git-katas@example.com") { git config --local --unset user.email }
git config --local --unset commit.gpgsign 2>$null
git config --local --unset tag.gpgsign 2>$null

Write-Host ""
Write-Host "=================================================="
Write-Host "  DAS VERMASSELTE REPOSITORY"
Write-Host "=================================================="
Write-Host ""
Write-Host "Probleme:"
Write-Host "  1. Dateien getrackt, die nicht ins Repo gehoeren"
Write-Host "  2. Ein 'Monster-Commit' mit 5 unabhaengigen Aenderungen"
Write-Host "  3. Ein Commit mit einer furchtbaren Message"
Write-Host "  4. Gestashte Arbeit, die eingearbeitet werden muss"
Write-Host "  5. Eine Datei im Staging, die nicht committet werden soll"
