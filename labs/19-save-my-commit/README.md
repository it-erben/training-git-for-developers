# Übung 19: Verlorene Commits retten mit git reflog

In dieser Übung wurde der `master`-Branch auf den initialen Commit
zurückgesetzt – und damit scheinbar wichtige Arbeit verloren. Die Datei
`holygrail.txt` ist verschwunden und taucht in der normalen Historie (`git log`)
nicht mehr auf.

Aber keine Panik: Git vergisst fast nie etwas! Hinter den Kulissen führt Git ein
**Reflog** (Reference Log), das jede Bewegung des HEAD-Zeigers aufzeichnet –
auch Resets, Rebases und andere Operationen, die Commits aus der sichtbaren
Historie entfernen. Mit `git reflog` kannst du diese "versteckten" Commits
wiederfinden und retten.

> Das Reflog ist ein Sicherheitsnetz. Solange der Garbage Collector
> nicht gelaufen ist, kannst du praktisch jede Operation rückgängig machen.

## Vorbereitung

Öffne das Terminal im Verzeichnis `labs/19-save-my-commit/exercise`.

## Aufgaben

### Das Problem erkennen

1. Führe `git log` aus. Die Historie ist sehr kurz – es gibt nur den initialen
   Commit.
2. Prüfe mit `ls`, ob `holygrail.txt` im Arbeitsverzeichnis existiert. Spoiler:
   Nein.

### Methode 1: Wiederherstellen mit git reset

3. Nutze `git reflog`, um das Protokoll aller HEAD-Bewegungen zu sehen. Suche
   den Eintrag, bei dem `holygrail.txt` hinzugefügt wurde. Du erkennst ihn an
   der Commit-Nachricht.
4. Setze den Branch mit `git reset --hard <sha>` auf diesen Commit zurück.
   Verwende den SHA-Hash aus dem Reflog.
5. Prüfe mit `git log` und `ls`, ob die Arbeit wiederhergestellt wurde.

### Methode 2: Wiederherstellen mit git cherry-pick

6. Mache die Lösung zuerst rückgängig:
   ```bash
   git reset --hard initial-commit
   ```
7. Nutze `git cherry-pick <sha>`, um den verlorenen Commit als neuen Commit auf
   den aktuellen Branch zu übernehmen.
8. Vergleiche das Ergebnis mit der vorherigen Methode. Was ist der Unterschied?
   Bei `reset --hard` wird die komplette Historie wiederhergestellt, bei
   `cherry-pick` wird nur der einzelne Commit als neuer Commit übernommen.

### Was passiert, wenn der Garbage Collector läuft?

9. Setze erneut zurück:
   ```bash
   git reset --hard initial-commit
   ```
10. Prüfe mit `git reflog`, dass die Einträge noch da sind. Führe dann nur
    den Garbage Collector aus:
    ```bash
    git gc
    ```
    Versuche, den verlorenen Commit wiederherzustellen. Es funktioniert noch!
    Das liegt daran, dass das Reflog selbst Referenzen auf die Commits hält
    und `git gc` sie deshalb nicht löscht.

11. Um die Commits wirklich zu entfernen, musst du **zuerst das Reflog
    leeren** und dann den GC mit `--prune=now` aufrufen:
    ```bash
    git reflog expire --expire=now --all
    git gc --prune=now
    ```
12. Versuche jetzt, den verlorenen Commit mit `git reflog` zu finden. Das
    Reflog ist leer - die Commits sind endgültig weg.

> **Wichtig:** Im normalen Betrieb passiert das nicht versehentlich. Git
> hält Reflog-Einträge standardmässig **90 Tage** (konfigurierbar über
> `gc.reflogExpire`). Erst wenn diese Frist abgelaufen ist **und** der
> Garbage Collector läuft, werden unreferenzierte Objekte tatsächlich
> gelöscht. Die beiden Befehle oben erzwingen das sofort - in der Praxis
> hat man also fast immer genug Zeit, verlorene Commits zu retten.

## Nützliche Befehle

| Befehl                   | Beschreibung                                     |
|--------------------------|--------------------------------------------------|
| `git reflog`             | Alle HEAD-Bewegungen anzeigen                    |
| `git reset --hard <ref>` | Branch auf einen Commit zurücksetzen             |
| `git cherry-pick <ref>`  | Einen Commit auf den aktuellen Branch übernehmen |
| `git gc`                 | Garbage Collector manuell ausführen              |
| `git log`                | Commit-Historie anzeigen                         |
