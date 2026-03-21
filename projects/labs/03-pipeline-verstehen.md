# Lab 3: Die CI/CD Pipeline verstehen

In dieser Übung schaust du unter die Haube der Pipeline. Du lernst,
wie GitHub Actions Workflows aufgebaut sind, was die einzelnen Schritte
tun und wie du Fehler in der Pipeline erkennst und behebst.

## Vorbereitung

Du arbeitest im Repository aus Lab 1 und 2. Stelle sicher, dass du
auf dem `main`-Branch bist:

```bash
git switch main
git pull
```

## Phase 1: Workflow-Dateien erkunden

1. Schau dir die Workflow-Dateien an:
   ```bash
   ls .github/workflows/
   ```
   Du siehst ca. 20 YAML-Dateien. Diese stammen aus Microsofts
   [AL-Go for GitHub](https://github.com/microsoft/AL-Go) Template —
   einem vorgefertigten CI/CD-Framework speziell für
   Business-Central-Projekte. Für uns sind nur drei davon relevant:

   | Datei                       | Zweck                                     |
   |-----------------------------|-------------------------------------------|
   | `CICD.yaml`                 | Hauptpipeline: Build + Deploy bei Push/PR |
   | `PullRequestHandler.yaml`   | Pipeline für Pull Requests                |
   | `PublishToEnvironment.yaml` | Manuelles Deployment                      |

2. Öffne `CICD.yaml` in deinem Editor und suche nach dem Trigger-Block:
   ```bash
   head -20 .github/workflows/CICD.yaml
   ```
   Du siehst `on: push` und `on: workflow_dispatch`. Das bedeutet:
   - Die Pipeline startet automatisch bei jedem Push
   - Sie kann auch manuell ausgelöst werden

3. Öffne die AL-Go Konfiguration:
   ```bash
   cat .AL-Go/settings.json
   ```
   Hier steht, welches Land (`country`), welche App-Ordner
   (`appFolders`) und welche Umgebung (`environments`) genutzt werden.

## Phase 2: Einen Build-Fehler provozieren

Jetzt erzeugst du absichtlich einen Fehler, um zu lernen, wie die
Pipeline-Logs zu lesen sind.

4. Erstelle einen neuen Branch:
   ```bash
   git switch -c experiment/break-the-build
   ```

5. Öffne `app/TrainingItem.Table.al` und füge einen Syntaxfehler ein.
   Ändere z.B. `table` zu `taable`:
   ```al
   taable 50100 "Training Item"
   ```

6. Committe und pushe:
   ```bash
   git add app/TrainingItem.Table.al
   git commit -m "experiment: break the build"
   git push -u origin experiment/break-the-build
   ```

7. Öffne **Actions** auf GitHub und beobachte die Pipeline.
   Nach ca. 18 Minuten wird der **Build**-Schritt fehlschlagen.

## Während du wartest: GitHub Search und CLI

Der Build braucht wieder ~18 Minuten. Nutze die Zeit für zwei
praktische Werkzeuge: GitHub Code Search und die `gh` CLI.

### GitHub Code Search

GitHub hat eine gute eingebaute Suche. Klicke auf die
Suchleiste oben (oder drücke `/`) und probiere diese Suchen aus:

1. **Im eigenen Repo suchen:**
   ```
   repo:it-erben/bc-dev-training-<dein-username> Caption
   ```
   Findet alle Stellen, an denen `Caption` vorkommt.

2. **Nach Dateityp filtern:**
   ```
   repo:it-erben/bc-dev-training-<dein-username> language:al field
   ```
   Findet nur AL-Dateien mit dem Wort `field`.

3. **In der ganzen Organisation suchen:**
   ```
   org:it-erben TrainingItem
   ```
   Findet die Datei in allen Repos der Teilnehmer.

4. **Nach Pfad filtern:**
   ```
   org:it-erben path:.github/workflows CICD
   ```
   Findet Workflow-Dateien in allen Repos.

> **Tipp:** Die vollständige Suchsyntax findest du unter
> **github.com/search/advanced** oder in der
> [Dokumentation](https://docs.github.com/en/search-github).

### gh CLI für Fortgeschrittene

Probiere diese Befehle aus, die im Alltag ziemlich praktisch sind:

```bash
# Alle Workflow-Runs anzeigen
gh run list

# Den aktuell laufenden Run live beobachten
gh run watch

# Details eines bestimmten Runs anzeigen
gh run view <run-id>

# Alle PRs auflisten (auch geschlossene)
gh pr list --state all

# Einen PR im Browser öffnen
gh pr view --web
```

### Blame und History auf der Kommandozeile

```bash
# Wer hat welche Zeile zuletzt geändert?
git blame app/TrainingItem.Table.al

# Alle Commits für eine bestimmte Datei
git log --oneline app/TrainingItem.Table.al

# Änderungen zwischen Branches vergleichen
git diff main...experiment/break-the-build
```

> **Tipp:** Die gleiche Vergleichsansicht gibt es auf GitHub als URL:
> `github.com/<repo>/compare/main...experiment/break-the-build`

## Phase 3: Fehler-Logs lesen

8. Klicke auf den fehlgeschlagenen Workflow-Run und dann auf den
   fehlgeschlagenen Job **Build**.

9. Scrolle durch die Logs und suche nach Zeilen mit einem roten
   Fehler-Symbol. Du findest den Kompilierungsfehler mit der
   Zeilennummer und einer Beschreibung.

> **Tipp:** In den Logs kannst du die Suchfunktion (Ctrl+F / Cmd+F)
> nutzen und nach `##[error]` suchen, um Fehler schnell zu finden.

10. Du kannst die Logs auch über die Kommandozeile prüfen:
    ```bash
    gh run list --limit 1
    gh run view <run-id> --log-failed
    ```

## Phase 4: Fehler beheben

11. Mache den Syntaxfehler rückgängig — ändere `taable` zurück
    zu `table`.

12. Committe und pushe den Fix:
    ```bash
    git add app/TrainingItem.Table.al
    git commit -m "fix: correct syntax error"
    git push
    ```

13. Beobachte die Pipeline erneut. Diesmal sollte der Build
    durchlaufen.

## Phase 5: Aufräumen

14. Dieser Branch war nur ein Experiment. Wechsle zurück auf `main`
    und lösche den Branch:
    ```bash
    git switch main
    git push origin --delete experiment/break-the-build
    git branch -D experiment/break-the-build
    ```
