# Lab 13: Repositories aufräumen

## Hintergrund

Du übernimmst ein Repository von einem Kollegen, der "noch nicht so weit war mit
Git". Das Repo hat eine ganze Reihe von Problemen. Deine Aufgabe: Bringe es in
einen sauberen Zustand — und lerne dabei, die bisher gelernten Git-Werkzeuge in
Kombination einzusetzen.

## Vorbereitung

Öffne das Terminal im Verzeichnis `labs/13-repository-aufraeumen/exercise`.

Verschaffe dir einen Überblick:

```bash
git status
git log --oneline --all
git stash list
```

## Phase 1: Analyse

Beantworte die folgenden Fragen, **bevor** du etwas änderst:

1. Welche Dateien werden getrackt, die nicht ins Repo gehören?
   (Tipp: `git ls-files`)
2. Was hat der letzte Commit für eine Message — und was stimmt daran nicht?
3. Was enthält der "Monster-Commit"? Wie viele unabhängige Änderungen sind darin
   gebündelt? (Tipp: `git show --stat`)
4. Gibt es gestashte Arbeit? Was ist darin enthalten?
5. Sind Dateien im Staging-Bereich, die dort nicht sein sollten?

## Phase 2: .gitignore & Tracking-Probleme

Das Repo trackt Dateien, die nicht hineingehören:

- `.alpackages/` enthält riesige Binärdateien (Symbole)
- `.vscode/launch.json` enthält ein Passwort

**Aufgabe:**

1. Erstelle eine saubere `.gitignore`.
2. Entferne die Dateien aus dem Tracking, ohne sie von der Festplatte zu löschen.
3. Committe die Korrektur.

> **Hinweis:** Erinnere dich an `git rm --cached` aus Übung 03.

## Phase 3: Den Monster-Commit aufspalten

Der Commit mit der Message "Did stuff" enthält mehrere unabhängige Änderungen,
die in separate Commits gehören.

**Aufgabe:** Spalte ihn in einzelne, atomare Commits auf.

Hinweise:

- `git reset --soft HEAD~<n>` setzt Commits zurück, behält aber alle Änderungen
  im Staging. Finde heraus, wie weit du zurückgehen musst.
- Mit `git reset HEAD <datei>` kannst du einzelne Dateien aus dem Staging
  entfernen.
- Mit `git add -p` kannst du Teile einer Datei stagen.

Jeder Commit sollte:

- Genau eine logische Änderung enthalten
- Eine Commit-Message nach den Regeln haben (Imperativ, max. 50 Zeichen
  Betreffzeile, Erklärung im Body)

## Phase 4: Commit-Message reparieren

Einer der Commits hat eine schlechte Message.

**Aufgabe:** Korrigiere sie mit `git commit --amend`.

## Phase 5: Gestashte Arbeit einarbeiten

Im Stash liegt angefangene Arbeit.

**Aufgabe:**

1. Untersuche, was im Stash liegt (`git stash show -p`).
2. Wende den Stash an.
3. Committe die Änderungen sauber.

## Validierung

- `git ls-files .alpackages` gibt nichts zurück.
- `git log --oneline` zeigt nur Commits mit aussagekräftigen Messages.
- Kein Commit enthält mehr als eine logische Änderung
  (`git show --stat` pro Commit prüfen).
- `git stash list` ist leer.

## Diskussion

- Was war die schwierigste Aufgabe — und warum?
- Wie hättet ihr die Probleme von vornherein vermieden?
- Welche Regeln wollt ihr in eurem Team etablieren?
