# AGENTS

## Linting

Dieses Repo verwendet Linter:

- Markdown: `markdownlint-cli2` mit `--fix`, Line Length max 120
- YAML: `yamllint` (extends relaxed, line-length max 140)
- Links: `lychee` mit `--accept 429,200`,
  `--exclude http://localhost.*`, `--exclude-path .npm-cache`,
  `--max-concurrency 4`, `--retry-wait-time 2`, `--timeout 20`,
  `--cache`

- Lasse nach jeder Änderung `pre-commit` laufen und behebe alle
  Änderungen selbstständig.

## Sprache

Alle Materialien dieser Schulung sind auf Deutsch zu formulieren bis
auf Code, der immer Englisch ist.

## Format

Alle Folien sind im Marp-Format zu erstellen und in "slides" abzulegen,
wobei jedes Modul ein eigenes Unterverzeichnis erhält und die Folien
selbst in einer Datei "slides.md" im Modulverzeichnis abgelegt werden.

## Thema

Die Schulung in diesem Repository ist "Git für Entwickler".

### Beschreibung

Git ist das führende Versionskontrollsystem für Softwareentwicklung.
In diesem Seminar erlernen die Teilnehmer die Grundlagen und die
fortgeschrittene Verwendung von Git mit Fokus auf VS Code und GitHub.

### Zielgruppe

Entwicklerteam (8–10 Teilnehmer) mit Grundkenntnissen in Git und
GitHub. Die Teilnehmer arbeiten mit Microsoft Dynamics 365 Business
Central (AL-Sprache) in VS Code. Ziel ist es, bestehende Kenntnisse
zu vertiefen und Workflows zu optimieren.

### Schwerpunkte

- CLI und VS Code Git-Integration parallel zeigen
- GitHub als Plattform (nicht GitLab/SCM-Manager)
- Branching-Strategien für Release-/Feature-/Hotfix-Workflows
- Versionierung: Git-Tags ↔ Programmversionen (`app.json`)
- Praxisübungen mit einem AL-Beispielprojekt als Kontext
