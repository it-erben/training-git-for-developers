# Lab 25: Feature Branch und Pull Request

In dieser Übung lernst du den typischen Workflow in einem Team kennen:
Eine Änderung auf einem eigenen Branch entwickeln, als Pull Request
einreichen und nach einem Review mergen. Du beobachtest dabei, wie die
Pipeline bei einem PR nur baut (ohne Deploy) und erst nach dem Merge
in den `main`-Branch automatisch deployt.

## Vorbereitung

Du arbeitest im Repository aus Lab 1. Stelle sicher, dass du auf dem
`main`-Branch bist und alles aktuell ist:

```bash
git switch main
git pull
```

## Phase 1: Feature Branch erstellen

Wir fügen der Training-Items-Tabelle ein neues Feld hinzu: eine
**Priorität**.

1. Erstelle einen neuen Branch:
   ```bash
   git switch -c feature/priority-field
   ```

## Phase 2: Änderung implementieren

2. Öffne `app/TrainingItem.Table.al` in deinem Editor und füge ein
   neues Feld nach dem Feld `Completed` hinzu:

   ```al
   field(4; "Priority"; Option)
   {
       Caption = 'Prioritaet';
       OptionMembers = Low,Medium,High;
       OptionCaption = 'Niedrig,Mittel,Hoch';
   }
   ```

3. Öffne `app/TrainingItems.Page.al` und füge das Feld im Repeater
   nach dem Feld `Completed` hinzu:

   ```al
   field(Priority; Rec.Priority)
   {
       ApplicationArea = All;
   }
   ```

4. Prüfe deine Änderungen:
   ```bash
   git diff
   ```

5. Stage und committe:
   ```bash
   git add app/TrainingItem.Table.al app/TrainingItems.Page.al
   git commit -m "feat: add priority field to Training Items"
   ```

## Phase 3: Push und Pull Request

6. Pushe den Branch zum Remote:
   ```bash
   git push -u origin feature/priority-field
   ```

7. Öffne dein Repository auf GitHub. Du siehst einen gelben Banner:
   **"feature/priority-field had recent pushes"** mit einem Button
   **"Compare & pull request"**. Klicke darauf.

8. Erstelle den Pull Request:
   - **Title**: `feat: add priority field to Training Items`
   - **Description**: Beschreibe kurz, was du geändert hast
   - Klicke **"Create pull request"**

## Phase 4: PR-Pipeline beobachten

9. Im Pull Request siehst du unter **Checks** die laufende Pipeline.
    Klicke auf **Details**, um den Fortschritt zu sehen.

10. Beachte: Die PR-Pipeline **baut nur**, sie deployt **nicht**.
    Das ist Absicht — Code soll erst nach dem Review in die Sandbox
    kommen.

11. Warte, bis die Pipeline grün ist.

## Während du wartest: Issues und Project Boards

Du hast gerade deinen ersten PR erstellt. In einem echten Projekt
würde dieser PR oft auf ein **Issue** verweisen — eine Aufgabe oder
einen Bug, der damit gelöst wird. Viele Unternehmen setzen dafür Jira
oder andere Tracker ein. GitHub hat aber auch eine eingebaute Lösung.
Nutze die Wartezeit, um das auszuprobieren.

### Ein Issue erstellen

1. Gehe in deinem Repository zum Tab **Issues** und klicke
   **"New issue"**.

2. Erstelle ein Issue:
   - **Title**: `feat: Fälligkeitsdatum für Training Items`
   - **Description**: Beschreibe kurz, warum das Feature sinnvoll wäre

3. Auf der rechten Seite kannst du das Issue konfigurieren:
   - **Labels**: Klicke auf **Labels** und erstelle ein neues Label
     `enhancement` (falls nicht vorhanden)
   - **Milestone**: Erstelle einen Milestone `v1.0` und weise das
     Issue zu

4. Merke dir die Issue-Nummer (z.B. `#2`).

### Issues mit Commits verknüpfen

Git und GitHub haben eine Verbindung: Bestimmte Schlüsselwörter
in Commit-Messages oder PR-Beschreibungen schließen Issues automatisch.

| Schlüsselwort | Wirkung                      |
|---------------|------------------------------|
| `closes #2`   | Schließt Issue #2 beim Merge |
| `fixes #2`    | Schließt Issue #2 beim Merge |
| `resolves #2` | Schließt Issue #2 beim Merge |
| `refs #2`     | Verlinkt nur, schließt nicht |

> **Tipp:** Du kannst das gleich in Lab 4 ausprobieren, wenn du das
> Issue "Fälligkeitsdatum" dort mit `closes #2` im PR schließt.

### GitHub Projects

1. Gehe zum Tab **Projects** in deinem Repository und klicke
   **"Link a project"** → **"New project"**.

2. Wähle **Board** als Layout. Du bekommst ein Kanban-Board mit
   Spalten wie *Todo*, *In Progress*, *Done*.

3. Füge dein Issue dem Board hinzu (über **"+ Add item"** im Board).

4. Ziehe das Issue von *Todo* nach *In Progress* - das ist der
   Workflow, den Teams nutzen würden.

## Phase 5: Review und Merge

13. In einem echten Team würde jetzt jemand deinen Code reviewen.
    Schau dir den Tab **"Files changed"** im PR an — dort siehst du
    deine Änderungen als Diff.

14. Wenn die Pipeline grün ist, klicke auf **"Merge pull request"**
    und dann **"Confirm merge"**.

15. Wechsle zum Tab **Actions**. Du siehst eine neue Pipeline für den
    `main`-Branch. Diese Pipeline baut **und** deployt.

16. Warte auf den erfolgreichen Deploy und prüfe in der BC-Sandbox,
    ob das Feld **Priorität** jetzt in der Training-Items-Liste
    sichtbar ist.

## Phase 6: Lokal aufräumen

17. Wechsle zurück auf `main` und hole die Änderungen:
    ```bash
    git switch main
    git pull
    ```

18. Lösche den Feature-Branch (er ist gemergt und wird nicht mehr
    gebraucht):
    ```bash
    git branch -d feature/priority-field
    ```
