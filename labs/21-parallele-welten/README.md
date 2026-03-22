# Lab 21: Parallele Welten

## Hintergrund

Du erbst ein Repo, an dem vier Kollegen gleichzeitig gearbeitet haben - und dann
ist alles liegen geblieben. Branches überall, Konflikte vorprogrammiert, ein
Branch versehentlich gelöscht, und irgendjemand hat den HEAD verloren. Dein Job:
Ordnung schaffen.

Dieses Lab integriert die Konzepte aus den vorherigen Übungen zu Branching,
Merging, Rebase, Revert und Reflog in einem realistischen Szenario.

**Zeitbedarf:** 75 Minuten

## Vorbereitung

Öffne das Terminal im Verzeichnis `labs/21-parallele-welten/exercise`.

Verschaffe dir sofort einen Überblick:

```bash
git log --oneline --graph --all --decorate
git branch -a
git status
git reflog
```

Zeichne dir den Branch-Graphen auf Papier.

## Phase 1: Detached HEAD reparieren

Du landest nach dem Setup in einem seltsamen Zustand.

**Aufgabe:**

1. Finde heraus, was "Detached HEAD" bedeutet und wo du gerade stehst.
2. Wechsle zurück auf `master`.
3. Was wäre passiert, wenn du in diesem Zustand Commits gemacht hättest?

> Im Detached-HEAD-Zustand zeigt HEAD direkt auf einen Commit
> statt auf einen Branch. Neue Commits wären "schwebend" und könnten verloren
> gehen, sobald du den Branch wechselst.

## Phase 2: Verlorenen Branch wiederherstellen

Der Branch `feature/analytics` wurde versehentlich gelöscht. Die Arbeit darin
war wichtig.

**Aufgabe:**

1. Finde den letzten Commit des gelöschten Branches. Du hast zwei Werkzeuge:
   `git reflog` und `git log --all`.
2. Erstelle den Branch neu auf diesem Commit.
3. Prüfe, ob die Dateien wieder da sind.

> **Tipp:** Im Reflog findest du alle HEAD-Bewegungen — auch die, die vor dem
> Löschen des Branches stattfanden.

## Phase 3: Feature-Branches mergen

Es gibt drei Feature-Branches, die in `master` integriert werden müssen. Jeder
bringt eigene Herausforderungen:

### Branch A: `feature/customer-fields`

- Ändert `app.json` (Version) und `src/CustomerListExt.al`
- **Erwartung:** Merge-Konflikt in `app.json`

**Aufgabe:** Merge in `master` und löse die Konflikte.

### Branch B: `feature/vendor-page`

- Ändert ebenfalls `app.json` (Version) und fügt neue Dateien hinzu.
- **Erwartung:** Erneut Konflikt in `app.json`, da du gerade die Version beim
  Merge von Branch A gesetzt hast.

**Aufgabe:** Merge in `master`. Entscheide: Welche Version soll `app.json` jetzt
bekommen?

### Branch C: `feature/analytics` (der wiederhergestellte)

- Basiert auf einem älteren Stand von `master`.

**Aufgabe:** Hier hast du die Wahl:

- **Option 1:** Direkt mergen → ergibt einen Merge-Commit
- **Option 2:** Erst rebasen, dann mergen → ergibt eine lineare Historie

Probiere **beide Optionen** aus:

1. Erstelle eine Kopie des Branches:

   ```bash
   git branch feature/analytics-rebase feature/analytics
   ```

2. Merge die eine Kopie direkt.
3. Rebase die andere Kopie auf `master` und merge dann.
4. Vergleiche die Graphen.

## Phase 4: Fehlerhafte Commits rückgängig machen

Auf `master` gibt es einen Commit, der "versehentlich" gepusht wurde und einen Bug
enthält.

**Aufgabe:**

1. Finde den fehlerhaften Commit.
2. Mache ihn mit `git revert` rückgängig.
3. Erkläre: Warum nutzt du hier `revert` und nicht `reset`?

> **Erinnerung:** `git revert` ist sicher für bereits veröffentlichte Historie,
> weil es einen neuen Commit erstellt, statt bestehende zu entfernen.

## Phase 5: Aufräumen

**Aufgabe:**

1. Lösche alle gemergten Feature-Branches.
2. Erkläre den Unterschied zwischen `git branch -d` und `git branch -D`.
3. Prüfe den finalen Graphen:

   ```bash
   git log --oneline --graph --all
   ```
