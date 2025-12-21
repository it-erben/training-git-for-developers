#!/usr/bin/env bash
# Setup für Lab 20: Parallele Welten
# Erstellt ein Repo mit mehreren Branches, Konflikten, einem
# gelöschten Branch und einem Detached HEAD.

source ../utils/utils.sh
pre-setup

mkdir -p src test

# === Basis aufbauen ===
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

cat > .gitignore << 'EOF'
.alpackages/
*.app
.alcache/
.vscode/launch.json
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

cat > src/Base.al << 'EOF'
codeunit 50100 "Base Module"
{
    procedure Init()
    begin
        Message('Base module initialized');
    end;
}
EOF

git add .
git commit -m "Initial commit: project structure"

# === Einige Commits auf main ===
cat > src/Config.al << 'EOF'
codeunit 50101 "App Configuration"
{
    procedure GetVersion(): Text
    begin
        exit('1.0.0.0');
    end;
}
EOF
git add .
git commit -m "Add configuration module"

# === Branch A: feature/customer-fields ===
git switch -c feature/customer-fields

sed -i.bak 's/"version": "1.0.0.0"/"version": "1.1.0.0"/' app.json
rm -f app.json.bak

cat >> src/CustomerListExt.al << 'EOF'

// Added by Developer A
// Customer email field for communication
EOF

cat > src/CustomerEmail.al << 'EOF'
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
EOF

git add .
git commit -m "Add customer email field and bump version"

git switch "$DEFAULT_BRANCH"

# === Branch B: feature/vendor-page ===
git switch -c feature/vendor-page

sed -i.bak 's/"version": "1.0.0.0"/"version": "1.2.0.0"/' app.json
rm -f app.json.bak

cat > src/VendorPageExt.al << 'EOF'
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
EOF

git add .
git commit -m "Add vendor card extension and bump version"

git switch "$DEFAULT_BRANCH"

# === Branch C: feature/analytics (wird später gelöscht) ===
git switch -c feature/analytics

cat > src/AnalyticsModule.al << 'EOF'
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
EOF

cat > src/AnalyticsSetup.al << 'EOF'
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
EOF

git add .
git commit -m "Add analytics module with reporting and setup"

ANALYTICS_TIP=$(git rev-parse HEAD)
git switch "$DEFAULT_BRANCH"

# === Fehlerhafter Commit auf main ===
sed -i.bak "s/Message('Base module initialized');/Message('Base module initialized'); \/\/ BUG: this breaks error handling/" src/Base.al
rm -f src/Base.al.bak

git add .
git commit -m "Quick fix for base module"

# Noch ein normaler Commit auf main
echo "// Performance improvement" >> src/Config.al
git add .
git commit -m "Improve configuration performance"

# === Branch löschen (Problem: verlorener Branch) ===
git branch -D feature/analytics

# === Detached HEAD erzeugen ===
FIRST_COMMIT=$(git rev-list --max-parents=0 HEAD)
git checkout "$FIRST_COMMIT" 2>/dev/null

post-setup

echo ""
echo "=================================================="
echo "  PARALLELE WELTEN"
echo "=================================================="
echo ""
echo "Zustand:"
echo "  - Du bist im Detached HEAD auf dem ersten Commit"
echo "  - feature/customer-fields: Wartet auf Merge"
echo "  - feature/vendor-page: Wartet auf Merge"
echo "  - feature/analytics: GELÖSCHT (war wichtig!)"
echo "  - main: Hat einen fehlerhaften Commit"
echo ""
echo "  git log --oneline --graph --all"
