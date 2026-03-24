# Lab 22: Code Review Dojo

## Hintergrund

In diesem Lab durchlauft ihr als Team den vollständigen PR-Workflow auf GitHub.
Ihr arbeitet zu zweit: Jeder erstellt einen Feature-Branch mit absichtlichen
Schwächen, der Partner reviewt ihn. Dabei nutzt ihr die vollen Möglichkeiten
der Plattform: Suggestions, Draft PRs und die verschiedenen Merge-Strategien.

## Vorbereitung

1. Bildet Zweierteams.
2. Akzeptiert die GitHub-Classroom-Einladung. Tretet eurem Team bei oder
   erstellt ein neues.
3. Klont das Repository entweder in VS Code oder über die Kommandozeile:

   ```bash
   git clone <url-aus-classroom>
   cd <repo-name>
   ```

## Phase 1: Feature-Branches erstellen

Alle erstellen **einen eigenen** Feature-Branch und implementieren ein kleines
Feature. Baut dabei **absichtlich** Probleme ein, die der Reviewer finden soll:

### Person A: `feature/item-discount`

- Erstelle `src/ItemTableExt.al` — ein Rabattfeld auf der Item-Tabelle.
- Eingebaute Probleme:
  - `ApplicationArea` fehlt
  - Keine Validierung (Rabatt könnte 999% sein)
  - Schlechte Commit-Messages ("fix", "update", "WIP")
  - Mindestens 3 Commits, die eigentlich einer sein sollten

### Person B: `feature/customer-export`

- Erstelle `src/CustomerExport.al` — eine Export-Funktion.
- Eingebaute Probleme:
  - Hardcodierte Werte statt Konstanten
  - Fehlender Fehlerfall (was, wenn keine Daten?)
  - Ein Commit enthält eine unzugehörige Änderung (z.B. Version-Bump, der hier
    nicht hingehört)

Pusht eure Branches:

```bash
git push -u origin feature/<euer-feature>
```

## Phase 2: Pull Requests erstellen

Erstellt jeweils einen **Draft PR**:

1. Schreibt eine ordentliche PR-Beschreibung:
   - Was wurde geändert?
   - Warum?
   - Offene Punkte als Checkliste

2. Nutzt Markdown:

   ```markdown
   ## Änderungen
   - ...

   ## Test-Hinweise
   - ...

   ## Offene Punkte
   - [ ] Review abwarten
   - [ ] Tests ergänzen
   ```

3. Lasst den PR zunächst als Draft stehen.

## Phase 3: Code Review

Wechselt die Rollen. Alle reviewen den PR des Partners.

**Review-Anforderungen (Minimum):**

1. Mindestens **5 Kommentare** im Code-Diff, zum Beispiel:
   - 2x inhaltliche Fehler (ApplicationArea, Validierung, etc.)
   - 1x Code-Qualität (Naming, Hardcoding, etc.)
   - 1x Commit-Hygiene (Messages, Granularität)
   - 1x Positives Feedback (was ist gut gelöst?)

2. Nutze **Suggestions** für mindestens einen Kommentar:

   ````markdown
   ```suggestion
   field(50100; "Special Discount %"; Decimal)
   {
       ApplicationArea = All;
       MinValue = 0;
       MaxValue = 100;
   }
   ```
   ````

3. Schließe das Review mit **"Request Changes"** ab (nicht Approve - es gibt ja
   Probleme).

## Phase 4: Feedback einarbeiten

Arbeitet das Feedback ein:

1. **Code-Änderungen:** Lokal bearbeiten, committen und pushen.
2. **Commit-Hygiene:** Nutze Interactive Rebase, um die WIP-Commits aufzuräumen.
   Macht danach einen Force-Push.

> Ein Force Push ist hier akzeptabel, weil es sich um einen kurzlebigen
> Feature Branch handelt. Gegen `main` bzw. `master` würden wir niemals
> einen Force Push machen.

3. **Suggestions:** Klicke "Apply Suggestion" direkt auf GitHub (erstellt
   einen Commit automatisch).
4. Antworte auf jeden Review-Kommentar im PR.

## Phase 5: Approve & Merge

1. Der Reviewer prüft die Korrekturen und gibt ein **Approve**.
2. Ändert den PR von Draft auf "Ready for review".
3. **Merge-Strategie wählen** - mergt einen PR mit "Squash and Merge" und den
   anderen mit "Create a Merge Commit".
