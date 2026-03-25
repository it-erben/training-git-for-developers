#!/usr/bin/env bash
# Setup für Lab 13: Das vermasselte Repository
# Erstellt ein Repo mit typischen Anfänger-Problemen.

source ../utils/utils.sh
pre_setup

# --- Sauberer erster Commit ---
mkdir -p src test .vscode .alpackages

cat > app.json << 'EOF'
{
  "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "name": "BC Demo App",
  "publisher": "Schulung",
  "version": "1.0.0.0",
  "runtime": "14.0",
  "target": "Cloud"
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
git commit -m "Initial commit: add AL project structure"

# --- Problem 1: Dateien getrackt, die nicht hineingehören ---
echo "Riesige Binärdaten (50MB Symbole)" > .alpackages/Microsoft.app
echo '{"server":"https://bc-server","password":"gehe1m!"}' \
    > .vscode/launch.json
git add .alpackages/Microsoft.app .vscode/launch.json
git commit -m "Add dependencies and config"

# --- Problem 2: Monster-Commit mit 5 unabhängigen Änderungen ---
# Änderung A: Version bump
sed -i.bak 's/"version": "1.0.0.0"/"version": "1.1.0.0"/' app.json
rm -f app.json.bak

# Änderung B: Neues Feature
cat > src/VendorListExt.al << 'EOF'
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
EOF

# Änderung C: Bugfix in bestehendem Code
sed -i.bak 's/Phone No./Phone No.2/' src/CustomerListExt.al
rm -f src/CustomerListExt.al.bak

# Änderung D: Test-Datei
cat > test/TestCustomer.al << 'EOF'
codeunit 50100 "Test Customer"
{
    Subtype = Test;

    [Test]
    procedure TestCustomerFields()
    begin
        // TODO: implement
    end;
}
EOF

# Änderung E: Konfigurationsdatei
cat > .vscode/settings.json << 'EOF'
{
    "al.enableCodeAnalysis": true,
    "editor.formatOnSave": true
}
EOF

git add .
git commit -m "Did stuff"

# --- Problem 3: Schlechte Commit Message ---
cat > src/ItemCard.al << 'EOF'
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
EOF

git add .
git commit -m "asdf"

# --- Problem 4: Gestashte Arbeit ---
cat > src/SalesOrderExt.al << 'EOF'
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
EOF

git add src/SalesOrderExt.al
git stash save "WIP: Sales Order Extension (fast fertig!)"

# --- Problem 5: Unnötige Datei im Staging ---
echo "temporäre Notiz" > TODO.txt
git add TODO.txt

post_setup

echo ""
echo "=================================================="
echo "  DAS VERMASSELTE REPOSITORY"
echo "=================================================="
echo ""
echo "Probleme:"
echo "  1. Dateien getrackt, die nicht ins Repo gehören"
echo "  2. Ein 'Monster-Commit' mit 5 unabhängigen Änderungen"
echo "  3. Ein Commit mit einer furchtbaren Message"
echo "  4. Gestashte Arbeit, die eingearbeitet werden muss"
echo "  5. Eine Datei im Staging, die nicht committet werden soll"
