# Lösung: Lab 21 — Parallele Welten

## Phase 1: Detached HEAD reparieren

```bash
# Status prüfen — Git zeigt "HEAD detached at <hash>"
git status

# Zurück auf master wechseln
git switch master
```

**Erklärung:** Im Detached-HEAD-Zustand zeigt HEAD direkt auf einen Commit
statt auf einen Branch. Commits in diesem Zustand wären "schwebend" — sie
gehören zu keinem Branch und werden beim nächsten `gc` gelöscht, wenn man
sie nicht sichert (z.B. mit `git switch -c neuer-branch`).

## Phase 2: Verlorenen Branch wiederherstellen

```bash
# Option A: Im Reflog den letzten Checkout auf feature/analytics finden
git reflog
# Suche nach: "checkout: moving from feature/analytics to master"
# Der Hash DAVOR ist der Tip des gelöschten Branches.

# Option B: Alle Commits durchsuchen (auch verwaiste)
git log --all --oneline
# Suche nach "Add analytics module with reporting and setup"

# Branch wiederherstellen (Hash aus Reflog/Log verwenden)
git switch -c feature/analytics <hash>

# Prüfen
ls src/AnalyticsModule.al src/AnalyticsSetup.al
```

## Phase 3: Feature-Branches mergen

### Branch A: feature/customer-fields

```bash
git switch master
git merge feature/customer-fields
```

**Konflikt in `app.json`:** master hat Version `1.0.1.0` (Patch-Bump),
Branch A hat `1.1.0.0`. Lösung:

```bash
# Konflikt in app.json öffnen und Version auf 1.1.0.0 setzen
# (Branch A hat die höhere Version)

git add app.json
git commit  # Merge-Commit abschließen
```

### Branch B: feature/vendor-page

```bash
git merge feature/vendor-page
```

**Konflikt in `app.json`:** master hat jetzt `1.1.0.0` (von Branch A), Branch B
hat `1.2.0.0`. Lösung:

```bash
# Version auf 1.2.0.0 setzen (oder eine neue, z.B. 1.3.0.0,
# da beide Features jetzt enthalten sind)

git add app.json
git commit
```

### Branch C: feature/analytics — Merge vs. Rebase

```bash
# Kopie für den Vergleich erstellen
git branch feature/analytics-rebase feature/analytics

# Option 1: Direkter Merge
git merge feature/analytics
# → Erzeugt einen Merge-Commit, nicht-linearer Graph

# Option 2: Rebase + Merge
git switch feature/analytics-rebase
git rebase master
# → Commits werden auf den neuesten master-Stand verschoben

git switch master
git merge feature/analytics-rebase
# → Fast-Forward möglich, linearer Graph

# Vergleich
git log --oneline --graph --all
```

**Unterschied:** Merge erzeugt eine Verzweigung im Graphen. Rebase+Merge
ergibt eine gerade Linie, aber die Commit-Hashes ändern sich.

## Phase 4: Fehlerhafte Commits rückgängig machen

```bash
# Fehlerhaften Commit finden
git log --oneline
# Suche nach "Quick fix for base module"

# Revert erstellen
git revert <hash>
```

**Warum `revert` statt `reset`?** Die Commits sind bereits "öffentlich"
(könnten gepusht sein). `reset` würde die Historie umschreiben, was bei
geteilten Branches Probleme verursacht. `revert` erstellt einen neuen Commit,
der die Änderungen rückgängig macht — die Historie bleibt intakt.

## Phase 5: Aufräumen

```bash
# Gemergte Branches löschen
git branch -d feature/customer-fields
git branch -d feature/vendor-page
git branch -d feature/analytics
git branch -d feature/analytics-rebase

# Finalen Graphen prüfen
git log --oneline --graph --all
```

**Unterschied `-d` vs. `-D`:**

- `git branch -d` — Löscht nur, wenn der Branch vollständig gemergt ist
  (sicherer Weg).
- `git branch -D` — Erzwingt das Löschen, auch wenn der Branch nicht gemergt
  wurde (z.B. für abgebrochene Experimente).
