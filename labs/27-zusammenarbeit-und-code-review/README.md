# Lab 4: Zusammenarbeit und Code Review

In dieser Übung arbeitest du mit einem anderen Teilnehmer zusammen.
Ihr reviewt gegenseitig eure Pull Requests und lernt dabei den
Code-Review-Prozess auf GitHub kennen.

## Vorbereitung

Du arbeitest zu zweit. Dein Trainer teilt euch in Paare ein.
Notiere dir den Repository-Namen deines Partners:
`it-erben/bc-dev-training-<partner-username>`

Stelle sicher, dass du auf `main` bist:
```bash
git switch main
git pull
```

## Phase 1: Feature entwickeln

1. Erstelle einen Feature-Branch:
   ```bash
   git switch -c feature/completed-date
   ```

2. Füge der Tabelle ein neues Feld hinzu. Öffne
   `app/TrainingItem.Table.al` und füge nach dem letzten Feld ein:

   ```al
   field(5; "Completed Date"; Date)
   {
       Caption = 'Erledigungsdatum';
   }
   ```

3. Füge das Feld auch in `app/TrainingItems.Page.al` im Repeater hinzu:

   ```al
   field("Completed Date"; Rec."Completed Date")
   {
       ApplicationArea = All;
   }
   ```

4. Committe und pushe:
   ```bash
   git add app/TrainingItem.Table.al app/TrainingItems.Page.al
   git commit -m "feat: add completed date field"
   git push -u origin feature/completed-date
   ```

5. Erstelle einen Pull Request auf GitHub mit einer aussagekräftigen
   Beschreibung. Erkläre **warum** du die Änderung machst, nicht nur
   **was** du geändert hast.

6. Füge deinen Partner als **Reviewer** hinzu (rechte Seite im PR
   unter "Reviewers").

## Während du wartest: Branch Protection und CODEOWNERS

Die Pipeline läuft. Nutze die Wartezeit, um zwei Features
einzurichten, die in echten Teams unverzichtbar sind.

### Branch Protection Rules

Branch Protection verhindert, dass Code ohne Review oder mit
fehlgeschlagener Pipeline in `main` landet.

1. Gehe zu **Settings** → **Branches** → **Add branch ruleset**.

2. Erstelle eine Regel:
   - **Ruleset Name**: `main-protection`
   - **Target branches**: Add target → Include by pattern → `main`
   - **Branch protections** — aktiviere:
     - **Require a pull request before merging** — niemand kann
       direkt auf `main` pushen
     - **Required approvals**: `1` — mindestens ein Reviewer muss
       zustimmen
     - **Require status checks to pass** — die Pipeline muss grün
       sein

3. Klicke **"Create"**. Ab jetzt erzwingt GitHub diesen Workflow.

> **Hinweis:** Da du alleine an deinem Repo arbeitest, kannst du die
> Regel nach dem Lab wieder deaktivieren. In echten Teams ist das
> Standard.

### CODEOWNERS

Die Datei `CODEOWNERS` legt fest, wer automatisch als Reviewer
hinzugefügt wird, wenn bestimmte Dateien geändert werden.

1. Öffne die Datei `CODEOWNERS` in deinem Repository (sie existiert
   bereits im Root-Verzeichnis).

2. Die Syntax ist einfach:
   ```
   # Alles im app-Ordner gehört dir
   /app/ @dein-github-username

   # Workflow-Dateien gehören dem ganzen Team
   /.github/ @it-erben/bc-dev-training
   ```

3. Wenn du die Regel speicherst und jemand eine Datei in `/app/`
   ändert, wirst du automatisch als Reviewer vorgeschlagen.

### GitHub Notifications anpassen

Damit du nicht in Benachrichtigungen untergehst:

1. Klicke auf dein **Profilbild** → **Settings** → **Notifications**.

2. Nützliche Einstellungen:
   - **Participating**: Benachrichtigungen nur für Threads, in denen
     du erwähnt wirst oder die du abonniert hast
   - **Watching**: Für Repos, die du aktiv beobachtest
   - **Email vs. Web**: Wähle, ob du E-Mails bekommst oder nur die
     GitHub-Inbox nutzt

3. Probiere die **GitHub Inbox** aus: Klicke auf das Glocken-Symbol
   oben rechts. Hier kannst du Benachrichtigungen als gelesen markieren,
   speichern oder filtern.

## Phase 2: Code Review durchführen

Jetzt wechselst du die Rolle: Du reviewst den PR deines Partners.

7. Öffne das Repository deines Partners auf GitHub und gehe zu
   **Pull Requests**. Du siehst den PR deines Partners.

8. Klicke auf den PR und dann auf **Files changed**. Hier siehst du
   alle Änderungen als Diff.

9. Führe ein Review durch:
   - Klicke auf eine Zeile, um einen **Kommentar** hinzuzufügen
   - Stelle eine Frage oder mache einen Verbesserungsvorschlag
   - Nutze die "Suggest changes"-Funktion (klicke auf das
     Vorschlags-Symbol im Kommentar-Editor), um eine konkrete
     Code-Änderung vorzuschlagen

10. Schliesse das Review ab: Klicke oben rechts auf
    **"Review changes"** und wähle:
    - **Comment**: Allgemeine Anmerkungen
    - **Approve**: Alles gut, kann gemergt werden
    - **Request changes**: Änderungen nötig vor dem Merge

## Phase 3: Feedback einarbeiten

11. Zurück in deinem eigenen PR: Lies die Review-Kommentare deines
    Partners.

12. Wenn dein Partner eine **Suggestion** gemacht hat, kannst du sie
    direkt auf GitHub übernehmen:
    - Klicke **"Commit suggestion"**
    - Oder arbeite die Änderung lokal ein:
      ```bash
      # Änderung lokal machen
      git add app/TrainingItem.Table.al
      git commit -m "fix: apply review feedback"
      git push
      ```

13. Die Pipeline läuft erneut. Der PR aktualisiert sich automatisch
    mit dem neuen Commit.

## Phase 4: Merge

14. Sobald dein Partner **Approve** gibt und die Pipeline grün ist:
    - Klicke **"Merge pull request"** → **"Confirm merge"**
    - Beobachte die Deploy-Pipeline unter **Actions**

15. Räume lokal auf:
    ```bash
    git switch main
    git pull
    git branch -d feature/completed-date
    ```

16. Prüfe mit dem Trainer in der BC-Sandbox, ob das neue Feld sichtbar ist.
