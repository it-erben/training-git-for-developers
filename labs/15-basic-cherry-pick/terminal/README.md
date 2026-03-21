# Übung 15: Cherry-Pick - Einzelne Commits gezielt übernehmen

Manchmal möchtest du nicht einen ganzen Branch mergen, sondern nur **bestimmte
Commits** aus einem anderen Branch übernehmen. Genau dafür gibt es
`git cherry-pick`. Der Befehl nimmt einen oder mehrere Commits und wendet sie
als neue Commits auf den aktuellen Branch an.

Ein typischer Anwendungsfall: Ein Bugfix wurde auf einem Feature-Branch gemacht,
muss aber auch sofort auf `master` übernommen werden, ohne den ganzen
Feature-Branch zu mergen.

## Vorbereitung

Öffne das Terminal im Verzeichnis `labs/15-basic-cherry-pick/exercise`.

## Ausgangssituation

Das Repository hat folgende Struktur:

```
A - B - C - D         master
      \
        E - F - G - H feature
```

Die Commits `F` und `G` enthalten Änderungen, die wir auf `master` haben
wollen - aber **nicht** die Commits `E` und `H`. Ziel ist:

```
A - B - C - D - F' - G' master
      \
        E - F - G - H   feature
```

## Aufgaben

### Ausgangszustand erkunden

1. Schau dir die gesamte Historie an: `git log --oneline --graph --all`
2. Finde heraus, welche Dateien in den Commits `F` und `G` geändert wurden:
    - `cat names.txt` - diese Datei wird in Commit `F` geändert
    - `cat sentence.txt` - diese Datei wird in Commit `G` geändert

### Einen einzelnen Commit cherry-picken

3. Cherry-picke den Commit `F`:
   ```bash
   git cherry-pick <sha-von-F>
   ```
4. Prüfe die Historie: `git log --oneline`. Der Commit `F` sollte jetzt als
   neuer Commit auf `master` erscheinen.
5. Prüfe den Inhalt von `names.txt` - die Änderung aus `F` ist jetzt auf
   `master`.

### Zurücksetzen und Bereich cherry-picken

6. Mache den Cherry-Pick rückgängig, um die Variante mit einem Commit-Bereich
   auszuprobieren:
   ```bash
   git reset --hard HEAD^
   ```
> `HEAD^` bedeutet: ein Commit vor dem aktuellen Commit.

7. Prüfe mit `git log --oneline --graph`, dass der Cherry-Pick entfernt wurde.

8. Cherry-picke nun einen **Bereich** von Commits (F bis G):
   ```bash
   git cherry-pick <sha-von-F>^..<sha-von-G>
   ```

   > **Wichtig:** Das `^` nach dem ersten SHA ist entscheidend! Die
   Bereichsnotation `A..B` schließt den Commit `A` standardmäßig **aus**. Mit
   `A^..B` sagst du Git: "Nimm den Commit **vor** A als Startpunkt" - damit wird
   A eingeschlossen.

9. Prüfe die Historie: `git log --oneline --graph`
10. Prüfe den Inhalt von `names.txt` und `sentence.txt` - beide Änderungen
    sollten jetzt auf `master` sein.

> **Merke:** Cherry-Pick erstellt **neue Commits** mit neuen Hashes. Die
> ursprünglichen Commits auf dem Feature-Branch bleiben unverändert. Das bedeutet
> auch: Wenn du den Feature-Branch später komplett mergst, können doppelte
> Änderungen auftauchen - Git kann das in der Regel aber automatisch erkennen und
> auflösen.

## Nützliche Befehle

| Befehl                            | Beschreibung                                    |
|-----------------------------------|-------------------------------------------------|
| `git cherry-pick <sha>`           | Einzelnen Commit übernehmen                     |
| `git cherry-pick <sha1>^..<sha2>` | Bereich von Commits übernehmen (inklusive sha1) |
| `git reset --hard <ref>`          | Branch auf einen Commit zurücksetzen            |
| `git log --oneline --graph --all` | Gesamte Historie anzeigen                       |
