$ErrorActionPreference = "Stop"
. ..\utils\make-exercise-repo.ps1

New-Item -ItemType Directory -Force -Path src, test | Out-Null

# === Basis aufbauen ===
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

Set-Content .gitignore @"
.alpackages/
*.app
.alcache/
.vscode/launch.json
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

Set-Content src/Base.al @"
codeunit 50100 "Base Module"
{
    procedure Init()
    begin
        Message('Base module initialized');
    end;
}
"@

git add .
git commit -m "Initial commit: project structure"

# === Einige Commits auf main ===
Set-Content src/Config.al @"
codeunit 50101 "App Configuration"
{
    procedure GetVersion(): Text
    begin
        exit('1.0.0.0');
    end;
}
"@
git add .
git commit -m "Add configuration module"

# === Branch A: feature/customer-fields ===
git switch -c feature/customer-fields

(Get-Content app.json) -replace '"version": "1.0.0.0"', '"version": "1.1.0.0"' | Set-Content app.json

Add-Content src/CustomerListExt.al @"

// Added by Developer A
// Customer email field for communication
"@

Set-Content src/CustomerEmail.al @"
tableextension 50100 CustomerEmailExt extends Customer
{
    fields
    {
        field(50100; "Preferred Email"; Text[80])
        {
            Caption = 'Preferred Email';
            ApplicationArea = All;
        }
    }
}
"@

git add .
git commit -m "Add customer email field and bump version"

git switch master

# === Branch B: feature/vendor-page ===
git switch -c feature/vendor-page

(Get-Content app.json) -replace '"version": "1.0.0.0"', '"version": "1.2.0.0"' | Set-Content app.json

Set-Content src/VendorPageExt.al @"
pageextension 50101 VendorCardExt extends "Vendor Card"
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

git add .
git commit -m "Add vendor card extension and bump version"

git switch master

# === Branch C: feature/analytics (wird spaeter geloescht) ===
git switch -c feature/analytics

Set-Content src/AnalyticsModule.al @"
codeunit 50102 "Analytics Module"
{
    procedure RunReport()
    begin
        Message('Running analytics report...');
    end;

    procedure ExportData()
    begin
        Message('Exporting analytics data...');
    end;
}
"@

Set-Content src/AnalyticsSetup.al @"
table 50100 "Analytics Setup"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10]) { }
        field(2; "Enable Tracking"; Boolean)
        {
            Caption = 'Enable Tracking';
        }
    }
}
"@

git add .
git commit -m "Add analytics module with reporting and setup"

$AnalyticsTip = git rev-parse HEAD
git switch master

# === Fehlerhafter Commit auf main ===
(Get-Content src/Base.al) -replace "Message\('Base module initialized'\);", "Message('Base module initialized'); // BUG: this breaks error handling" | Set-Content src/Base.al

git add .
git commit -m "Quick fix for base module"

# Noch ein normaler Commit auf main
Add-Content src/Config.al "// Performance improvement"
git add .
git commit -m "Improve configuration performance"

# === Branch loeschen (Problem: verlorener Branch) ===
git branch -D feature/analytics

# === Detached HEAD erzeugen ===
$FirstCommit = git rev-list --max-parents=0 HEAD
git checkout $FirstCommit 2>$null

# Cleanup local user config
git config --local --unset user.name
git config --local --unset user.email
git config --local --unset commit.gpgsign
git config --local --unset tag.gpgsign

Write-Host ""
Write-Host "=================================================="
Write-Host "  PARALLELE WELTEN"
Write-Host "=================================================="
Write-Host ""
Write-Host "Zustand:"
Write-Host "  - Du bist im Detached HEAD auf dem ersten Commit"
Write-Host "  - feature/customer-fields: Wartet auf Merge"
Write-Host "  - feature/vendor-page: Wartet auf Merge"
Write-Host "  - feature/analytics: GELOESCHT (war wichtig!)"
Write-Host "  - main: Hat einen fehlerhaften Commit"
Write-Host ""
Write-Host "  git log --oneline --graph --all"
