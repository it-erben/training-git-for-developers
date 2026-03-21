# Übung 2: Die Staging Area

In dieser Übung geht es darum, die **Staging Area** (auch Index genannt) zu
verstehen. Git arbeitet mit drei Bereichen:

- **Working Directory** - hier bearbeitest du deine Dateien ganz normal.
- **Staging Area** - hier sammelst du mit `git add` die Änderungen, die in den
  nächsten Commit aufgenommen werden sollen.
- **Repository** - hier landen die Änderungen dauerhaft, sobald du `git commit`
  ausführst.

Das Besondere: Eine Datei kann gleichzeitig unterschiedliche Änderungen im
Working Directory und in der Staging Area haben. Das klingt zunächst verwirrend,
ist aber nützlich, um gezielt zu kontrollieren, was in einen Commit einfließt.

## Aufgaben

Öffne VS Code im Verzeichnis `labs/02-basic-staging/exercise`.

### Änderungen sichtbar machen mit `git diff`

1. Schaue dir den Inhalt von `file.txt` an. Was steht drin?
2. Überschreibe den Inhalt: `echo "v2" > file.txt`
3. Führe `git diff` aus. Dieser Befehl zeigt die Unterschiede zwischen dem
   **Working Directory** und der **Staging Area**. Du solltest die Änderung von
   `v1` zu `v2` sehen.
4. Führe `git diff --staged` aus. Warum ist die Ausgabe leer? 

> Weil du noch nichts gestaged hast. Die Staging Area enthält noch
> den gleichen Stand wie der letzte Commit.

### Staging und Working Directory unterschiedlich machen

5. Stage die Änderung: `git add file.txt`
6. Führe nun `git diff` aus. Warum ist die Ausgabe jetzt leer?
7. Führe `git diff --staged` aus. Hier solltest du jetzt die Änderung sehen,
   denn sie liegt nun in der Staging Area.
8. Überschreibe den Inhalt erneut: `echo "v3" > file.txt`
9. Führe `git diff` aus. Was zeigt es an?
10. Führe `git diff --staged` aus. Was zeigt es an?
> Die Staging Area enthält den Wert `v2` (vom
> letzten `git add`), das Working Directory enthält `v3`, und das Repository
> enthält noch `v1`. Alle drei Bereiche haben einen unterschiedlichen Stand!
11. Führe `git status` aus. Du wirst sehen, dass `file.txt` **zweimal** in der
    Ausgabe erscheint - einmal als staged, einmal als modified.

> Nimm' dir nun einen Moment Zeit, das sacken zu lassen. Der Unterschied zwischen
> **Working Directory** und **Staging** ist vielleicht erstmal nicht intuitiv verständlich, 
> aber sehr wichtig und vor allem später auch sehr praktisch. 
> Fange die Aufgabe gerne von vorne an mit dem Befehl `git reset --hard`,
> um alle Schritte noch einmal zu sehen.

### Änderungen aus der Staging Area entfernen

13. Entferne die Änderung aus der Staging Area mit
    `git restore --staged file.txt`. Die Datei im Working Directory bleibt
    unverändert - nur die Staging Area wird zurückgesetzt.
14. Was zeigt `git status` jetzt? Die Änderung sollte nur noch als unstaged
    angezeigt werden.
15. Stage die Änderung erneut und erstelle einen Commit.
16. Wie sieht das Log jetzt aus?

### Änderungen im Working Directory verwerfen

17. Überschreibe den Inhalt nochmals: `echo "v4" > file.txt`
18. Überprüfe den Inhalt der Datei.
19. Was sagt `git status`?
20. Führe `git restore file.txt` aus. Damit wird die Datei im Working Directory
    auf den Stand des letzten Commits zurückgesetzt.
21. Was steht jetzt in `file.txt`?
22. Was sagt `git status`? Das Arbeitsverzeichnis sollte wieder sauber sein.

> **Merke:** `git restore --staged` entfernt Änderungen aus der Staging Area
> (zurück ins Working Directory). `git restore` **ohne** `--staged` verwirft Änderungen
> im Working Directory unwiderruflich.

## Nützliche Befehle

| Befehl                         | Beschreibung                                             |
|--------------------------------|----------------------------------------------------------|
| `git diff`                     | Unterschiede zwischen Working Directory und Staging Area |
| `git diff --staged`            | Unterschiede zwischen Staging Area und letztem Commit    |
| `git add <datei>`              | Änderungen in die Staging Area aufnehmen                 |
| `git restore --staged <datei>` | Staging rückgängig machen                                |
| `git restore <datei>`          | Änderungen im Working Directory verwerfen                |
| `git status`                   | Überblick über den aktuellen Zustand                     |
