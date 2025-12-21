# Lab 06: 3-Way-Merge in VS Code

In der vorherigen Übung hast du einen Fast-Forward-Merge durchgeführt. Das war
möglich, weil sich nur ein Branch weiterentwickelt hat. In der Praxis passiert
es aber häufig, dass **beide Branches** parallel weiterentwickelt werden. In
diesem Fall führt Git einen **3-Way-Merge** durch, bei dem ein zusätzlicher
Merge-Commit entsteht.

Öffne VS Code im Verzeichnis `labs/06-3-way-merge/exercise`.

## Zwei Branches parallel weiterentwickeln

1. Klicke unten auf "master" und erstelle einen neuen Branch `greeting`.

2. Öffne die Datei `greeting.txt` und schreibe deine Lieblingsbegrüßung hinein.

3. Wechsle auf die Repository-Ansicht, füge die Änderung zum Staging hinzu und
   committe sie.

4. Klicke unten auf "greeting" und wechsle zurück auf `master`.

5. Erstelle über das `+`-Symbol eine neue Datei `README.md` mit einer kurzen
   Beschreibung des Repositories.

6. Wechsle auf die Repository-Ansicht, füge die Datei zum Staging hinzu und
   committe sie.

## Die divergierte Historie betrachten

7. Wechsle in die Branch-Ansicht (klicke auf "Auto" und dann "All", falls noch
   nicht geschehen). Du solltest sehen, dass die beiden Branches nach dem
   gemeinsamen Ausgangscommit in unterschiedliche Richtungen laufen.

## 3-Way-Merge durchführen

8. Stelle sicher, dass du auf `master` bist. Öffne die Branch-Ansicht, klicke
   rechts auf den Branch `greeting` und wähle "Merge into Current Branch".

9. Git erstellt automatisch einen Merge-Commit. Bestätige die vorgeschlagene
   Commit-Nachricht.

10. Schau dir die Branch-Ansicht erneut an. Du siehst jetzt den typischen "
    Diamanten": Die Branches laufen auseinander und kommen durch den
    Merge-Commit wieder zusammen.

> **Merke:** Anders als beim Fast-Forward-Merge entsteht beim 3-Way-Merge immer
> ein zusätzlicher Merge-Commit. Dieser Commit hat **zwei Eltern-Commits** und
> dokumentiert, wann und wo die Zusammenführung stattgefunden hat.
