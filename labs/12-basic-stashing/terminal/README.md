# Übung 12: Arbeit zwischenspeichern mit git stash

Stell dir folgendes Szenario vor: Du arbeitest an einem neuen Feature, hast
bereits einige Änderungen gemacht - teils gestagt, teils noch nicht - und
plötzlich wird ein dringender Bug in der Produktion gemeldet. Du musst sofort
auf einen anderen Branch wechseln, aber deine halbfertigen Änderungen willst du
weder committen noch verlieren.

Genau dafür gibt es `git stash`. Der Befehl nimmt deine aktuellen Änderungen 
(sowohl gestagte als auch nicht gestagte) und legt sie auf einen internen
Stapel (Stack). Dein Arbeitsverzeichnis ist danach wieder sauber, und du kannst
den Bugfix bearbeiten. Anschließend holst du deine Änderungen mit
`git stash apply` zurück.

## Aufgaben

Öffne das Terminal im Verzeichnis `labs/12-basic-stashing/exercise`.

### Ausgangszustand erfassen

1. Verschaffe dir einen Überblick über das Repository:
    - Welche Änderungen hast du im Working Directory? (`git diff`)
    - Welche Änderungen sind gestagt? (`git diff --staged`)
    - Wie sieht die Commit-Historie aus? (`git log --oneline`)

   Beachte, dass `file.txt` sowohl gestagte als auch nicht gestagete Änderungen
   hat.

### Arbeit stashen

2. Sichere deine aktuelle Arbeit mit `git stash`. Prüfe danach:
    - Was zeigt `git diff`? (Leer - Working Directory ist sauber)
    - Was zeigt `git diff --staged`? (Leer - Staging Area ist sauber)
    - Was zeigt `git log --oneline`? (Unverändert)
    - Was zeigt `git stash list`? (Ein Eintrag im Stash)

### Den dringenden Bug fixen

3. Behebe die Tippfehler in `bug.txt` und erstelle einen Commit für den Bugfix.

### Arbeit wiederherstellen

4. Hole deine gestashte Arbeit zurück: `git stash apply`. Prüfe danach:
    - Welche Änderungen sind im Working Directory?
    - Welche Änderungen sind gestagt?

   Du wirst feststellen, dass **alle Änderungen als unstagestaged**
   zurückkommen - auch die, die vorher in der Staging Area waren. 
   Das kann überraschend und unerwünscht sein.

### Arbeit mit Staging-Zustand wiederherstellen

5. Mache die Wiederherstellung rückgängig: `git reset --hard HEAD`. Das ist hier
   sicher, weil die Änderungen noch im Stash liegen.

6. Stelle die Arbeit diesmal mit der Option `--index` wieder her:
   ```bash
   git stash apply --index
   ```
   Prüfe erneut Working Directory und Staging Area. Diesmal sollte der
   ursprüngliche Zustand korrekt wiederhergestellt sein - gestagete Änderungen
   sind wieder gestagt, nicht gestagte sind im Working Directory.

### Aufräumen

7. Der Stash wird nicht automatisch gelöscht, wenn du `apply` verwendest. Räume
   auf mit `git stash drop`.
    - Was zeigt `git stash list` jetzt?
    - Wie sieht `git log --oneline` aus?

> **Tipp:** Wenn du den Stash anwenden und gleichzeitig entfernen möchtest,
> kannst du statt `apply` + `drop` auch `git stash pop` verwenden. Das ist die
> häufigere Variante in der Praxis.

## Nützliche Befehle

| Befehl                    | Beschreibung                                   |
|---------------------------|------------------------------------------------|
| `git stash`               | Aktuelle Änderungen auf den Stash-Stapel legen |
| `git stash list`          | Alle Stash-Einträge anzeigen                   |
| `git stash apply`         | Stash wiederherstellen (Stash bleibt erhalten) |
| `git stash apply --index` | Stash mit Staging-Zustand wiederherstellen     |
| `git stash pop`           | Stash wiederherstellen und entfernen           |
| `git stash drop`          | Stash-Eintrag löschen                          |
