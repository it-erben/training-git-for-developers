# Lab 07: Merge-Konflikte lösen (Terminal)

In der vorherigen Übung hat Git die Änderungen zweier Branches automatisch
zusammengeführt, weil sie unterschiedliche Dateien betroffen haben. Aber was
passiert, wenn auf beiden Branches **die gleiche Stelle** in der gleichen Datei
geändert wurde? Dann kann Git nicht automatisch entscheiden, welche Version
korrekt ist, und meldet einen **Merge-Konflikt**.

Konflikte sind kein Fehler - sie sind ein normaler Teil der Zusammenarbeit. In
dieser Übung lernst du, wie du sie erkennst, löst und den Merge abschließt.

## Aufgaben

Öffne das Terminal im Verzeichnis `labs/07-merge-conflict/exercise`.

### Den Konflikt auslösen

1. Du befindest dich auf dem `master`-Branch. Es gibt einen weiteren Branch
   namens `merge-conflict-branch1`, der Änderungen an der gleichen Datei
   enthält. Führe den Merge aus:
   ```bash
   git merge merge-conflict-branch1
   ```
   Git wird melden, dass es einen Konflikt gibt und der automatische Merge
   fehlgeschlagen ist.

### Den Konflikt verstehen

2. Führe `git status` aus. Git zeigt dir an, welche Dateien Konflikte
   enthalten - sie werden als **both modified** markiert.

3. Öffne die betroffene Datei in deinem Editor. Du wirst sogenannte *
   *Konfliktmarker** sehen:
   ```
   <<<<<<< HEAD
   Inhalt aus dem aktuellen Branch (master)
   =======
   Inhalt aus dem gemergten Branch (merge-conflict-branch1)
   >>>>>>> merge-conflict-branch1
   ```
   Der Bereich zwischen `<<<<<<< HEAD` und `=======` enthält deine Version, der
   Bereich zwischen `=======` und `>>>>>>>` enthält die Version aus dem anderen
   Branch.

### Den Konflikt lösen

4. Bearbeite die Datei so, dass sie den gewünschten Inhalt hat. Entferne dabei
   die Konfliktmarker (`<<<<<<<`, `=======`, `>>>>>>>`) vollständig. Du kannst
   eine der beiden Versionen übernehmen, beide kombinieren oder etwas ganz Neues
   schreiben.

5. Folge den Anweisungen von `git status`, um den Merge abzuschließen:
   ```bash
   git add <datei>
   git commit
   ```
   Git erstellt dann den Merge-Commit.

### Ergebnis prüfen

6. Schau dir die Historie an: `git log --oneline --graph`. Du siehst den
   Merge-Commit mit seinen zwei Eltern-Commits.

> **Tipp:** In vielen Editoren und IDEs (z.B. VS Code) gibt es komfortable
> Werkzeuge zum Lösen von Merge-Konflikten, die dir die verschiedenen Versionen
> nebeneinander anzeigen und per Klick übernehmen lassen.

## Nützliche Befehle

| Befehl                      | Beschreibung                                                        |
|-----------------------------|---------------------------------------------------------------------|
| `git merge <branch>`        | Branch mergen                                                       |
| `git status`                | Zeigt konfliktbehaftete Dateien an                                  |
| `git add <datei>`           | Markiert einen Konflikt als gelöst                                  |
| `git commit`                | Schließt den Merge ab                                               |
| `git merge --abort`         | Bricht den Merge ab und stellt den Zustand vor dem Merge wieder her |
| `git log --oneline --graph` | Historie mit Graph anzeigen                                         |
