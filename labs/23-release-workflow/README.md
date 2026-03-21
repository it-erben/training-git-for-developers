# Lab 23: Release Day

## Hintergrund

Heute ist Release-Tag. Ein Setup-Skript simuliert mehrere Wochen Entwicklung:
Feature-Branches, ein versteckter Bug, unsaubere Commits und ein dringender
Hotfix-Request. Du durchläufst den gesamten Release-Zyklus — und räumst dabei
die Vergangenheit auf.

Dieses Lab ist die Abschlussübung und integriert nahezu alle bisher gelernten
Konzepte: Bisect, Interactive Rebase, Cherry-Pick, Tags, Release-Branches und
Hotfixes.

## Vorbereitung

Öffne das Terminal im Verzeichnis `labs/23-release-workflow/exercise`.

Das Repository enthält:

- ~25 Commits auf `main`, die mehrere Wochen Entwicklung simulieren
- Einem Bug, der irgendwann eingebaut wurde
- Einem Feature-Branch `feature/invoice-export` mit unsauberen Commits
- Dem Tag `v1.0.0` als letzte Release-Version

Verschaffe dir einen Überblick:

```bash
git log --oneline --graph --all
git tag
git branch
```

## Phase 1: Bug-Report — git bisect

Ein Kunde meldet: "Die Berechnung in `src/Calculator.al` ist falsch —
`quantity + unitPrice` statt `quantity * unitPrice`."

Der Bug war in v1.0.0 noch nicht da, ist aber jetzt auf `main` vorhanden.
Irgendwann zwischen Tag `v1.0.0` und `HEAD` wurde er eingebaut.

**Aufgabe:** Finde den schuldigen Commit mit `git bisect`.

1. Starte die Session: `git bisect start`
2. Markiere `HEAD` als schlecht und `v1.0.0` als gut.
3. Bei jedem Schritt: Prüfe `src/Calculator.al`. Steht dort
   `quantity * unitPrice` (gut) oder `quantity + unitPrice` (schlecht)?
4. Notiere den schuldigen Commit (Hash und Message).
5. Beende: `git bisect reset`

**Bonusaufgabe:** Automatisiere den Bisect mit einem Test-Skript:

```bash
git bisect start HEAD v1.0.0
git bisect run grep -q "quantity \* unitPrice" src/Calculator.al
```

**Diskussion:** Wie viele Schritte hast du gebraucht? Wie viele wären es bei
linearer Suche gewesen?

## Phase 2: Bug fixen

Erstelle einen Bugfix direkt auf `main`:

1. Korrigiere `src/Calculator.al` (zurück zu `quantity * unitPrice`).
2. Committe mit einer Message, die auf den schuldigen Commit referenziert:

   ```text
   Fix calculation: use multiplication instead of addition

   Introduced in <hash>. Reported by customer.
   ```

## Phase 3: Feature-Branch aufräumen

Der Branch `feature/invoice-export` hat 5-6 Commits mit Messages wie "WIP",
"fix", "asdf", "forgot file". Bevor du einen PR erstellst, räumst du auf.

**Aufgabe:**

1. Wechsle auf den Branch.
2. Prüfe die Commits: `git log --oneline main..HEAD`
3. Nutze Interactive Rebase:

   ```bash
   git rebase -i main
   ```

4. Im Editor:
   - Squashe zusammengehörige Commits (`fixup` oder `squash`)
   - Benenne WIP-Commits um (`reword`)
   - Entferne den Commit, der offensichtlich nicht dazugehört (`drop`)
5. Aktualisiere den Branch auf den neuesten `main`-Stand (Rebase statt Merge):

   ```bash
   git rebase main
   ```

6. Prüfe das Ergebnis: Saubere, wenige Commits mit guten Messages.

## Phase 4: Release vorbereiten

Der neue Release soll Version 1.1.0 werden.

**Aufgabe:**

1. Merge den aufgeräumten Feature-Branch in `main`.
2. Erstelle einen Release-Branch:

   ```bash
   git switch -c release/1.1.0
   ```

3. Bumpe die Version in `app.json` auf `1.1.0.0`.
4. Prüfe, was seit v1.0.0 passiert ist:

   ```bash
   git log --oneline v1.0.0..release/1.1.0
   ```

5. Erstelle eine `CHANGELOG.md` aus der Git-Historie:

   ```bash
   git log --pretty=format:"- %s" v1.0.0..release/1.1.0
   ```

## Phase 5: Hotfix unter Druck

Während du das Release vorbereitest, meldet ein Kunde einen **kritischen Bug in
v1.0.0**: Der Publisher in `app.json` ist falsch. Das muss sofort gepatcht
werden — auf der Live-Version.

**Aufgabe:**

1. Erstelle einen Hotfix-Branch von `v1.0.0`:

   ```bash
   git switch -c hotfix/v1.0.1 v1.0.0
   ```

2. Korrigiere den Publisher und bumpe die Version auf `1.0.0.1`.
3. Committe und tagge:

   ```bash
   git tag -a v1.0.1 -m "Hotfix: fix publisher info"
   ```

4. Cherry-Picke den Fix in den Release-Branch:

   ```bash
   git switch release/1.1.0
   git cherry-pick <hash>
   ```

5. Cherry-Picke den Fix auch in `main`:

   ```bash
   git switch main
   git cherry-pick <hash>
   ```

6. Löse eventuelle Konflikte (die Versionen unterscheiden sich — behalte
   jeweils die Version des Zielbranches, aber übernimm den Fix).

## Phase 6: Release abschließen

1. Wechsle zum Release-Branch.
2. Prüfe, dass der Hotfix enthalten ist.
3. Setze den Release-Tag:

   ```bash
   git tag -a v1.1.0 -m "Release 1.1.0"
   ```

4. Merge den Release-Branch in `main`.
5. Räume auf:

   ```bash
   git branch -d release/1.1.0
   git branch -d hotfix/v1.0.1
   ```

6. Prüfe das Endergebnis:

   ```bash
   git tag
   git log --oneline --graph --all
   ```
