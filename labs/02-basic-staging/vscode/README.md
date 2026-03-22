# Lab 02: Die Staging Area (VS Code)

Lerne, wie Änderungen am Repository in VS Code angezeigt und rückgängig gemacht werden können.

1\. Öffne VS Code im Verzeichnis `labs/02-basic-staging/exercise`.

![](images/step_01.jpeg)

2\. Klicke auf die Datei "file.txt" und schau dir den Inhalt an

![](images/step_02.jpeg)

3\. Klicke nun auf das Repository-Symbol

![](images/step_03.jpeg)

4\. Du siehst: Aktuell gibt es keine Änderungen. Gehe zurück in die Dateiansicht

![](images/step_04.jpeg)

5\. Ändere den Inhalt der Datei zu "v2". Klicke dann auf die blaue Linie neben dem Text

![](images/step_05.jpeg)

6\. Click here.

![](images/step_06.jpeg)

7\. Du siehst die Änderungen im Vergleich zum Stand des Repositories. Hier könntest du sie auch rückgängig machen - tu
dies aber nicht

![](images/step_07.jpeg)

8\. Gehe in die Repository-Ansicht

![](images/step_08.jpeg)

9\. Klicke auf das "+", um deine Änderung dem Staging hinzuzufügen

![](images/step_09.jpeg)

10\. Ändere den Dateinhalt zu "v3". Die blaue Linie zeigt wieder an, dass es Änderungen gibt. Klicke auf sie

![](images/step_10.jpeg)

11\. Über den Dropdown kannst du nun auswählen, ob du den Unterschied der Zeile zum Stand des Repositories sehen willst
oder zum Stand des Stagings.

![](images/step_11.jpeg)

12\. Klicke auf "Git Local Changes (Index)". Dies zeigt den Unterschied deiner Zeile zum letzten Stand, den du mit dem
"+" zum Staging hinzugefügt hast.

![](images/step_12.jpeg)

13\. Wechsle auf "Git Local Changes (Working Tree)". Du siehst die Änderungen im Vergleich zum zuletzt committeten Stand.

![](images/step_13.jpeg)

14\. Klicke nun auf das "-", um die Änderungen im Staging zurückzusetzen. Dies wird die Datei selbst nicht verändern,
aber dein Staging leeren.

![](images/step_14.jpeg)

15\. Klicke wieder auf die blaue Linie

![](images/step_15.jpeg)

16\. Du siehst, dass nur noch ein Diff zur Verfügung steht: Das vom lokalen Dateizustand zum committeten Stand. Dar
Index ("staging") ist verschwunden.

![](images/step_16.jpeg)

17\. Klicke rechts auf die Datei "file.txt"

![](images/step_17.jpeg)

18\. Klicke auf "Discard Changes"

![](images/step_18.jpeg)

19\. Klicke auf "Discard File". Deine Änderungen sind nun auch in der Datei selbst rückgängig gemacht.

![](images/step_19.jpeg)
