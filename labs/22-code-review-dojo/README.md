# Lab 22: Code Review Dojo

## Hintergrund

In diesem Lab durchlauft ihr als Team den vollständigen PR-Workflow auf GitHub
oder GitLab. Ihr arbeitet zu zweit: Jeder erstellt einen Feature-Branch mit
absichtlichen Schwächen, der Partner reviewt ihn. Dabei nutzt ihr die vollen
Möglichkeiten der Plattform: Suggestions, Draft PRs und die verschiedenen
Merge-Strategien.

Dieses Lab verknüpft die technischen Git-Kenntnisse mit der Praxis
kollaborativer Softwareentwicklung.

**Zeitbedarf:** 60 Minuten

## Vorbereitung

1. Bildet Zweierteams.
2. Öffne das Terminal im Verzeichnis `labs/22-code-review-dojo/exercise`.
3. Erstellt ein gemeinsames Repository auf GitHub/GitLab und pusht die Basis:
   ```bash
   cd exercise
   git remote add origin <url>
   git push -u origin main
   ```
4. Ladet den Partner als Collaborator ein.

## Phase 1: Feature-Branches erstellen

Jeder erstellt **einen eigenen** Feature-Branch und implementiert ein kleines
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
  - Fehlender Fehlerfall (was wenn keine Daten?)
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

Wechselt die Rollen. Jeder reviewt den PR des Partners.

**Review-Anforderungen (Minimum):**

1. Mindestens **5 Kommentare** im Code-Diff — davon:
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

3. Schließe das Review mit **"Request Changes"** ab (nicht Approve — es gibt ja
   Probleme).

## Phase 4: Feedback einarbeiten

Arbeitet das Feedback ein:

1. **Suggestions:** Klicke "Apply Suggestion" direkt auf GitHub/GitLab (erstellt
   einen Commit automatisch).
2. **Code-Änderungen:** Lokal bearbeiten, committen und pushen.
3. **Commit-Hygiene:** Nutze Interactive Rebase, um die WIP-Commits aufzuräumen:

   ```bash
   git rebase -i origin/main
   ```

   Squashe die zusammengehörigen Commits, verbessere die Messages. Danach:

   ```bash
   git push --force-with-lease
   ```

4. Antworte auf jeden Review-Kommentar im PR.

## Phase 5: Approve & Merge

1. Der Reviewer prüft die Korrekturen und gibt ein **Approve**.
2. Ändert den PR von Draft auf "Ready for review".
3. **Merge-Strategie wählen** — mergt einen PR mit "Squash and Merge" und den
   anderen mit "Create a Merge Commit".
4. Vergleicht: Wie sieht `git log --oneline --graph` danach jeweils aus?

## Phase 6: Branch Protection (Bonus)

Falls ihr Admin-Rechte habt:

1. Richtet Branch Protection für `main` ein:
   - Require pull request before merging
   - Require 1 approval
   - Require linear history (optional — diskutiert!)
2. Versucht, direkt auf `main` zu pushen. Was passiert?
3. Versucht, einen PR ohne Approval zu mergen. Was passiert?

## Diskussion

1. **Merge-Strategie:** Wann nutzt ihr Squash, wann Merge Commit, wann Rebase?
   Einigt euch auf eine Team-Konvention.
2. **Review-Kultur:** Wie formuliert man Feedback konstruktiv? Was war hilfreich,
   was war zu harsch?
3. **Branching-Strategie:** Welches Modell passt zu euch?
   - GitHub Flow (einfach, PR-basiert)
   - Git Flow (main/develop/feature/release/hotfix)
   - Trunk-Based (kurze Branches, schnelles Mergen)

## Validierung

- Beide PRs sind erfolgreich gemergt.
- Jeder PR hat mindestens 5 Review-Kommentare.
- Mindestens ein PR wurde per Squash gemergt, einer normal.
- Ihr habt eine Team-Konvention für Merge-Strategie und Branching definiert.
