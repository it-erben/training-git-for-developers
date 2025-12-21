# Übung 6: 3-Way-Merge

In der vorherigen Übung hast du einen Fast-Forward-Merge durchgeführt – das war möglich, weil sich nur ein Branch weiterentwickelt hat. In der Praxis passiert es aber häufig, dass **beide Branches** parallel weiterentwickelt werden. In diesem Fall muss Git einen **3-Way-Merge** durchführen.

Beim 3-Way-Merge betrachtet Git drei Punkte: den gemeinsamen Vorfahren beider Branches, den aktuellen Stand des einen Branches und den aktuellen Stand des anderen Branches. Daraus entsteht ein neuer **Merge-Commit**, der die Änderungen beider Branches vereint.

## Vorbereitung

```bash
source setup.sh
```

## Aufgaben

### Zwei Branches parallel weiterentwickeln

1. Erstelle einen neuen Branch `greeting` und wechsle darauf.
2. Ändere den Inhalt von `greeting.txt` – schreibe deine Lieblingsbegrüßung hinein.
3. Füge die Änderung zur Staging Area hinzu und committe sie.
4. Wechsle zurück auf `master`.

Jetzt erstellen wir auch auf `master` einen Commit, sodass die beiden Branches auseinanderlaufen:

5. Erstelle eine neue Datei `README.md` mit einer kurzen Beschreibung des Repositories.
6. Füge die Datei hinzu und committe sie.

### Die divergierte Historie betrachten

7. Führe `git log --oneline --graph --all` aus. Du solltest sehen, dass die beiden Branches nach dem gemeinsamen Ausgangscommit in unterschiedliche Richtungen laufen – jeder hat eigene Commits.
8. Vergleiche die Branches mit `git diff master greeting`.

### 3-Way-Merge durchführen

9. Stelle sicher, dass du auf `master` bist, und führe den Merge aus: `git merge greeting`.

   Git wird automatisch einen Merge-Commit erstellen und einen Editor öffnen, in dem du die Commit-Nachricht anpassen kannst (Standard: "Merge branch 'greeting'"). Bestätige die Nachricht.

10. Schau dir die Historie erneut an: `git log --oneline --graph --all`. Du siehst jetzt den typischen "Diamanten" in der Graphdarstellung: Die Branches laufen auseinander und kommen durch den Merge-Commit wieder zusammen.

> **Merke:** Anders als beim Fast-Forward-Merge entsteht beim 3-Way-Merge immer ein zusätzlicher Merge-Commit. Dieser Commit hat **zwei Eltern-Commits** (parent commits) und dokumentiert, wann und wo die Zusammenführung stattgefunden hat.

## Nützliche Befehle

| Befehl | Beschreibung |
|--------|-------------|
| `git switch -c <name>` | Neuen Branch erstellen und wechseln |
| `git merge <branch>` | Branch mergen |
| `git diff <branch1> <branch2>` | Unterschiede anzeigen |
| `git log --oneline --graph --all` | Historie mit Graph anzeigen |
| `git branch -d <name>` | Branch nach dem Merge löschen |
