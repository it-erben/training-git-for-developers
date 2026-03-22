# Lab 01: Erste Commits (Terminal)

In dieser Übung lernst du die grundlegendsten Git-Befehle kennen: `git add` und
`git commit`. Damit fügst du Dateien zur Versionskontrolle hinzu und speicherst
Änderungen als sogenannte Commits ab. Außerdem nutzt du `git status` und
`git log`, um jederzeit den Überblick über den Zustand deines Repositories zu
behalten.

## Aufgaben

### Eine neue Datei anlegen und committen

Öffne Visual Studio Code in dem Exercise-Verzeichnis für 
Lab 01 (`labs/01-basic-commits/exercise`).

Lege deine erste Datei an und füge sie dem Repository hinzu. In Git
ist das ein zweistufiger Prozess: Zuerst werden Änderungen mit `git add` in die
sogenannte **Staging Area** aufgenommen, danach mit `git commit` dauerhaft im
Repository gespeichert.

3. Erstelle eine neue Datei.
**Unter macOS und Linux**
```bash
touch meinedatei.txt
```
**Unter Windows in Powershell**
```powershell
ni meinedatei.txt
```
4. Führe `git status` aus. Was hat sich geändert? Die Datei sollte als
   **untracked** angezeigt werden - Git kennt sie noch nicht.
5. Füge die Datei mit `git add meinedatei.txt` zur Staging Area hinzu.
6. Führe erneut `git status` aus. Die Datei sollte jetzt unter 
   **Changes to be committed** erscheinen.
7. Committe die Datei mit `git commit -m "Erste Datei hinzufügen"`.
8. Prüfe mit `git status`, dass das Arbeitsverzeichnis jetzt wieder sauber ist.

### Änderungen an einer bestehenden Datei

Nun änderst du eine bereits versionierte Datei und beobachtest, wie Git damit
umgeht.

9. Ändere den Inhalt deiner Datei:
```bash
echo "Hallo Welt" > meinedatei.txt
```
10. Was zeigt `git status` jetzt an? Die Datei sollte als **modified**
    erscheinen.
11. Füge die Änderung mit `git add` zur Staging Area hinzu.
12. Was zeigt `git status` jetzt?
13. Ändere die Datei **nochmals**, ohne vorher zu committen.
14. Committe jetzt. Was passiert mit der zweiten Änderung? Prüfe mit
    `git status` und `git log`.

> **Wichtig:** Nur das, was in der Staging Area liegt, wird committet.
> Änderungen, die nach dem `git add` gemacht werden, sind **nicht** automatisch
> im nächsten Commit enthalten.

15. Füge die verbleibende Änderung hinzu und erstelle einen weiteren Commit.

## Nützliche Befehle

| Befehl                      | Beschreibung                      |
|-----------------------------|-----------------------------------|
| `git add <datei>`           | Datei zur Staging Area hinzufügen |
| `git commit -m "Nachricht"` | Commit mit Nachricht erstellen    |
| `git status`                | Aktuellen Zustand anzeigen        |
| `git log`                   | Commit-Historie anzeigen          |
| `git log --oneline`         | Kompakte Commit-Historie          |
| `git log --oneline --graph` | Historie mit Graphdarstellung     |
