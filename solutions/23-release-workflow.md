# Lösung: Lab 23 — Release Day

## Phase 1: Bug-Report — git bisect

```bash
git bisect start
git bisect bad HEAD
git bisect good v1.0.0
```

Bei jedem Schritt prüfen, ob `src/Calculator.al` die Zeile
`quantity * unitPrice` (gut) oder `quantity + unitPrice` (schlecht) enthält:

```bash
# Datei prüfen
grep "quantity" src/Calculator.al

# Wenn "quantity * unitPrice" → gut
git bisect good

# Wenn "quantity + unitPrice" → schlecht
git bisect bad
```

Nach ca. 4-5 Schritten findet bisect den schuldigen Commit. Git zeigt:

```text
<hash> is the first bad commit
commit <hash>
    Refactor calculator for clarity
```

```bash
# Session beenden
git bisect reset
```

**Automatisierte Variante:**

```bash
git bisect start HEAD v1.0.0
git bisect run grep -q "quantity \* unitPrice" src/Calculator.al
# grep gibt Exit-Code 0 (gut) wenn gefunden, 1 (schlecht) wenn nicht
git bisect reset
```

**Diskussion:** Bei ~25 Commits braucht bisect maximal log2(25) ≈ 5 Schritte.
Lineare Suche bräuchte bis zu 25 Schritte.

## Phase 2: Bug fixen

```bash
# Calculator.al öffnen und "quantity + unitPrice" durch
# "quantity * unitPrice" ersetzen

git add src/Calculator.al
git commit -m "$(cat <<'EOF'
Fix calculation: use multiplication instead of addition

Introduced in <hash-von-bisect>. Reported by customer.
EOF
)"
```

## Phase 3: Feature-Branch aufräumen

```bash
git switch feature/invoice-export

# Commits anzeigen
git log --oneline master..HEAD
```

Zeigt ca.:

```text
aaa1111 add test maybe
bbb2222 forgot this
ccc3333 bump
ddd4444 asdf
eee5555 fix
fff6666 WIP
```

```bash
git rebase -i master
```

Im Editor:

```text
reword fff6666 WIP
fixup eee5555 fix
reword ddd4444 asdf
drop  ccc3333 bump
fixup bbb2222 forgot this
fixup aaa1111 add test maybe
```

Erklärung:

- `WIP` + `fix` + `forgot this` → ein Commit: "Add invoice export codeunit"
- `asdf` + `add test maybe` → ein Commit: "Add export helper and test"
- `bump` → `drop` (Version-Bump gehört nicht in diesen Feature-Branch)

Danach auf neuesten master-Stand bringen:

```bash
git rebase master
```

Ergebnis prüfen:

```bash
git log --oneline master..HEAD
# Sollte 2-3 saubere Commits zeigen
```

## Phase 4: Release vorbereiten

```bash
# Feature-Branch in master mergen
git switch master
git merge feature/invoice-export

# Release-Branch erstellen
git switch -c release/1.1.0

# Version in app.json bumpen
# "version": "1.0.0.0" → "version": "1.1.0.0"

git add app.json
git commit -m "Bump version to 1.1.0.0"
```

Änderungen seit v1.0.0 anzeigen:

```bash
git log --oneline v1.0.0..release/1.1.0
```

Changelog erstellen:

```bash
git log --pretty=format:"- %s" v1.0.0..release/1.1.0 > CHANGELOG.md
git add CHANGELOG.md
git commit -m "Add CHANGELOG for v1.1.0"
```

## Phase 5: Hotfix unter Druck

```bash
# Hotfix-Branch vom letzten Release erstellen
git switch -c hotfix/v1.0.1 v1.0.0
```

Publisher in `app.json` korrigieren:

```json
"publisher": "Schulung"
```

Version bumpen:

```json
"version": "1.0.0.1"
```

```bash
git add app.json
git commit -m "Fix publisher info and bump to 1.0.0.1"

# Hotfix taggen
git tag -a v1.0.1 -m "Hotfix: fix publisher info"
```

Hotfix-Hash merken, dann in release und master übernehmen:

```bash
HOTFIX_HASH=$(git rev-parse HEAD)

# In Release-Branch cherry-picken
git switch release/1.1.0
git cherry-pick $HOTFIX_HASH
```

**Konflikt in `app.json`:** Die Versionen unterscheiden sich (`1.0.0.1` vs.
`1.1.0.0`). Lösung: Publisher-Fix übernehmen, aber Version `1.1.0.0`
beibehalten.

```bash
# Konflikt in app.json lösen:
# publisher → "Schulung" (vom Hotfix)
# version → "1.1.0.0" (vom Release-Branch)

git add app.json
git cherry-pick --continue
```

```bash
# In master cherry-picken
git switch master
git cherry-pick $HOTFIX_HASH
```

Auch hier Konflikt in `app.json` lösen: Publisher-Fix übernehmen, Version von
master beibehalten.

```bash
git add app.json
git cherry-pick --continue
```

## Phase 6: Release abschließen

```bash
git switch release/1.1.0

# Prüfen, dass Hotfix enthalten ist
grep "publisher" app.json
# → "Schulung"

# Release taggen
git tag -a v1.1.0 -m "Release 1.1.0"

# In master mergen
git switch master
git merge release/1.1.0

# Aufräumen
git branch -d release/1.1.0
git branch -d hotfix/v1.0.1
git branch -d feature/invoice-export

# Endergebnis prüfen
git tag
# → v1.0.0, v1.0.1, v1.1.0

git log --oneline --graph --all
```

## Validierung

| Kriterium | Prüfung |
|-----------|---------|
| Tags vorhanden | `git tag` zeigt v1.0.0, v1.0.1, v1.1.0 |
| Bugfix in master | `grep "quantity \* unitPrice" src/Calculator.al` |
| Hotfix in master | `grep "Schulung" app.json` |
| Hotfix in v1.1.0 | `git show v1.1.0:app.json \| grep publisher` |
| Saubere Commits | `git log --oneline feature/invoice-export` (keine WIP) |
| CHANGELOG existiert | `cat CHANGELOG.md` |
| Branches gelöscht | `git branch` zeigt nur noch `master` |
