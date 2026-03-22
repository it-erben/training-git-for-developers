# Git for Developers

Praxisorientiertes Schulungsmaterial zum Erlernen von Git — von den Grundlagen bis zu fortgeschrittenen Workflows.

## Inhalt

| Verzeichnis | Beschreibung |
|-------------|--------------|
| [labs/](labs/) | 27 Hands-on-Übungen mit Schritt-für-Schritt-Anleitungen (Terminal & VS Code) |
| [slides/](slides/) | Foliensätze zu den 7 Kursmodulen |
| [solutions/](solutions/) | Musterlösungen für ausgewählte Labs |

## Aufbau der Labs

Die Labs sind in aufsteigender Komplexität angeordnet:

1. **Grundlagen** (Labs 01–04) — Commits, Staging, `.gitignore`, Branching
2. **Merging** (Labs 05–07) — Fast-Forward, 3-Way-Merge, Konflikte
3. **Historie bearbeiten** (Labs 08–10) — Amend, Reset, Restore
4. **Fortgeschrittene lokale Operationen** (Labs 11–17) — Revert, Stash, Aufräumen, Rebase, Cherry-Pick, Squashing, Tags
5. **Debugging & Recovery** (Labs 18–19) — Bisect, Reflog
6. **Zusammenarbeit** (Labs 20–23) — Remotes, parallele Entwicklung, Code Review, Release-Workflow
7. **CI/CD & Plattform** (Labs 24–27) — Projekt-Setup, Feature Branches, Pipelines, Zusammenarbeit

## Schnellstart

```bash
# Alle Übungen vorbereiten
cd labs && bash setup-all.sh

# Einzelne Übung vorbereiten
cd labs/01-basic-commits && bash setup.sh
```
