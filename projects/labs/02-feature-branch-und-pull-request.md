# Lab 2: Feature Branch und Pull Request

In dieser Uebung lernst du den typischen Workflow in einem Team kennen:
Eine Aenderung auf einem eigenen Branch entwickeln, als Pull Request
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

Wir fuegen der Training-Items-Tabelle ein neues Feld hinzu: eine
**Prioritaet**.

1. Erstelle einen neuen Branch:
   ```bash
   git switch -c feature/priority-field
   ```

2. Pruefe, auf welchem Branch du bist:
   ```bash
   git branch
   ```
   Der aktive Branch ist mit `*` markiert.

## Phase 2: Aenderung implementieren

3. Oeffne `app/TrainingItem.Table.al` in deinem Editor und fuege ein
   neues Feld nach dem Feld `Completed` hinzu:

   ```al
   field(4; "Priority"; Option)
   {
       Caption = 'Prioritaet';
       OptionMembers = Low,Medium,High;
       OptionCaption = 'Niedrig,Mittel,Hoch';
   }
   ```

4. Oeffne `app/TrainingItems.Page.al` und fuege das Feld im Repeater
   nach dem Feld `Completed` hinzu:

   ```al
   field(Priority; Rec.Priority)
   {
       ApplicationArea = All;
   }
   ```

5. Pruefe deine Aenderungen:
   ```bash
   git diff
   ```

6. Stage und committe:
   ```bash
   git add app/TrainingItem.Table.al app/TrainingItems.Page.al
   git commit -m "feat: add priority field to Training Items"
   ```

## Phase 3: Push und Pull Request

7. Pushe den Branch zum Remote:
   ```bash
   git push -u origin feature/priority-field
   ```

8. Oeffne dein Repository auf GitHub. Du siehst einen gelben Banner:
   **"feature/priority-field had recent pushes"** mit einem Button
   **"Compare & pull request"**. Klicke darauf.

9. Erstelle den Pull Request:
   - **Title**: `feat: add priority field to Training Items`
   - **Description**: Beschreibe kurz, was du geaendert hast
   - Klicke **"Create pull request"**

## Phase 4: PR-Pipeline beobachten

10. Im Pull Request siehst du unter **Checks** die laufende Pipeline.
    Klicke auf **Details**, um den Fortschritt zu sehen.

11. Beachte: Die PR-Pipeline **baut nur**, sie deployt **nicht**.
    Das ist Absicht — Code soll erst nach dem Review in die Sandbox
    kommen.

> **Frage zum Nachdenken:** Warum ist es sinnvoll, bei Pull Requests
> nur zu bauen und nicht zu deployen?

12. Warte, bis die Pipeline gruen ist.

## Phase 5: Review und Merge

13. In einem echten Team wuerde jetzt jemand deinen Code reviewen.
    Schau dir den Tab **"Files changed"** im PR an — dort siehst du
    deine Aenderungen als Diff.

14. Wenn die Pipeline gruen ist, klicke auf **"Merge pull request"**
    und dann **"Confirm merge"**.

15. Wechsle zum Tab **Actions**. Du siehst eine neue Pipeline fuer den
    `main`-Branch. Diese Pipeline baut **und** deployt.

16. Warte auf den erfolgreichen Deploy und pruefe in der BC-Sandbox,
    ob das Feld **Prioritaet** jetzt in der Training-Items-Liste
    sichtbar ist.

## Phase 6: Lokal aufraeumen

17. Wechsle zurueck auf `main` und hole die Aenderungen:
    ```bash
    git switch main
    git pull
    ```

18. Loesche den Feature-Branch (er ist gemergt und wird nicht mehr
    gebraucht):
    ```bash
    git branch -d feature/priority-field
    ```

## Zusammenfassung

| Befehl | Beschreibung |
|--------|-------------|
| `git switch -c <branch>` | Neuen Branch erstellen und wechseln |
| `git push -u origin <branch>` | Branch zum Remote pushen (mit Tracking) |
| `git switch main` | Zurueck auf main wechseln |
| `git pull` | Aenderungen vom Remote holen |
| `git branch -d <branch>` | Gemergten Branch loeschen |

| GitHub-Konzept | Beschreibung |
|---------------|-------------|
| Pull Request | Vorschlag, Aenderungen in einen Branch zu mergen |
| Checks | Automatische Pipelines, die bei PRs laufen |
| Review | Code-Pruefung durch Teammitglieder |
| Merge | Aenderungen in den Ziel-Branch uebernehmen |
