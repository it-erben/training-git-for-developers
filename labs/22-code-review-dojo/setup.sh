#!/usr/bin/env bash
# Setup für Lab 21: Code Review Dojo
# Erstellt ein Basis-Repository, das die Teilnehmer nach GitHub/GitLab
# pushen können. Dieses Lab ist eine Paarübung.

source ../utils/utils.sh
pre-setup

mkdir -p src test

cat > app.json << 'EOF'
{
  "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "name": "BC Review Demo",
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
rad.json
*.g.xlf
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

post-setup

echo ""
echo "=================================================="
echo "  CODE REVIEW DOJO"
echo "=================================================="
echo ""
echo "Basis-Repository erstellt."
echo ""
echo "Nächste Schritte:"
echo "  1. Erstelle ein Repository auf GitHub/GitLab"
echo "  2. Füge den Remote hinzu:"
echo "     git remote add origin <url>"
echo "  3. Pushe:"
echo "     git push -u origin main"
echo "  4. Lade deinen Partner als Collaborator ein"
