# Übung 9: Git Reset – Commits zurücknehmen

Mit `git reset` kannst du den Branch-Zeiger auf einen früheren Commit
zurücksetzen. Das ist nützlich, wenn du Commits rückgängig machen möchtest, die
noch nicht gepusht wurden. Je nachdem, welche Option du verwendest, wirkt sich
der Reset unterschiedlich auf die drei Bereiche von Git aus:

- **`--soft`**: Setzt nur den Branch-Zeiger zurück. Die Staging Area und das
  Working Directory bleiben unverändert. Die Änderungen der "entfernten" Commits
  landen in der Staging Area.
- **`--mixed`** (Standard): Setzt den Branch-Zeiger und die Staging Area zurück.
  Das Working Directory bleibt unverändert. Die Änderungen sind noch da, aber
  nicht mehr gestaged.
- **`--hard`**: Setzt alles zurück – Branch-Zeiger, Staging Area und Working
  Directory. **Alle Änderungen gehen verloren!**

> **Wichtig:** `git reset` verändert die Historie. Verwende es nur für lokale,
> nicht gepushte Commits. Für bereits veröffentlichte Commits gibt es
`git revert` (siehe Aufgabe am Ende).

## Aufgaben

Öffne das Terminal im Verzeichnis `labs/09-reset/exercise`.

### Ausgangszustand erfassen

1. Schau dir dein Arbeitsverzeichnis an. Welche Dateien existieren?
2. Überprüfe die Historie mit `git log --oneline` und die Staging Area mit
   `git status`. Merk dir den Zustand – nach jedem Reset wirst du ihn erneut
   prüfen.

### Reset --soft: Nur den Branch-Zeiger zurücksetzen

3. Führe `git reset --soft HEAD~1` aus. Damit wird der letzte Commit aufgelöst.
4. Überprüfe jetzt:
    - **Working Directory:** Hat sich etwas geändert?
    - **`git log --oneline`:** Der letzte Commit ist verschwunden.
    - **`git status`:** Die Änderungen des entfernten Commits sind jetzt in der
      Staging Area.
5. **Commite die Änderungen wieder.**

### Reset --mixed: Staging Area ebenfalls zurücksetzen

6. Führe `git reset --mixed HEAD~1` aus.
7. Überprüfe erneut:
    - **Working Directory:** Die Dateien sind noch da.
    - **`git log --oneline`:** Noch ein Commit weniger.
    - **`git status`:** Die Änderungen sind im Working Directory, aber **nicht
      mehr gestaged**.
8. **Füge die Datei dem Staging hinzu und committe sie.**

### Reset --hard: Alles zurücksetzen

7. Führe `git reset --hard HEAD~1` aus.
8. Überprüfe:
    - **Working Directory:** Eine Datei ist verschwunden!
    - **`git log --oneline`:** Der Commit ist weg.
    - **`git status`:** Alles sauber – die Änderungen sind unwiderruflich
      entfernt.

### Vergleich: git revert

9. Führe `git revert HEAD~1` aus. Git erstellt einen neuen Commit, der die
   Änderungen des angegebenen Commits rückgängig macht.
10. Überprüfe Working Directory, Log und Status. Was ist der Unterschied zu
    `git reset`?

> **Zusammenfassung:**
>
> | Modus | Branch-Zeiger | Staging Area | Working Directory |
> |-------|:---:|:---:|:---:|
> | `--soft` | zurückgesetzt | unverändert | unverändert |
> | `--mixed` | zurückgesetzt | zurückgesetzt | unverändert |
> | `--hard` | zurückgesetzt | zurückgesetzt | zurückgesetzt |

## Nützliche Befehle

| Befehl                    | Beschreibung                                       |
|---------------------------|----------------------------------------------------|
| `git reset --soft <ref>`  | Nur Branch-Zeiger zurücksetzen                     |
| `git reset --mixed <ref>` | Branch-Zeiger und Staging Area zurücksetzen        |
| `git reset --hard <ref>`  | Alles zurücksetzen (Vorsicht: Datenverlust!)       |
| `git revert <ref>`        | Commit rückgängig machen (ohne Historie zu ändern) |
| `git log --oneline`       | Kompakte Historie                                  |
| `git status`              | Aktueller Zustand                                  |
