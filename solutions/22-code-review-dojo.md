# Lösung: Lab 22 — Code Review Dojo

Dieses Lab ist eine Paarübung ohne deterministische Lösung. Hier sind
Orientierungshilfen und erwartete Ergebnisse für jede Phase.

## Phase 1: Feature-Branches erstellen

### Person A: `feature/item-discount`

Beispieldatei `src/ItemTableExt.al` — mit absichtlichen Problemen:

```al
tableextension 50101 ItemDiscountExt extends Item
{
    fields
    {
        field(50100; "Special Discount %"; Decimal)
        {
            // Problem 1: ApplicationArea fehlt
            // Problem 2: Keine MinValue/MaxValue-Validierung
        }
    }
}
```

Beispiel für schlechte Commits:

```bash
git add src/ItemTableExt.al
git commit -m "fix"
# ... Änderung ...
git commit -m "update"
# ... Änderung ...
git commit -m "WIP stuff"
```

### Person B: `feature/customer-export`

Beispieldatei `src/CustomerExport.al` — mit absichtlichen Problemen:

```al
codeunit 50110 "Customer Export"
{
    procedure Export()
    var
        FilePath: Text;
    begin
        // Problem 1: Hardcodierter Pfad
        FilePath := 'C:\Temp\export.csv';

        // Problem 2: Kein Fehlerfall wenn keine Daten
        // (Was wenn die Tabelle leer ist?)
    end;
}
```

Unzugehöriger Commit (Version-Bump, der hier nicht hingehört):

```bash
# app.json Version ändern und committen
git commit -m "Bump version to 1.1.0.0"
```

## Phase 2: Pull Requests erstellen

Beispiel-PR-Beschreibung:

```markdown
## Änderungen
- Rabattfeld auf Item-Tabelle hinzugefügt (field 50100)
- Ermöglicht individuelle Rabatte pro Artikel

## Test-Hinweise
- Artikel öffnen → Feld "Special Discount %" sollte sichtbar sein
- Wert eingeben und speichern prüfen

## Offene Punkte
- [ ] Review abwarten
- [ ] Validierung ergänzen
- [ ] ApplicationArea setzen
```

## Phase 3: Code Review

### Erwartete Review-Kommentare für Person A

1. **Inhaltlicher Fehler:** `ApplicationArea` fehlt — Feld wird in SaaS nicht
   sichtbar sein.
2. **Inhaltlicher Fehler:** Keine Validierung — Rabatt könnte negativ oder
   >100% sein. Suggestion:

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

3. **Code-Qualität:** Caption fehlt für Übersetzbarkeit.
4. **Commit-Hygiene:** 3 Commits mit "fix", "update", "WIP" sollten zu einem
   sinnvollen Commit zusammengefasst werden.
5. **Positiv:** Gute Feldnummer (50100er-Bereich), korrekte Tabellenreferenz.

### Erwartete Review-Kommentare für Person B

1. **Inhaltlicher Fehler:** Hardcodierter Pfad — funktioniert nicht auf
   Linux/Cloud. Besser: Konfigurierbar machen oder temporäres Verzeichnis.
2. **Inhaltlicher Fehler:** Kein Fehlerfall — was passiert bei leerer Tabelle?
3. **Code-Qualität:** Pfad als Konstante oder Setup-Feld auslagern.
4. **Commit-Hygiene:** Version-Bump gehört nicht in diesen Feature-Branch.
5. **Positiv:** Saubere Codeunit-Struktur, gute Benennung.

## Phase 4: Feedback einarbeiten

```bash
# Suggestions auf GitHub/GitLab anwenden: "Apply Suggestion" klicken

# Lokale Änderungen bearbeiten und pushen
git add .
git commit -m "Address review feedback"
git push

# Commits aufräumen per Interactive Rebase
git rebase -i origin/master
```

Im Editor z.B.:

```text
pick abc1234 fix
fixup def5678 update
fixup ghi9012 WIP stuff
reword jkl3456 Address review feedback
```

Ergebnis: Ein sauberer Commit mit guter Message.

```bash
# Force-Push nach Rebase (nur eigener Branch!)
git push --force-with-lease
```

## Phase 5: Approve & Merge

Vergleich der Merge-Strategien in `git log --oneline --graph`:

**Squash and Merge:**

```text
* abc1234 (master) Add item discount field with validation (#1)
* def5678 Initial commit
```

→ Alle Commits des Branches werden zu einem einzigen Commit auf master.

**Create a Merge Commit:**

```text
*   abc1234 (master) Merge pull request #2
|\
| * def5678 Add customer export codeunit
| * ghi9012 Add error handling for empty tables
|/
* jkl3456 Initial commit
```

→ Branch-Historie bleibt im Graphen sichtbar.

## Phase 6: Branch Protection (Bonus)

Nach Einrichtung:

- **Direkter Push auf master:** Wird abgelehnt mit
  `remote: error: GH006: Protected branch update failed`.
- **PR ohne Approval:** Merge-Button ist ausgegraut, Meldung
  "Review required".

## Diskussion (Orientierung)

1. **Merge-Strategie:** Squash für kleine Features (saubere master-History),
   Merge Commit für größere Features (Kontext bleibt erhalten).
2. **Review-Kultur:** Kommentare als Fragen formulieren ("Wäre es sinnvoll,
   hier...?"), nicht als Befehle. Immer auch Positives erwähnen.
3. **Branching-Strategie:** Für die meisten Teams ist GitHub Flow der beste
   Einstieg — einfach, PR-basiert, gut mit CI/CD.
