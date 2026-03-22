# Lab 03: .gitignore (VS Code)

Sehe das Verhalten von .gitignore in VS Code.

Öffne VS Code im Verzeichnis `labs/03-ignore/exercise`.

1\. Klicke auf "New File..."

![](images/step_01.jpeg)

2\. Vergebe den Namen [[foo.s]]. Füge beliebigen Inhalt in die neue Datei hinzu. Füge danach mit "New file..." eine
weitere Datei hinzu.

![](images/step_02.jpeg)

3\. Nenne die Datei [[.gitignore]]

![](images/step_03.jpeg)

4\. Füge in die neue Datei den Inhalt [[\*.s]] hinzu. Dir wird kurz darauf auffallen, dass die Datei [[foo.s]] im
Dateibrowser ausgegraut ist. Das bedeutet, dass Änderungen an dieser Datei nun von Git ignoriert werden

![](images/step_04.jpeg)

5\. Klicke auf den Knopf für die Repository-Ansicht

![](images/step_05.jpeg)

6\. Füge mit dem [[+]]  beide offenen Änderungen der Staging Area hinzu

![](images/step_06.jpeg)

7\. Committe die Änderungen mit einer beliebigen Message. Nun ist auch die .gitignore im Repository committet.

![](images/step_07.jpeg)

8\. Wir wollen nun sehen, was passiert, wenn man Änderungen an Dateien macht, die nicht von Anfang an in der
[[.gitignore]] waren. Füge der [[.gitignore]] die Zeile [[file1.txt]] hinzu

![](images/step_08.jpeg)

9\. Öffne die Dateiansicht

![](images/step_09.jpeg)

10\. Wähle die Datei [[file1.txt]]

![](images/step_10.jpeg)

11\. Füge eine weitere Zeile in der Datei hinzu mit beliebigem Inhalt

![](images/step_11.jpeg)

12\. Gehe wieder in die Repository-Ansicht. Die Datei test.txt wird als geändert erscheinen, obwohl sie in der
.gitignore ist! Das liegt daran, dass sie schon existierte, als sie noch nicht von Git ignoriert wurde.

![](images/step_12.jpeg)

13\. Klicke im Menü auf "View" -> "Terminal" und gebe den Befehl [["git rm --cached file1.txt"]]  ein.

![](images/step_13.jpeg)

14\. Wechsle auf die Repository-Ansicht. Du siehst, dass die endgültige Löschung von [[file1.txt]] im Staging ist.

![](images/step_14.jpeg)

15\. Commite die Änderung mit einer beliebigen Message. Die Datei ist nun aus dem Index entfernt, aber weiterhin auf
deiner Festplatte vorhanden.

![](images/step_15.jpeg)
