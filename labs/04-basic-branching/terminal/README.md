# Lab 04: Branching (Terminal)

Branches (Verzweigungen) sind eines der mächtigsten Konzepte in Git. Ein Branch
ist im Grunde nur ein leichtgewichtiger Zeiger auf einen Commit. Dadurch ist das
Erstellen und Wechseln von Branches in Git extrem schnell - ganz anders als in
älteren Versionskontrollsystemen.

In dieser Übung erstellst du eigene Branches, wechselst zwischen ihnen und
beobachtest, wie sich dein Arbeitsverzeichnis dabei verändert.

## Vorbereitung

**Bash**
```bash
bash setup.sh
```

**Powershell**
```
.\setup.ps1
```

## Aufgaben

### Branches erkunden

1. Führe `git branch` aus, um die vorhandenen Branches zu sehen. Es sollten zwei
   Branches existieren.
2. Auf welchem Branch befindest du dich gerade? (Erkennbar am `*` in der
   Ausgabe.)

### Einen neuen Branch erstellen

3. Erstelle einen neuen Branch mit `git branch mybranch`.
4. Führe `git branch` erneut aus. Der neue Branch sollte in der Liste
   auftauchen - aber du bist noch nicht auf diesem Branch.
5. Wechsle mit `git switch mybranch` auf deinen neuen Branch.
6. Wechsle mehrfach zwischen `master` und `mybranch` hin und her. Beobachte, wie
   sich die Ausgabe von `git status` verändert. Was fällt auf, wenn du zwischen
   den Branches wechselst, die unterschiedliche Dateien enthalten?

### Commits auf verschiedenen Branches

7. Stelle sicher, dass du auf `mybranch` bist.
8. Erstelle eine Datei `file1.txt` mit deinem Namen als Inhalt.
9. Füge die Datei hinzu und erstelle einen Commit.
10. Schaue dir die Historie an: `git log --oneline --graph`. Dein neuer Commit
    sollte sichtbar sein und `mybranch` zeigt darauf.
11. Wechsle zurück auf `master`.
12. Führe `git log --oneline --graph` erneut aus. Der Commit, den du auf
    `mybranch` gemacht hast, fehlt hier - er existiert nur auf dem anderen
    Branch.
13. Erstelle eine neue Datei `file2.txt` und committe sie auf `master`.
14. Schau dir die gesamte Historie an: `git log --oneline --graph --all`. Du
    siehst jetzt, dass die beiden Branches unterschiedliche Commits haben und
    auseinanderlaufen.

### Unterschiede zwischen Branches

15. Wechsle zurück auf `mybranch`.
16. Ist `file2.txt` in deinem Arbeitsverzeichnis sichtbar? Warum nicht?
17. Führe `git diff mybranch master` aus, um die Unterschiede zwischen den
    beiden Branches zu sehen.

> **Merke:** Wenn du den Branch wechselst, passt Git dein Arbeitsverzeichnis
> automatisch an den Zustand des jeweiligen Branches an. Dateien erscheinen und
> verschwinden - sie sind aber nicht verloren, sondern existieren auf ihrem
> jeweiligen Branch weiter.

## Nützliche Befehle

| Befehl                            | Beschreibung                             |
|-----------------------------------|------------------------------------------|
| `git branch`                      | Vorhandene Branches auflisten            |
| `git branch <name>`               | Neuen Branch erstellen                   |
| `git switch <name>`               | Auf einen Branch wechseln                |
| `git switch -c <name>`            | Branch erstellen und direkt wechseln     |
| `git log --oneline --graph --all` | Gesamte Historie aller Branches anzeigen |
| `git diff <branch1> <branch2>`    | Unterschiede zwischen Branches anzeigen  |
