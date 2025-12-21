# Übung 17: Tags – Commits markieren

Tags sind benannte Markierungen, die auf einen bestimmten Commit zeigen. Anders
als Branches bewegen sich Tags nicht weiter – sie bleiben immer auf dem gleichen
Commit stehen. Damit eignen sie sich perfekt, um Release-Versionen oder andere
wichtige Meilensteine zu kennzeichnen.

Es gibt zwei Arten von Tags:

- **Lightweight Tags** (leichtgewichtig): Nur ein Name, der auf einen Commit
  zeigt – wie ein Branch, der sich nicht bewegt.
- **Annotated Tags** (annotiert): Enthalten zusätzlich den Namen des Erstellers,
  das Datum und eine Nachricht. Sie werden als eigenständige Git-Objekte
  gespeichert und sind die empfohlene Variante für Releases.

## Vorbereitung

Öffne das Terminal im Verzeichnis `labs/17-git-tag/exercise`.

## Aufgaben

### Vorhandene Tags anzeigen

1. Zeige alle vorhandenen Tags an:
   ```bash
   git tag
   ```
   Es sollten bereits einige Tags vorhanden sein.

### Einen neuen annotierten Tag erstellen

2. Erstelle einen neuen Commit (z.B. eine kleine Änderung an einer Datei).
3. Erstelle einen annotierten Tag für diesen Commit:
   ```bash
   git tag -a v2.0.0 -m "Release Version 2.0.0"
   ```
   Die Option `-a` steht für "annotated", `-m` setzt die Tag-Nachricht direkt.

### Einen Tag an einen beliebigen Commit setzen

4. Du kannst Tags auch nachträglich an ältere Commits setzen. Finde mit
   `git log --oneline` den Hash eines früheren Commits und tagge ihn:
   ```bash
   git tag -a v0.1.0 <sha> -m "Erste Vorabversion"
   ```

### Tag-Informationen anzeigen

5. Das Repository enthält einen annotierten Tag. Finde heraus, welche Nachricht
   er hat:
   ```bash
   git show <tagname>
   ```
   Bei annotierten Tags zeigt `git show` den Ersteller, das Datum, die Nachricht
   und den zugehörigen Commit.

### Tags löschen

6. Lösche einen oder mehrere Tags, die nicht mehr gebraucht werden:
   ```bash
   git tag -d <tagname>
   ```

> **Hinweis:** Tags werden beim normalen `git push` nicht automatisch zum Remote
> übertragen. Um Tags zu pushen, verwendet man `git push --tags` oder
`git push origin <tagname>`.

## Nützliche Befehle

| Befehl                             | Beschreibung                    |
|------------------------------------|---------------------------------|
| `git tag`                          | Alle Tags auflisten             |
| `git tag <name>`                   | Lightweight Tag erstellen       |
| `git tag -a <name> -m "..."`       | Annotierten Tag erstellen       |
| `git tag -a <name> <sha> -m "..."` | Tag an bestimmten Commit setzen |
| `git tag -d <name>`                | Tag löschen                     |
| `git show <tag>`                   | Tag-Details anzeigen            |
| `git push --tags`                  | Alle Tags zum Remote pushen     |
