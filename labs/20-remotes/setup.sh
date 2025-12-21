#!/usr/bin/env bash
source ../utils/utils.sh
pre-setup

# --- Lokales Repo mit Inhalt ---
cat > README.md << 'EOF'
# Mein Projekt

Ein Beispiel-Repository zum Lernen von Git Remotes.
EOF

git add README.md
git commit -m "Initial commit: add README"

echo "hello world" > greeting.txt
git add greeting.txt
git commit -m "Add greeting file"

echo "version: 1.0" > config.txt
git add config.txt
git commit -m "Add config file"

post-setup

# --- Bare-Remote aus exercise erstellen ---
cd ..
rm -rf remote.git kollege
git clone --bare exercise remote.git 2>/dev/null

# --- Lokales Repo mit Remote verbinden ---
cd exercise
git remote add origin ../remote.git

# --- Kollegen-Klon erstellen ---
cd ..
git clone remote.git kollege 2>/dev/null

echo ""
echo "=================================================="
echo "  REMOTES LAB"
echo "=================================================="
echo ""
echo "  Lokales Repo:    exercise/"
echo "  Bare Remote:     remote.git/"
echo "  Kollegen-Klon:   kollege/"
echo ""
echo "  Der Remote 'origin' ist bereits konfiguriert."
echo "=================================================="
