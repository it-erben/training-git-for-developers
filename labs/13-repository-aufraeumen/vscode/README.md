# Lab 13: Repositories aufräumen (VS Code)

## Hintergrund

Du übernimmst ein Repository von einem Kollegen, der "noch nicht so weit war
mit Git". Das Repo hat eine ganze Reihe von Problemen. Deine Aufgabe: Bringe es
in einen sauberen Zustand — und lerne dabei, die bisher gelernten Werkzeuge in
Kombination einzusetzen.

## Vorbereitung

Öffne VS Code im Verzeichnis `labs/13-repository-aufraeumen/exercise`.

Verschaffe dir einen Überblick: Schau dir die Dateiansicht, die
Repository-Ansicht und die GitLens-Commit-Liste an. Prüfe auch, ob es
gestashte Arbeit gibt (`...` → "Stash" → "View Stash...").

## Phase 1: Analyse

Beantworte die folgenden Fragen, **bevor** du etwas änderst:

1. Welche Dateien werden getrackt, die nicht ins Repo gehören? Schau dir die
   Dateiliste in der Explorer-Ansicht und die GitLens-Commit-Inhalte an.
2. Was hat der letzte Commit für eine Message — und was stimmt daran nicht?
3. Was enthält der "Monster-Commit"? Klappe ihn in GitLens auf und zähle, wie
   viele unabhängige Änderungen darin gebündelt sind.
4. Gibt es gestashte Arbeit? Was ist darin enthalten?
5. Sind Dateien im Staging-Bereich, die dort nicht sein sollten?

## Phase 2: .gitignore & Tracking-Probleme

Das Repo trackt Dateien, die nicht hineingehören:

- `.alpackages/` enthält riesige Binärdateien (Symbole)
- `.vscode/launch.json` enthält ein Passwort

**Aufgabe:**

1. Entferne die gestaged Datei, die nicht committet werden soll, aus dem
   Staging (klicke auf `-` neben der Datei unter "Staged Changes").
2. Erstelle über die Dateiansicht eine neue Datei `.gitignore` mit den
   passenden Einträgen.
3. Entferne die Dateien aus dem Tracking. Dafür benötigst du das Terminal
   (View → Terminal) und den Befehl `git rm --cached`.
4. Stage die `.gitignore` und committe die Korrektur.

## Phase 3: Den Monster-Commit aufspalten

Der Commit mit der Message "Did stuff" enthält mehrere unabhängige Änderungen,
die in separate Commits gehören.

**Aufgabe:** Spalte ihn in einzelne, atomare Commits auf.

Hinweise:

- Nutze in GitLens Rechtsklick → "Reset Current Branch to Commit..." auf den
  Commit **vor** dem Monster-Commit. Wähle "Soft Reset --soft", damit alle
  Änderungen im Staging bleiben.
- Beachte: Du musst dabei auch den Commit mit der schlechten Message
  zurücksetzen. Überlege, wie weit du zurückgehen musst.
- Entferne dann einzelne Dateien aus dem Staging (klicke auf `-` neben der
  Datei) und committe Schritt für Schritt — jeweils mit einer sauberen
  Message.

Jeder Commit sollte:

- Genau eine logische Änderung enthalten
- Eine Commit-Message nach den Regeln haben (Imperativ, max. 50 Zeichen
  Betreffzeile)

## Phase 4: Commit-Message reparieren

Falls der Commit mit der schlechten Message noch existiert: Korrigiere die
Message über den Dropdown-Pfeil neben "Commit" → "Commit (Amend)".

> Wenn du den Commit in Phase 3 bereits mit einer sauberen Message neu erstellt
> hast, entfällt dieser Schritt.

## Phase 5: Gestashte Arbeit einarbeiten

Im Stash liegt angefangene Arbeit.

**Aufgabe:**

1. Untersuche, was im Stash liegt (`...` → "Stash" → "View Stash...").
2. Wende den Stash an ("Apply Latest Stash").
3. Stage und committe die Änderungen sauber.
4. Räume den Stash auf ("Drop Stash...").

## Validierung

- In der Dateiansicht werden `.alpackages/` und `.vscode/launch.json` nicht
  mehr als getrackte Dateien angezeigt.
- Die GitLens-Commit-Liste zeigt nur Commits mit aussagekräftigen Messages.
- Kein Commit enthält mehr als eine logische Änderung (klappe Commits in
  GitLens auf, um die enthaltenen Dateien zu prüfen).
- Unter `...` → "Stash" → "View Stash..." ist kein Eintrag mehr vorhanden.

## Diskussion

- Was war die schwierigste Aufgabe — und warum?
- Wie hättet ihr die Probleme von vornherein vermieden?
- Welche Regeln wollt ihr in eurem Team etablieren?
