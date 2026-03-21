# Übung 18: Bugs finden mit git bisect

Du kommst aus dem Urlaub zurück und stellst fest: Der `master`-Branch ist
kaputt. Der Build schlägt fehl, und es ist unklar, welcher von den vielen
Commits seit deiner Abwesenheit den Fehler eingeführt hat. Manuell jeden Commit
durchzugehen wäre viel zu aufwändig.

Genau für dieses Szenario gibt es `git bisect`. Der Befehl nutzt eine **binäre
Suche** (Binary Search) über die Commit-Historie: Du sagst Git, welcher Commit
definitiv gut war und welcher schlecht ist, und Git springt automatisch zum
Commit in der Mitte. Du testest, ob der Fehler dort vorhanden ist, und Git
halbiert den Suchbereich weiter - bis der exakte Commit gefunden ist, der den
Bug eingeführt hat.

Bei *n* Commits braucht die binäre Suche nur *log₂(n)* Schritte - bei 1000
Commits also nur etwa 10 Tests statt 1000.

## Vorbereitung

Öffne das Terminal im Verzeichnis `labs/18-bisect/exercise`.

## Aufgaben

### Manuelles Bisect

1. Starte den Bisect-Vorgang:
   ```bash
   git bisect start
   ```

2. Der aktuelle Stand (`HEAD`) ist fehlerhaft. Markiere ihn als schlecht:
   ```bash
   git bisect bad
   ```

3. Glücklicherweise gibt es den Tag `initial-commit`, der den Projekstart
   markiert und garantiert funktioniert hat. Markiere ihn als gut:
   ```bash
   git bisect good initial-commit
   ```

4. Git checkt jetzt automatisch den Commit in der Mitte aus. Teste, ob der
   Fehler hier vorhanden ist, indem du das Testskript ausführst:

   **Bash/macOS/Linux:**
   ```bash
   ./test.sh
   ```
   **PowerShell/Windows:**
   ```powershell
   pwsh -File test.ps1
   ```
   Markiere das Ergebnis mit `git bisect good` oder `git bisect bad` und
   wiederhole, bis Git den fehlerhaften Commit gefunden hat.

### Automatisches Bisect

Du kannst den gesamten Vorgang auch automatisieren, wenn du ein Testskript hast,
das mit Exit-Code 0 (Erfolg) oder einem Fehler-Code endet:

**Bash/macOS/Linux:**
```bash
git bisect start
git bisect bad
git bisect good initial-commit
git bisect run ./test.sh
```

**PowerShell/Windows:**
```powershell
git bisect start
git bisect bad
git bisect good initial-commit
git bisect run pwsh -File test.ps1
```

Git führt die binäre Suche dann vollautomatisch durch und gibt am Ende den
Commit aus, der den Fehler eingeführt hat.

### Aufräumen

5. Beende den Bisect-Vorgang:
   ```bash
   git bisect reset
   ```
   Damit kehrst du zum ursprünglichen Branch zurück.

> **Tipp:** `git bisect` ist eines der mächtigsten Debugging-Werkzeuge in Git
> und besonders effektiv, wenn du gute automatische Tests hast. Es funktioniert
> sogar bei Tausenden von Commits in wenigen Sekunden.

## Nützliche Befehle

| Befehl                    | Beschreibung                              |
|---------------------------|-------------------------------------------|
| `git bisect start`        | Bisect-Vorgang starten                    |
| `git bisect bad`          | Aktuellen Commit als fehlerhaft markieren |
| `git bisect good <ref>`   | Einen Commit als funktionierend markieren |
| `git bisect run <script>` | Automatische Suche mit Testskript         |
| `git bisect reset`        | Bisect beenden und zurückkehren           |
| `git bisect log`          | Bisheriges Bisect-Protokoll anzeigen      |
