# Lab 1: Projekt-Setup und erster Deploy

In dieser Uebung richtest du dein eigenes Business-Central-Projekt ein und
siehst, wie eine CI/CD-Pipeline automatisch deine Anwendung
baut und in eine BC-Sandbox deployt.

## Vorbereitung

Dein Trainer gibt dir:
- Einen **Classroom Invite-Link**
- Deine **Teilnehmernummer** (1-10)

## Phase 1: Repository erstellen

1. Öffne den Invite-Link im Browser und akzeptiere das Assignment.
   GitHub erstellt automatisch ein Repository für dich in der
   Organisation `it-erben`.

2. Warte, bis das Repository erstellt ist. Du siehst dann eine Seite
   mit einem Link zu deinem neuen Repo.

3. Klone das Repository auf deinen Rechner:
   ```bash
   git clone https://github.com/it-erben/bc-dev-training-<dein-username>.git
   cd bc-dev-training-<dein-username>
   ```

4. Schau dir die Projektstruktur an:
   ```bash
   ls -la
   ls app/
   ```
   Du siehst eine AL-Extension mit einer einfachen Tabelle und einer
   Listenseite.

## Phase 2: App personalisieren

5. Führe das Setup-Script mit deiner Teilnehmernummer aus:

   **Bash (macOS/Linux):**
   ```bash
   ./setup.sh <nummer> "Dein Name"
   ```
   **PowerShell (Windows):**
   ```powershell
   bash ./setup.sh <nummer> "Dein Name"
   ```

   Das Script konfiguriert deine App mit eindeutigen IDs, damit sich
   die Teilnehmer nicht gegenseitig in die Quere kommen.

6. Prüfe, was sich geändert hat:
   ```bash
   git diff
   ```
   Du siehst Änderungen in `app/app.json`, den `.al`-Dateien und
   `.AL-Go/settings.json`.

> **Wichtig:** Jeder Teilnehmer bekommt einen eigenen ID-Bereich.
> Das verhindert Konflikte, wenn alle in dieselbe BC-Sandbox deployen.

## Phase 3: Commit und Push

7. Füge alle Aenderungen zur Staging Area hinzu:
   ```bash
   git add -A
   ```

8. Erstelle einen Commit:
   ```bash
   git commit -m "chore: App personalisieren"
   ```

9. Pushe den Commit zum Remote:
   ```bash
   git push
   ```

## Phase 4: Pipeline beobachten

10. Oeffne dein Repository auf GitHub und klicke auf den Tab **Actions**.

11. Du siehst einen laufenden Workflow **CI/CD**. Klicke darauf und
    beobachte die einzelnen Schritte:

    | Schritt | Was passiert | Dauer |
    |---------|-------------|-------|
    | Initialization | AL-Go liest die Konfiguration | ~1 Min |
    | Build | Der AL-Compiler baut deine `.app`-Datei | ~18 Min |
    | Deploy | Die App wird in die BC-Sandbox installiert | ~2 Min |

12. Warte, bis die Pipeline gruen ist (ca. 20 Minuten).

## Phase 5: Ergebnis pruefen

13. Oeffne die BC-Sandbox im Browser:
    ```
    https://businesscentral.dynamics.com
    ```

14. Suche nach deiner **Training Items**-Seite (Suchleiste oder Alt+Q).

15. Du siehst deine leere Liste. Lege testweise ein paar Eintraege an.

Herzlichen Glueckwunsch! Du hast gerade:
- Ein Git-Repository aus einem Template erstellt
- Eine Aenderung committet und gepusht
- Eine automatische CI/CD-Pipeline ausgeloest
- Eine Anwendung in eine Cloud-Umgebung deployt

## Zusammenfassung

| Befehl | Beschreibung |
|--------|-------------|
| `git clone <url>` | Repository klonen |
| `git diff` | Unstaged Aenderungen anzeigen |
| `git add -A` | Alle Aenderungen stagen |
| `git commit -m "..."` | Commit erstellen |
| `git push` | Commits zum Remote senden |
