# Lab 2: Feature Branch und Pull Request

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
