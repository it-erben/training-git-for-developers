# Lab 20: Remotes (Terminal)

In dieser Übung lernst du, wie du mit Remote-Repositories arbeitest: Pushen,
Pullen, Fetch und den Umgang mit Remote-Branches.

Das Setup erstellt ein lokales Bare-Repository (`remote.git/`), das als Remote
dient, sowie einen zweiten Klon (`kollege/`), mit dem du Änderungen eines
Kollegen simulierst.

## Vorbereitung

Öffne das Terminal im Verzeichnis `labs/20-remotes/exercise`.

Der Remote `origin` ist bereits konfiguriert. Prüfe das mit:

```bash
git remote -v
```

Es handelt sich um einen Remote auf deinem eigenen Computer. Deswegen
siehst du nun keine URL, sondern nur eine Referenz auf ein anderes
Verzeichnis.

## Phase 1: Pushen

1. Der Remote kennt den Branch noch nicht. Pushe den `master`-Branch:
   ```bash
   git push -u origin master
   ```
   Die Option `-u` setzt das Tracking, sodass `git push` und `git pull` danach
   ohne Argumente funktionieren.

2. Erstelle eine neue Datei, stage und committe sie:

   **Bash:**
   ```bash
   echo "wichtige Info" > info.txt
   ```
   **PowerShell:**
   ```powershell
   Set-Content info.txt "wichtige Info"
   ```
   Dann:
   ```bash
   git add info.txt
   git commit -m "Add info file"
   ```

3. Prüfe den Status mit `git status`. Git zeigt dir: "Your branch is ahead of
   'origin/master' by 1 commit."

4. Pushe den neuen Commit:
   ```bash
   git push
   ```

## Phase 2: Änderungen auf dem Remote simulieren

Um zu verstehen, wie Fetch und Pull funktionieren, simulieren wir Änderungen,
die ein Kollege auf dem Remote gemacht hat.

5. Wechsle in den vorbereiteten Kollegen-Klon und mache dort Änderungen:

   **Bash:**
   ```bash
   cd ../kollege
   git pull
   echo "Nachricht vom Kollegen" > nachricht.txt
   git add nachricht.txt
   git commit -m "Add message from colleague"
   git push
   cd ../exercise
   ```
   **PowerShell:**
   ```powershell
   cd ..\kollege
   git pull
   Set-Content nachricht.txt "Nachricht vom Kollegen"
   git add nachricht.txt
   git commit -m "Add message from colleague"
   git push
   cd ..\exercise
   ```

6. Zurück im `exercise`-Verzeichnis: `git status` zeigt noch nichts Neues.
   Dein lokales Repo weiß noch nichts von der Änderung.

7. Hole die Informationen über neue Commits, **ohne** sie zu mergen:
   ```bash
   git fetch
   ```

8. Prüfe mit `git status`. Git zeigt: "Your branch is behind
   'origin/master' by 1 commit." Die Änderung ist bekannt, aber noch nicht
   lokal integriert.

9. Integriere die Änderung:
   ```bash
   git pull
   ```
   Prüfe: `nachricht.txt` ist jetzt da.

## Phase 3: Remote-Branches

10. Wechsle zurück in den Kollegen-Klon und erstelle einen neuen Branch:

    **Bash:**
    ```bash
    cd ../kollege
    git switch -c feature/remote-test
    echo "Feature-Inhalt" > feature.txt
    git add feature.txt
    git commit -m "Add feature file"
    git push -u origin feature/remote-test
    cd ../exercise
    ```
    **PowerShell:**
    ```powershell
    cd ..\kollege
    git switch -c feature/remote-test
    Set-Content feature.txt "Feature-Inhalt"
    git add feature.txt
    git commit -m "Add feature file"
    git push -u origin feature/remote-test
    cd ..\exercise
    ```

11. Hole die neuen Branch-Informationen:
    ```bash
    git fetch
    ```

12. Zeige alle Branches (lokal und remote):
    ```bash
    git branch -a
    ```
    Du siehst `remotes/origin/feature/remote-test`.

13. Wechsle auf den Remote-Branch:
    ```bash
    git switch feature/remote-test
    ```
    Git erstellt automatisch einen lokalen Tracking-Branch.

14. Prüfe: `feature.txt` ist jetzt lokal vorhanden.

## Zusammenfassung

| Befehl                | Beschreibung                                      |
|-----------------------|---------------------------------------------------|
| `git remote -v`       | Konfigurierte Remotes anzeigen                    |
| `git push -u origin`  | Branch pushen und Tracking einrichten             |
| `git push`            | Lokale Commits zum Remote senden                  |
| `git fetch`           | Remote-Infos holen, ohne lokal etwas zu ändern    |
| `git pull`            | Fetch + Merge in den aktuellen Branch             |
| `git branch -a`       | Alle Branches (lokal + remote) anzeigen           |
| `git switch <branch>` | Auf Remote-Branch wechseln (erstellt Tracking)    |
