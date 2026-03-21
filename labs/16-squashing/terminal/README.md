# Übung 16: Commits zusammenfassen mit Interactive Rebase

Während der Arbeit an einem Feature entstehen oft viele kleine Commits: "WIP", 
"Fix typo", "Forgot file", "Now really fixed". Bevor du deine Arbeit teilst oder
in `master` mergst, ist es sinnvoll, diese Commits zu einem sauberen,
aussagekräftigen Commit zusammenzufassen. Diesen Vorgang nennt man 
**Squashing**.

Das Werkzeug dafür ist `git rebase -i` (Interactive Rebase). Damit kannst du
Commits nachträglich zusammenfassen, umsortieren, umbenennen oder entfernen.

## Vorbereitung

Öffne das Terminal im Verzeichnis `labs/16-squashing/exercise`.

## Aufgaben

### Commits zusammenfassen (Squash)

1. Schau dir die Historie an: `git log --oneline`. Die fünf neuesten Commits
   bearbeiten alle `file.txt` und gehören logisch zusammen.

2. Starte einen interaktiven Rebase über die letzten fünf Commits:
   ```bash
   git rebase -i HEAD~5
   ```
   Git öffnet einen Editor mit einer Liste der Commits. Vor jedem Commit steht
   das Wort `pick`:
   ```
   pick abc1234 Erster Commit
   pick def5678 Zweiter Commit
   pick ghi9012 Dritter Commit
   ...
   ```

3. Ändere bei den **vier unteren** Commits das Wort `pick` zu `squash` (oder
   kurz `s`). Der **erste** Commit bleibt auf `pick`. Die Commits werden dann
   alle in den ersten hinein zusammengefasst:
   ```
   pick abc1234 Erster Commit
   squash def5678 Zweiter Commit
   squash ghi9012 Dritter Commit
   ...
   ```

4. Speichere und schließe den Editor. Git öffnet einen zweiten Editor, in dem du
   die Commit-Nachricht für den zusammengefassten Commit schreiben kannst.
   Schreibe eine gute, aussagekräftige Nachricht.

5. Prüfe die Historie: `git log --oneline`. Statt fünf Commits sollte jetzt nur
   noch einer da sein.

### Dateiinhalt aufräumen ohne zusätzlichen Commit

6. Öffne `file.txt` - die Datei enthält störende `\n`-Zeichen. Entferne sie.
7. Füge die Änderung hinzu und nutze `git commit --amend`, um sie in den letzten
   Commit aufzunehmen, ohne einen neuen Commit zu erzeugen.

## Regeln für gute Commit-Nachrichten

Aus [How to Write a Git Commit Message](https://chris.beams.io/posts/git-commit/):

1. **Trenne Betreff und Textkörper mit einer Leerzeile**
2. **Begrenze die Betreffzeile auf 50 Zeichen**
3. **Beginne die Betreffzeile mit einem Großbuchstaben**
4. **Beende die Betreffzeile nicht mit einem Punkt**
5. **Verwende den Imperativ** ("Add feature" statt "Added feature")
6. **Beschränke den Textkörper auf 72 Zeichen pro Zeile**
7. **Erkläre im Textkörper das Was und Warum, nicht das Wie**

Beispiel:

```
Zusammenfassung in ca. 50 Zeichen

Ausführlicherer Text, falls nötig. Erkläre hier, warum die
Änderung gemacht wurde und welches Problem sie löst. Beschreibe
mögliche Nebeneffekte oder nicht offensichtliche Konsequenzen.

- Aufzählungspunkte sind ebenfalls in Ordnung
- Ein Bindestrich wird als Aufzählungszeichen verwendet

Resolves: #123
See also: #456
```

## Nützliche Befehle

| Befehl                | Beschreibung                       |
|-----------------------|------------------------------------|
| `git rebase -i <ref>` | Interaktiven Rebase starten        |
| `git commit --amend`  | Letzten Commit nachträglich ändern |
| `git log --oneline`   | Kompakte Historie                  |
