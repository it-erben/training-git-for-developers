# Lab 20: Arbeiten mit Remotes in VS Code

In dieser Übung lernst du, wie du in VS Code mit Remote-Repositories arbeitest:
Pushen, Pullen, Fetch und den Umgang mit Remote-Branches.

Das Setup erstellt ein lokales Bare-Repository (`remote.git/`), das als Remote
dient, sowie einen zweiten Klon (`kollege/`), mit dem du Änderungen eines
Kollegen simulierst.

## Vorbereitung

Öffne VS Code im Verzeichnis `labs/20-remotes/exercise`.

Der Remote `origin` ist bereits konfiguriert und zeigt auf `../remote.git/`.

## Phase 1: Pushen

1. Wechsle in die Repository-Ansicht. Unten steht "Publish Branch" - der
   Remote kennt den Branch noch nicht. Klicke auf "Publish Branch", um den
   `master`-Branch zu pushen.

2. Erstelle eine neue Datei `info.txt` mit beliebigem Inhalt. Stage und
   committe sie.

3. In der Statusleiste unten siehst du neben dem Branch-Namen ein Symbol mit
   Pfeilen und einer Zahl (z.B. `0↓ 1↑`). Das bedeutet: 0 Commits zum Holen,
   1 Commit zum Pushen.

4. Klicke auf `...` -> "Push". Dein Commit wird zum Remote gepusht.

## Phase 2: Änderungen auf dem Remote simulieren

Um zu verstehen, wie Fetch und Pull funktionieren, simulieren wir Änderungen,
die ein Kollege auf dem Remote gemacht hat.

5. Öffne ein **zweites VS Code-Fenster** (File -> New Window) und öffne darin
   den Ordner `labs/20-remotes/kollege/`. Das ist ein zweiter Klon des gleichen
   Remotes - als wäre es der Rechner deines Kollegen.

6. Im Kollegen-Fenster: Klicke zunächst auf `...` -> "Pull", um den
   aktuellen Stand zu holen. Erstelle dann eine neue Datei `nachricht.txt` mit
   beliebigem Inhalt. Stage und committe sie. Pushe dann über `...` -> "Push".

7. Zurück in deinem **ersten Fenster** (`exercise`): In der Statusleiste steht
   immer noch `0↓ 0↑` - VS Code weiß noch nichts von der Änderung.

8. Klicke auf `...` -> "Fetch". VS Code holt die Informationen über neue
   Commits, ohne sie zu mergen. Die Statusleiste zeigt jetzt `1↓ 0↑`.

9. Klicke auf `...` -> "Pull". Die Änderung wird in deinen lokalen Branch
   gemergt. Prüfe: `nachricht.txt` ist jetzt da.

## Phase 3: Remote-Branches

10. Wechsle ins **Kollegen-Fenster**. Erstelle dort einen neuen Branch: Klicke
    unten auf den Branch-Namen und wähle "Create new branch...". Nenne ihn
    `feature/remote-test`.

11. Erstelle eine neue Datei `feature.txt` mit beliebigem Inhalt. Stage und
    committe sie. Klicke dann auf "Publish Branch", um den Branch zu pushen.

12. Zurück in deinem **ersten Fenster**: Klicke auf `...` -> "Fetch". Der neue
    Branch wird heruntergeladen.

13. Klicke unten auf den Branch-Namen und wähle `origin/feature/remote-test`
    aus der Liste. VS Code erstellt automatisch einen lokalen Tracking-Branch.

14. Prüfe den Inhalt: `feature.txt` ist jetzt lokal vorhanden.

## Phase 4: Push vs. Sync vs. Fetch

| Aktion    | Was passiert                       | Wann nutzen                                  |
|-----------|------------------------------------|----------------------------------------------|
| **Fetch** | Holt Infos, ändert nichts lokal    | Um zu sehen, was auf dem Remote passiert ist |
| **Pull**  | Fetch + Merge in aktuellen Branch  | Um Remote-Änderungen lokal zu integrieren    |
| **Push**  | Lokale Commits zum Remote senden   | Um eigene Arbeit zu teilen                   |
| **Sync**  | Pull + Push in einem Schritt       | Bequem, aber potenziell überraschend         |

> **Achtung:** Der "Sync"-Button in VS Code macht `pull` + `push`. Wenn auf
> dem Remote Änderungen sind, erstellt VS Code automatisch einen Merge-Commit.
> Wer das nicht will, sollte erst Fetch machen, dann bewusst Pull und Push
> trennen.
