# Lab 4: Zusammenarbeit und Code Review

In dieser Uebung arbeitest du mit einem anderen Teilnehmer zusammen.
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

2. Fuege der Tabelle ein neues Feld hinzu. Oeffne
   `app/TrainingItem.Table.al` und fuege nach dem letzten Feld ein:

   ```al
   field(5; "Completed Date"; Date)
   {
       Caption = 'Erledigungsdatum';
   }
   ```

3. Fuege das Feld auch in `app/TrainingItems.Page.al` im Repeater hinzu:

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

5. Erstelle einen Pull Request auf GitHub mit einer aussagekraeftigen
   Beschreibung. Erklaere **warum** du die Aenderung machst, nicht nur
   **was** du geaendert hast.

6. Fuege deinen Partner als **Reviewer** hinzu (rechte Seite im PR
   unter "Reviewers").

## Phase 2: Code Review durchfuehren

Jetzt wechselst du die Rolle: Du reviewst den PR deines Partners.

7. Oeffne das Repository deines Partners auf GitHub und gehe zu
   **Pull Requests**. Du siehst den PR deines Partners.

8. Klicke auf den PR und dann auf **Files changed**. Hier siehst du
   alle Aenderungen als Diff.

9. Fuehre ein Review durch:
   - Klicke auf eine Zeile, um einen **Kommentar** hinzuzufuegen
   - Stelle eine Frage oder mache einen Verbesserungsvorschlag
   - Nutze die "Suggest changes"-Funktion (klicke auf das
     Vorschlags-Symbol im Kommentar-Editor), um eine konkrete
     Code-Aenderung vorzuschlagen

10. Schliesse das Review ab: Klicke oben rechts auf
    **"Review changes"** und waehle:
    - **Comment**: Allgemeine Anmerkungen
    - **Approve**: Alles gut, kann gemergt werden
    - **Request changes**: Aenderungen noetig vor dem Merge

## Phase 3: Feedback einarbeiten

11. Zurueck in deinem eigenen PR: Lies die Review-Kommentare deines
    Partners.

12. Wenn dein Partner eine **Suggestion** gemacht hat, kannst du sie
    direkt auf GitHub uebernehmen:
    - Klicke **"Commit suggestion"**
    - Oder arbeite die Aenderung lokal ein:
      ```bash
      # Aenderung lokal machen
      git add app/TrainingItem.Table.al
      git commit -m "fix: apply review feedback"
      git push
      ```

13. Die Pipeline laeuft erneut. Der PR aktualisiert sich automatisch
    mit dem neuen Commit.

## Phase 4: Merge

14. Sobald dein Partner **Approve** gibt und die Pipeline gruen ist:
    - Klicke **"Merge pull request"** → **"Confirm merge"**
    - Beobachte die Deploy-Pipeline unter **Actions**

15. Raeume lokal auf:
    ```bash
    git switch main
    git pull
    git branch -d feature/completed-date
    ```

16. Pruefe in der BC-Sandbox, ob das neue Feld sichtbar ist.

## Diskussion

- Was macht ein gutes Code Review aus?
- Wann sollte man "Request changes" vs. "Approve" waehlen?
- Wie geht man mit Meinungsverschiedenheiten im Review um?
- Welche Regeln koenntest du mit **Branch Protection Rules** erzwingen?
  (z.B. "Mindestens 1 Approval noetig vor Merge")

## Zusammenfassung

| GitHub-Konzept | Beschreibung |
|---------------|-------------|
| Reviewer | Person, die den Code prueft |
| Comment | Anmerkung zu einer Code-Zeile |
| Suggestion | Konkreter Aenderungsvorschlag, direkt uebernehmbbar |
| Approve | Review-Ergebnis: Code ist in Ordnung |
| Request changes | Review-Ergebnis: Aenderungen noetig |
| Branch Protection | Regeln, die Merges an Bedingungen knuepfen |
