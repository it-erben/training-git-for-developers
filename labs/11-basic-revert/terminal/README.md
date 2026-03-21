# Übung 11: Commits rückgängig machen mit git revert

Anders als `git reset`, das die Historie verändert, erstellt `git revert` einen
**neuen Commit**, der die Änderungen eines früheren Commits rückgängig macht.
Die ursprünglichen Commits bleiben in der Historie erhalten. Das macht
`git revert` zum sicheren Werkzeug, um Fehler auch in bereits veröffentlichter
(gepushter) Historie zu korrigieren.

In dieser Übung revertest du mehrere Commits und beobachtest, wie sich die
Historie und das Arbeitsverzeichnis dabei verändern.

## Aufgaben

Öffne das Terminal im Verzeichnis `labs/11-basic-revert/exercise`.

### Den letzten Commit reverten

1. Schau dir die Historie an: `git log --oneline`
2. Lies den Inhalt von `greeting.txt`
3. Reverte den neuesten Commit:
   ```bash
   git revert HEAD
   ```
   Git öffnet einen Editor für die Commit-Nachricht des Revert-Commits.
   Bestätige die vorgeschlagene Nachricht.
4. Schau dir die Historie erneut an: `git log --oneline`. Ein Revert fügt immer
   einen neuen Commit hinzu - die alte Historie bleibt intakt.
5. Lies erneut den Inhalt von `greeting.txt`. Die Änderung des letzten Commits
   wurde rückgängig gemacht.

### Einen bestimmten Commit reverten

6. Schau dir mit `ls` den Inhalt des Arbeitsverzeichnisses an.
7. Suche in der Historie (`git log --oneline`) den Commit, der Zugangsdaten (
   credentials) zum Repository hinzugefügt hat. Notiere dir den SHA-Hash.
8. Reverte genau diesen Commit:
   ```bash
   git revert <sha>
   ```
9. Prüfe die Historie: `git log --oneline`
10. Schau dir das Arbeitsverzeichnis an: `ls`. Die Credentials-Datei sollte
    verschwunden sein.
11. Wie viele Commits hat der Revert hinzugefügt?

### Wichtig: Revert löscht nichts aus der Historie

12. Nutze `git show <sha>` mit dem SHA des ursprünglichen Commits, um zu sehen,
    dass die Credentials-Datei **immer noch in der Git-Historie existiert**.

> **Sicherheitshinweis:** Ein `git revert` entfernt Daten aus dem aktuellen
> Stand, aber **nicht aus der Git-Historie**. Wenn einmal Passwörter, API-Keys
> oder andere Geheimnisse committet wurden, reicht ein Revert nicht aus! Die
> Daten sind weiterhin über die Historie abrufbar. In solchen Fällen müssen die
> Secrets sofort rotiert (geändert) werden.

## Nützliche Befehle

| Befehl              | Beschreibung                                  |
|---------------------|-----------------------------------------------|
| `git revert <ref>`  | Einen Commit rückgängig machen (neuer Commit) |
| `git revert HEAD`   | Den letzten Commit reverten                   |
| `git log --oneline` | Kompakte Historie                             |
| `git show <ref>`    | Details eines bestimmten Commits anzeigen     |
