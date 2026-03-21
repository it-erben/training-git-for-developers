# Übung 14: Rebase - Lineare Historie durch Umbasieren

Beim Mergen entsteht ein Merge-Commit, der die Zusammenführung dokumentiert. Das
ist oft gewünscht, kann bei vielen kleinen Branches aber zu einer
unübersichtlichen Historie mit vielen Verzweigungen führen.

Eine Alternative ist `git rebase`. Beim Rebase werden die Commits eines Branches
**auf die Spitze eines anderen Branches aufgesetzt**, als wären sie dort
entstanden. Das Ergebnis ist eine lineare, aufgeräumte Historie ohne
Merge-Commits.

```
Vorher:                       Nachher:
      C - D  feature                   C' - D'  feature
     /                                /
A - B - E    master          A - B - E           master
```

Beim Rebase werden die Commits `C` und `D` **neu erstellt** (als `C'` und
`D'`) - sie bekommen neue Hashes, weil sie jetzt auf `E` statt auf `B` aufbauen.

> **Wichtig:** Wie bei `git reset` gilt: Rebase verändert die Historie. Verwende
> es nur für lokale Commits, die noch nicht gepusht wurden.

## Vorbereitung

Öffne das Terminal im Verzeichnis `labs/14-rebase-branch/exercise`.

## Aufgaben

### Ausgangszustand

1. Welche Branches existieren? (`git branch`)
2. Schau dir die Historie auf `master` an: `git log --oneline --graph --all`
3. Wechsle auf den Branch `uppercase`.
4. Vergleiche die Historie dieses Branches mit `master`. Wo laufen die Branches
   auseinander?

### Rebase durchführen

5. Rebase deinen `uppercase`-Branch auf `master`:
   ```bash
   git rebase master
   ```
6. Was ist passiert? Schau dir die Historie an:
   `git log --oneline --graph --all`. Die Commits von `uppercase` wurden auf die
   Spitze von `master` aufgesetzt. Es gibt keine Verzweigung mehr.

### Fast-Forward-Merge nach dem Rebase

7. Wechsle auf `master`.
8. Merge `uppercase` in `master`:
   ```bash
   git merge uppercase
   ```
9. Wie sieht die Historie jetzt aus? Da `master` direkt hinter `uppercase` lag,
   hat Git einen **Fast-Forward-Merge** durchgeführt. Das Ergebnis ist eine
   perfekt lineare Historie ohne Merge-Commit.

> **Typischer Workflow:** Viele Teams nutzen das Muster "erst rebasen, dann
> mergen". Dadurch bleibt die Historie auf `master` immer linear und leicht
> nachvollziehbar.

## Nützliche Befehle

| Befehl                            | Beschreibung                                  |
|-----------------------------------|-----------------------------------------------|
| `git rebase <branch>`             | Aktuellen Branch auf einen anderen umbasieren |
| `git switch <branch>`             | Branch wechseln                               |
| `git merge <branch>`              | Branch mergen                                 |
| `git log --oneline --graph --all` | Gesamte Historie anzeigen                     |
