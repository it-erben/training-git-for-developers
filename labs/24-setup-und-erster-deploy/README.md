# Lab 24: Projekt-Setup und erster Deploy

In dieser Übung richtest du dein eigenes Business-Central-Projekt ein und
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

7. Füge alle Änderungen zur Staging Area hinzu:
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

10. Öffne dein Repository auf GitHub und klicke auf den Tab **Actions**.

11. Du siehst einen laufenden Workflow **CI/CD**. Klicke darauf und
    beobachte die einzelnen Schritte:

    | Schritt        | Was passiert                               | Dauer   |
    |----------------|--------------------------------------------|---------|
    | Initialization | AL-Go liest die Konfiguration              | ~1 Min  |
    | Build          | Der AL-Compiler baut deine `.app`-Datei    | ~18 Min |
    | Deploy         | Die App wird in die BC-Sandbox installiert | ~2 Min  |

12. Warte, bis die Pipeline grün ist (ca. 20 Minuten).

## Während du wartest: GitHub entdecken

Die Pipeline braucht ca. 20 Minuten. Nutze die Zeit, um GitHub besser
kennen zu lernen.

### Keyboard Shortcuts

GitHub hat Tastenkürzel für fast alles. Drücke **`?`** auf einer
beliebigen GitHub-Seite, um die vollständige Liste zu sehen.

Probiere diese Shortcuts in deinem Repository aus:

| Shortcut | Wirkung                                   |
|----------|-------------------------------------------|
| `t`      | Dateisuche — tippe einen Dateinamen       |
| `b`      | Blame-Ansicht für die aktuelle Datei      |
| `l`      | Zu einer Zeilennummer springen            |
| `w`      | Branch/Tag wechseln                       |
| `.`      | Repository im Web-Editor (VS Code) öffnen |

### Dein Repository erkunden

1. **Code-Ansicht**: Klicke auf eine Datei (z.B. `app/TrainingItem.Table.al`).
   - Klicke auf eine Zeilennummer — die URL ändert sich. So kannst du
     einen Permalink zu einer bestimmten Zeile teilen.
   - Klicke auf eine zweite Zeilennummer mit **Shift** gedrückt, um
     einen Bereich zu markieren.

2. **Blame**: Klicke auf **Blame** (oder drücke `b`). Du siehst für
   jede Zeile, welcher Commit sie zuletzt geändert hat.

3. **History**: Klicke auf **History** um alle Commits zu sehen, die
   diese Datei verändert haben.

4. **Network Graph**: Gehe zu **Insights** → **Network**. Hier siehst
   du die Branch-Struktur deines Repos grafisch. Momentan ist hier noch nicht
   so viel zu sehen, aber wenn du Lust kannst, kannst du ein paar Branches
   mit kleinen Änderungen pushen um zu sehen, wie hier mehr Graphen erscheinen.

### GitHub CLI ausprobieren

Du hast `gh` schon installiert. Probiere ein paar Befehle:

```bash
# Dein Repository anzeigen
gh repo view

# Die laufende Pipeline beobachten
gh run list
gh run watch
```

> **Tipp:** `gh run watch` zeigt den Fortschritt live im Terminal an —
> praktisch, wenn du nicht ständig den Browser wechseln willst.

## Phase 5: Ergebnis prüfen

13. Öffne mit dem Trainer die BC-Sandbox im Browser:
    ```
    https://businesscentral.dynamics.com
    ```

14. Sucht nach deiner **Training Items**-Seite (Suchleiste oder Alt+Q).

15. Du siehst deine leere Liste. Lege testweise ein paar Einträge an.

Herzlichen Glückwunsch! Du hast gerade:
- Ein Git-Repository aus einem Template erstellt
- Eine Änderung committet und gepusht
- Eine automatische CI/CD-Pipeline ausgelöst
- Eine Anwendung in eine Cloud-Umgebung deployt
