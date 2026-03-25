#!/usr/bin/env bash
# Setup für Lab 22: Release Day
# Erstellt ein Repo mit ~25 Commits, einem versteckten Bug,
# einem Feature-Branch mit unsauberen Commits und einem v1.0.0 Tag.

source ../utils/utils.sh
pre_setup

mkdir -p src test

# === Basis ===
cat > app.json << 'EOF'
{
  "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "name": "BC Demo App",
  "publisher": "Falsche Firma GmbH",
  "version": "1.0.0.0",
  "runtime": "14.0",
  "target": "Cloud"
}
EOF

cat > .gitignore << 'EOF'
.alpackages/
*.app
.alcache/
.vscode/launch.json
rad.json
*.g.xlf
EOF

cat > src/Calculator.al << 'EOF'
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
EOF

cat > src/CustomerListExt.al << 'EOF'
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
EOF

git add .
git commit -m "Initial commit: AL project structure"

# === v1.0.0 Tag ===
git tag -a v1.0.0 -m "Release 1.0.0"

# === Entwicklung nach v1.0.0 ===
# Bug wird bei zufälligem Commit eingebaut
BUG_AT=$((RANDOM % 10 + 5))
COMMIT_NR=0

for i in $(seq 1 25); do
    COMMIT_NR=$((COMMIT_NR + 1))

    if [ "$COMMIT_NR" -eq "$BUG_AT" ]; then
        # === BUG EINBAUEN ===
        sed -i.bak \
            's/quantity \* unitPrice/quantity + unitPrice/' \
            src/Calculator.al
        rm -f src/Calculator.al.bak
        git add .
        git commit -m "Refactor calculator for clarity"
    else
        case $((i % 7)) in
            0)
                cat > "src/Module${i}.al" << ALEOF
codeunit $((50100 + i)) "Module ${i}"
{
    procedure Process()
    begin
        Message('Processing module ${i}');
    end;
}
ALEOF
                git add .
                git commit -m "Add processing module ${i}"
                ;;
            1)
                echo "// Logging added in sprint ${i}" \
                    >> src/Calculator.al
                git add .
                git commit -m "Add logging to calculator"
                ;;
            2)
                cat > "src/Helper${i}.al" << ALEOF
codeunit $((50200 + i)) "Helper ${i}"
{
    procedure Execute()
    begin
        // Helper ${i}
    end;
}
ALEOF
                git add .
                git commit -m "Add helper codeunit ${i}"
                ;;
            3)
                cat > "test/Test${i}.al" << ALEOF
codeunit $((50300 + i)) "Test ${i}"
{
    Subtype = Test;

    [Test]
    procedure TestScenario${i}()
    begin
        // Test ${i}
    end;
}
ALEOF
                git add .
                git commit -m "Add test for scenario ${i}"
                ;;
            4)
                echo "// Updated in iteration ${i}" \
                    >> src/CustomerListExt.al
                git add .
                git commit -m "Update customer list extension"
                ;;
            5)
                cat > "src/Report${i}.al" << ALEOF
report $((50100 + i)) "Report ${i}"
{
    DefaultLayout = RDLC;
    Caption = 'Report ${i}';
}
ALEOF
                git add .
                git commit -m "Add report ${i}"
                ;;
            6)
                echo "// Config update ${i}" >> src/Calculator.al
                git add .
                git commit -m "Configure calculator settings"
                ;;
        esac
    fi
done

# === Feature-Branch mit unsauberen Commits ===
git switch -c feature/invoice-export

cat > src/InvoiceExport.al << 'EOF'
codeunit 50150 "Invoice Export"
{
    procedure ExportToCSV()
    begin
        Message('Exporting invoices...');
    end;
}
EOF
git add .
git commit -m "WIP"

echo "// more export stuff" >> src/InvoiceExport.al
git add .
git commit -m "fix"

cat > src/ExportHelper.al << 'EOF'
codeunit 50151 "Export Helper"
{
    procedure FormatDate(d: Date): Text
    begin
        exit(Format(d, 0, '<Year4>-<Month,2>-<Day,2>'));
    end;
}
EOF
git add .
git commit -m "asdf"

# Unzugehöriger Commit: Version bump gehört nicht hierhin
sed -i.bak \
    's/"version": "1.0.0.0"/"version": "2.0.0.0"/' app.json
rm -f app.json.bak
git add .
git commit -m "bump"

echo "// final touches" >> src/InvoiceExport.al
git add .
git commit -m "forgot this"

cat > test/TestExport.al << 'EOF'
codeunit 50350 "Test Export"
{
    Subtype = Test;

    [Test]
    procedure TestCSVExport()
    begin
        // TODO
    end;
}
EOF
git add .
git commit -m "add test maybe"

git switch "$DEFAULT_BRANCH"

post_setup

echo ""
echo "=================================================="
echo "  RELEASE DAY"
echo "=================================================="
echo ""
echo "Zustand:"
echo "  - main: ~25 Commits seit v1.0.0 (mit Bug)"
echo "  - feature/invoice-export: 6 unsaubere Commits"
echo "  - v1.0.0: Letztes Release (kein Bug)"
echo "  - Publisher in app.json ist falsch"
echo ""
echo "Aufgaben:"
echo "  1. Bug in Calculator.al per git bisect finden"
echo "  2. Bug fixen"
echo "  3. Feature-Branch aufräumen (Interactive Rebase)"
echo "  4. Release 1.1.0 vorbereiten"
echo "  5. Hotfix v1.0.1 fuer Publisher erstellen"
echo "  6. Release abschließen"
echo ""
echo "(Trainer-Info: Bug bei Commit Nr. $BUG_AT)"
