$ErrorActionPreference = "Stop"
. ..\utils\make-exercise-repo.ps1

New-Item -ItemType Directory -Force -Path src, test | Out-Null

# === Basis ===
Set-Content app.json @"
{
  "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "name": "BC Demo App",
  "publisher": "Falsche Firma GmbH",
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

Set-Content src/Calculator.al @"
codeunit 50100 "Sales Calculator"
{
    procedure CalculateLineAmount(quantity: Decimal; unitPrice: Decimal): Decimal
    begin
        exit(quantity * unitPrice);
    end;

    procedure CalculateDiscount(amount: Decimal; discountPct: Decimal): Decimal
    begin
        exit(amount * discountPct / 100);
    end;
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
git commit -m "Initial commit: AL project structure"

# === v1.0.0 Tag ===
git tag -a v1.0.0 -m "Release 1.0.0"

# === Entwicklung nach v1.0.0 ===
$BugAt = Get-Random -Minimum 5 -Maximum 15
$CommitNr = 0

foreach ($i in 1..25) {
    $CommitNr++

    if ($CommitNr -eq $BugAt) {
        # === BUG EINBAUEN ===
        (Get-Content src/Calculator.al) -replace 'quantity \* unitPrice', 'quantity + unitPrice' | Set-Content src/Calculator.al
        git add .
        git commit -m "Refactor calculator for clarity"
    } else {
        switch ($i % 7) {
            0 {
                Set-Content "src/Module${i}.al" @"
codeunit $($i + 50100) "Module ${i}"
{
    procedure Process()
    begin
        Message('Processing module ${i}');
    end;
}
"@
                git add .
                git commit -m "Add processing module ${i}"
            }
            1 {
                Add-Content src/Calculator.al "// Logging added in sprint ${i}"
                git add .
                git commit -m "Add logging to calculator"
            }
            2 {
                Set-Content "src/Helper${i}.al" @"
codeunit $($i + 50200) "Helper ${i}"
{
    procedure Execute()
    begin
        // Helper ${i}
    end;
}
"@
                git add .
                git commit -m "Add helper codeunit ${i}"
            }
            3 {
                Set-Content "test/Test${i}.al" @"
codeunit $($i + 50300) "Test ${i}"
{
    Subtype = Test;

    [Test]
    procedure TestScenario${i}()
    begin
        // Test ${i}
    end;
}
"@
                git add .
                git commit -m "Add test for scenario ${i}"
            }
            4 {
                Add-Content src/CustomerListExt.al "// Updated in iteration ${i}"
                git add .
                git commit -m "Update customer list extension"
            }
            5 {
                Set-Content "src/Report${i}.al" @"
report $($i + 50100) "Report ${i}"
{
    DefaultLayout = RDLC;
    Caption = 'Report ${i}';
}
"@
                git add .
                git commit -m "Add report ${i}"
            }
            6 {
                Add-Content src/Calculator.al "// Config update ${i}"
                git add .
                git commit -m "Configure calculator settings"
            }
        }
    }
}

# === Feature-Branch mit unsauberen Commits ===
git switch -c feature/invoice-export

Set-Content src/InvoiceExport.al @"
codeunit 50150 "Invoice Export"
{
    procedure ExportToCSV()
    begin
        Message('Exporting invoices...');
    end;
}
"@
git add .
git commit -m "WIP"

Add-Content src/InvoiceExport.al "// more export stuff"
git add .
git commit -m "fix"

Set-Content src/ExportHelper.al @"
codeunit 50151 "Export Helper"
{
    procedure FormatDate(d: Date): Text
    begin
        exit(Format(d, 0, '<Year4>-<Month,2>-<Day,2>'));
    end;
}
"@
git add .
git commit -m "asdf"

# Unzugehoeriger Commit: Version bump gehoert nicht hierhin
(Get-Content app.json) -replace '"version": "1.0.0.0"', '"version": "2.0.0.0"' | Set-Content app.json
git add .
git commit -m "bump"

Add-Content src/InvoiceExport.al "// final touches"
git add .
git commit -m "forgot this"

Set-Content test/TestExport.al @"
codeunit 50350 "Test Export"
{
    Subtype = Test;

    [Test]
    procedure TestCSVExport()
    begin
        // TODO
    end;
}
"@
git add .
git commit -m "add test maybe"

git switch master

# Cleanup local user config
git config --local --unset user.name
git config --local --unset user.email
git config --local --unset commit.gpgsign
git config --local --unset tag.gpgsign

Write-Host ""
Write-Host "=================================================="
Write-Host "  RELEASE DAY"
Write-Host "=================================================="
Write-Host ""
Write-Host "Zustand:"
Write-Host "  - main: ~25 Commits seit v1.0.0 (mit Bug)"
Write-Host "  - feature/invoice-export: 6 unsaubere Commits"
Write-Host "  - v1.0.0: Letztes Release (kein Bug)"
Write-Host "  - Publisher in app.json ist falsch"
Write-Host ""
Write-Host "Aufgaben:"
Write-Host "  1. Bug in Calculator.al per git bisect finden"
Write-Host "  2. Bug fixen"
Write-Host "  3. Feature-Branch aufraeumen (Interactive Rebase)"
Write-Host "  4. Release 1.1.0 vorbereiten"
Write-Host "  5. Hotfix v1.0.1 fuer Publisher erstellen"
Write-Host "  6. Release abschliessen"
Write-Host ""
Write-Host "(Trainer-Info: Bug bei Commit Nr. $BugAt)"
