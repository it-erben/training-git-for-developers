# Lab 03: .gitignore (Terminal)

Nicht jede Datei gehört ins Repository. Build-Artefakte, temporäre Dateien,
IDE-Konfigurationen oder Abhängigkeiten (z.B. `node_modules/`) sollten von der
Versionskontrolle ausgeschlossen werden. Dafür gibt es die Datei `.gitignore`.

In dieser Übung lernst du, wie du mit `.gitignore` Dateien gezielt von der
Versionsverfolgung ausschließt - und was passiert, wenn eine bereits getrackte
Datei nachträglich ignoriert werden soll.

## Aufgaben

Öffne das Terminal im Verzeichnis `labs/03-ignore/exercise`.

### Dateien per Muster ignorieren

1. Erstelle eine Datei namens `foo.s` (z.B. mit `touch foo.s`).
2. Führe `git status` aus. Die Datei sollte als *untracked* erscheinen.
3. Erstelle eine Datei `.gitignore` im Arbeitsverzeichnis mit dem Inhalt `*.s`.
   Damit werden alle Dateien mit der Endung `.s` ignoriert.
4. Führe `git status` erneut aus. `foo.s` sollte jetzt nicht mehr auftauchen -
   stattdessen wird die neue `.gitignore` als untracked angezeigt.
5. Committe die `.gitignore`-Datei.

### Bereits getrackte Dateien und .gitignore

6. Committe die Datei `file1.txt` (sie ist bereits im Arbeitsverzeichnis
   vorhanden).
7. Füge `*.txt` als neue Zeile in `.gitignore` hinzu, um alle Textdateien zu
   ignorieren.
8. Führe `git status` aus. Was fällt dir auf?
9. Ändere den Inhalt von `file1.txt`.
10. Was zeigt `git status`? Die Änderung wird trotz `.gitignore` angezeigt.

> **Wichtiger Grundsatz:** `.gitignore` wirkt nur auf 
> **neue, noch nicht getrackte Dateien**. Dateien, die bereits einmal committet 
> wurden, werden weiterhin von Git verfolgt - auch wenn ihr Muster 
> nachträglich in `.gitignore` aufgenommen wird.

11. Erstelle eine neue Datei `file2.txt`. Was zeigt `git status`? Diese Datei
    wird ignoriert, weil sie noch nie getrackt wurde.

### Eine Datei aus dem Tracking entfernen

12. Um `file1.txt` aus dem Git-Tracking zu entfernen (aber im Dateisystem zu
    behalten), nutze den Befehl:
    ```bash
    git rm --cached file1.txt
    ```
    Damit wird die Datei aus dem Index (der **Staging Area**) entfernt, bleibt aber
    physisch im Arbeitsverzeichnis erhalten.
13. Was zeigt `git status` jetzt?

### Ausnahmen definieren

14. Erstelle eine neue Datei `file3.txt` und füge die Zeile `!file3.txt` in
    `.gitignore` hinzu. Das Ausrufezeichen `!` negiert die Regel - diese Datei
    soll trotz `*.txt` getrackt werden.

> **Hinweis für zsh-Nutzer:** Der Befehl `echo "!file3.txt" >> .gitignore`
> funktioniert in zsh nicht direkt, weil `!` dort eine Sonderbedeutung hat. Nutze
> stattdessen einen Editor oder escape das Ausrufezeichen:
`echo "\!file3.txt" >> .gitignore`

15. Was zeigt `git status`? Überlege: Wann könnte es sinnvoll sein, eine
    einzelne Datei trotz eines allgemeinen Musters zu tracken? Ein typisches
    Beispiel wäre eine `.env.example`-Datei, die als Vorlage ins Repository
    gehört, während alle anderen `.env`-Dateien ignoriert werden.

## Nützliche Befehle

| Befehl                    | Beschreibung                                                      |
|---------------------------|-------------------------------------------------------------------|
| `git rm --cached <datei>` | Datei aus dem Tracking entfernen, aber im Dateisystem behalten    |
| `git status`              | Überblick über getrackte und ignorierte Dateien                   |
| `git add <datei>`         | Datei stagen (funktioniert auch bei ignorierten Dateien mit `-f`) |
