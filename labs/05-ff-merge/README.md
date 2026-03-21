# Übung 5: Fast-Forward-Merge

Wenn du einen Feature-Branch in einen anderen Branch (z.B. `master`) mergst und auf `master` in der Zwischenzeit keine neuen Commits hinzugekommen sind, kann Git einen sogenannten **Fast-Forward-Merge** durchführen. Dabei wird einfach der Branch-Zeiger von `master` vorgerückt, ohne dass ein zusätzlicher Merge-Commit entsteht. Die Historie bleibt dadurch linear und übersichtlich.

In dieser Übung erstellst du einen Feature-Branch, arbeitest darauf und führst ihn dann per Fast-Forward-Merge in `master` zusammen.

## Vorbereitung

```bash
source setup.sh
```

## Aufgaben

### Feature-Branch erstellen und bearbeiten

1. Erstelle einen neuen Branch mit dem Namen `feature/uppercase`. Schrägstriche in Branch-Namen sind eine gängige Konvention, um Branches thematisch zu gruppieren (z.B. `feature/...`, `bugfix/...`, `hotfix/...`).
2. Wechsle auf diesen Branch.
3. Führe `git status` aus, um zu prüfen, auf welchem Branch du bist.
4. Ändere den Inhalt von `greeting.txt` so, dass die Begrüßung in Großbuchstaben steht.
5. Füge die Änderung zur Staging Area hinzu und erstelle einen Commit.

### Vor dem Merge: Zustand prüfen

6. Welche Branches existieren? (`git branch`)
7. Wie sieht die Historie aus? (`git log --oneline --graph --all`). Du solltest sehen, dass `feature/uppercase` einen Commit vor `master` liegt, während `master` selbst unverändert ist.

### Fast-Forward-Merge durchführen

Der Merge-Befehl `git merge <branch>` übernimmt die Änderungen des angegebenen Branches in den aktuell ausgecheckten Branch. Du musst also zuerst auf den Ziel-Branch wechseln.

8. Wechsle auf den `master`-Branch.
9. Überprüfe den Inhalt von `greeting.txt` - hier steht noch die alte Version.
10. Vergleiche die Branches: `git diff master feature/uppercase`
11. Führe den Merge aus: `git merge feature/uppercase`. Git sollte einen **Fast-Forward** melden.
12. Überprüfe erneut den Inhalt von `greeting.txt` - die Großbuchstaben sollten jetzt auch auf `master` angekommen sein.

### Aufräumen

13. Lösche den Feature-Branch mit `git branch -d feature/uppercase`. Da alle Änderungen bereits in `master` enthalten sind, lässt Git das problemlos zu.

> **Merke:** Ein Fast-Forward-Merge ist nur möglich, wenn der Ziel-Branch seit der Erstellung des Feature-Branches keine eigenen Commits bekommen hat. Sobald beide Branches divergieren, ist ein 3-Way-Merge nötig (nächste Übung).

## Nützliche Befehle

| Befehl | Beschreibung |
|--------|-------------|
| `git branch <name>` | Neuen Branch erstellen |
| `git branch -d <name>` | Branch löschen (nur wenn vollständig gemergt) |
| `git switch <name>` | Branch wechseln |
| `git merge <branch>` | Branch in den aktuellen Branch mergen |
| `git diff <branch1> <branch2>` | Unterschiede zwischen Branches anzeigen |
| `git log --oneline --graph --all` | Gesamte Historie anzeigen |
