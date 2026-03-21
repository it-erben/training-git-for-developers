# Übung 10: Dateien wiederherstellen mit git restore

Fehler passieren: Du hast eine Datei versehentlich geändert, versehentlich
gestaged, oder möchtest eine Datei auf einen früheren Stand zurücksetzen. Der
Befehl `git restore` ist das moderne Werkzeug dafür. Er wurde in Git 2.23
eingeführt und ersetzt den früheren (und verwirrend überladenen) `git checkout`
-Befehl für diese Anwendungsfälle.

`git restore` hat drei Hauptanwendungen:

- **Änderungen im Working Directory verwerfen:** `git restore <datei>` setzt die
  Datei auf den Stand der Staging Area zurück.
- **Staging rückgängig machen:** `git restore --staged <datei>` entfernt die
  Datei aus der Staging Area, ohne das Working Directory zu verändern.
- **Datei auf einen bestimmten Stand zurücksetzen:**
  `git restore -s <commit/tag> <datei>` stellt die Datei aus einem bestimmten
  Commit oder Tag wieder her.

## Aufgaben

Öffne das Terminal im Verzeichnis `labs/10-restore/exercise`.

### Änderungen im Working Directory verwerfen

1. Führe `git status` aus. Welche Änderungen wurden im Repository vorgenommen?
   Es sollte modifizierte und gestaged Dateien geben.
2. Stelle `foo.txt` mit `git restore foo.txt` wieder her. Damit werden die
   lokalen Änderungen an dieser Datei verworfen.
3. Führe `git status` erneut aus. Was ist mit `foo.txt` passiert? Die Datei
   sollte nicht mehr als modifiziert angezeigt werden.

### Staging rückgängig machen

4. Die Datei `bar.txt` hat gestagte Änderungen. Entferne sie aus der Staging
   Area mit:
   ```bash
   git restore --staged bar.txt
   ```
5. Führe `git status` aus. Was hat sich geändert? Die Änderung ist jetzt nur
   noch im Working Directory, nicht mehr gestaged.
6. Stelle auch `bar.txt` mit `git restore bar.txt` wieder her, um die Änderung
   komplett zu verwerfen.
7. Prüfe mit `git status`, dass das Arbeitsverzeichnis wieder sauber ist.

### Datei auf einen früheren Stand zurücksetzen

8. Führe `git log --oneline` aus. Fällt dir ein Tag auf?
9. Stelle den Inhalt von `foo.txt` auf den Stand des Tags `v1.0.0` zurück:
   ```bash
   git restore -s v1.0.0 foo.txt
   ```
   Damit wird die Datei im Working Directory auf den Stand dieses Tags gesetzt,
   ohne den Branch oder die Historie zu verändern.
10. Führe `git status` aus. Die Datei erscheint als modifiziert, weil ihr Inhalt
    jetzt vom aktuellen Commit abweicht. Du könntest diese Änderung jetzt stagen
    und committen, wenn du den alten Stand dauerhaft wiederherstellen möchtest.

> `git restore` ist ein risikoloses Werkzeug - es verändert keine
> Commits und keine Historie. Es arbeitet ausschließlich auf dem Working
> Directory und der Staging Area.

## Nützliche Befehle

| Befehl                         | Beschreibung                                           |
|--------------------------------|--------------------------------------------------------|
| `git restore <datei>`          | Änderungen im Working Directory verwerfen              |
| `git restore --staged <datei>` | Staging rückgängig machen                              |
| `git restore -s <ref> <datei>` | Datei aus einem bestimmten Commit/Tag wiederherstellen |
| `git status`                   | Aktuellen Zustand anzeigen                             |
| `git log --oneline`            | Kompakte Historie                                      |
