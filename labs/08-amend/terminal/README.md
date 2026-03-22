# Lab 08: Commits ändern mit Amend (Terminal)

Es passiert jedem: Du hast gerade einen Commit erstellt und merkst dann, dass du
eine Datei vergessen hast, ein Tippfehler in der Commit-Nachricht steckt, oder
eine kleine Änderung noch dazugehört hätte. Für genau diese Fälle gibt es
`git commit --amend`.

Mit `--amend` kannst du den **letzten Commit** nachträglich verändern - sowohl
den Inhalt (welche Dateien enthalten sind) als auch die Commit-Nachricht. Dabei
wird kein neuer Commit hinzugefügt, sondern der letzte Commit wird durch eine
korrigierte Version ersetzt.

> **Wichtig:** Verwende `--amend` nur bei Commits, die noch nicht gepusht
> wurden. Da der Commit ersetzt wird, ändert sich sein Hash - und das kann
> Probleme verursachen, wenn andere bereits mit dem alten Commit arbeiten.

## Aufgaben

Öffne das Terminal im Verzeichnis `labs/08-amend/exercise`.

### Den Ausgangszustand verstehen

1. Führe `git status` aus. Was wird angezeigt? Es gibt eine Datei, die noch
   nicht Teil des letzten Commits ist.
2. Führe `git log -p` aus. Dieser Befehl zeigt die Commit-Historie zusammen mit
   den jeweiligen Änderungen (Patches). Schau dir an, welche Dateien im letzten
   Commit enthalten sind.

### Eine vergessene Datei zum letzten Commit hinzufügen

3. Füge `bar.txt` mit `git add bar.txt` zur Staging Area hinzu.
4. Führe `git commit --amend` aus. Git öffnet den Editor mit der bisherigen
   Commit-Nachricht. Du kannst sie anpassen oder einfach so übernehmen.
5. Was ist passiert? Führe `git log -p` aus und beobachte: Der Commit enthält
   jetzt **beide** Dateien. Es wurde kein neuer Commit erstellt - der alte wurde
   ersetzt.

### Die Commit-Nachricht ändern

6. Führe `git commit --amend` noch einmal aus - diesmal ohne vorher etwas zu
   stagen. Der Editor öffnet sich, und du kannst ausschließlich die
   Commit-Nachricht ändern. Probiere es aus.

> **Tipp:** Wenn du nur die Nachricht ändern möchtest, ohne den Editor zu
> öffnen, geht das auch mit:
>
> ```bash
> git commit --amend -m "Neue Nachricht"
> ```

## Nützliche Befehle

| Befehl                        | Beschreibung                          |
|-------------------------------|---------------------------------------|
| `git commit --amend`          | Letzten Commit nachträglich ändern    |
| `git commit --amend -m "..."` | Commit-Nachricht direkt ändern        |
| `git log -p`                  | Historie mit Dateiänderungen anzeigen |
| `git show`                    | Letzten Commit im Detail anzeigen     |
| `git add <datei>`             | Datei zur Staging Area hinzufügen     |
