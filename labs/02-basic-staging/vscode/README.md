# Lab 02: Die Staging Area (VS Code)

Lerne, wie Änderungen am Repository in VS Code angezeigt und rückgängig gemacht werden können.

1\. Öffne VS Code im Verzeichnis `labs/02-basic-staging/exercise`.

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/885e38c2-d478-43a7-b4ab-05560a315600/ascreenshot_e95e1b30e5c4475cbf94b2bbc29b108c_text_export.jpeg)


2\. Klicke auf die Datei "file.txt" und schau dir den Inhalt an

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/885e38c2-d478-43a7-b4ab-05560a315600/ascreenshot_13ffa4bebd0d42f39477f0033fa12400_text_export.jpeg)


3\. Klicke nun auf das Repository-Symbol

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/1915129f-5feb-4173-a2b3-92e0f492b67e/ascreenshot_f3c88afb1e794ce49ac99b70cd2e86f5_text_export.jpeg)


4\. Du siehst: Aktuell gibt es keine Änderungen. Gehe zurück in die Dateiansicht

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/30779c65-1514-4712-96ae-a5d18fb1d523/ascreenshot_9877bdb35a7b4b29b4bcab683742b7ea_text_export.jpeg)


5\. Ändere den Inhalt der Datei zu "v2". Klicke dann auf die blaue Linie neben dem Text

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/0afdaaf7-5c9c-434b-a296-7c6de665d809/ascreenshot_96caf0078a714690a79af9e0f5977ac4_text_export.jpeg)


6\. Click here.

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/08faf806-062b-4d50-920d-50b35fa41dd4/ascreenshot_6893a47c1b7b479aace3a639ae527e3e_text_export.jpeg)


7\. Du siehst die Änderungen im Vergleich zum Stand des Repositories. Hier könntest du sie auch rückgängig machen - tu dies aber nicht

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/106950a9-d501-4c6d-8a83-869dbb6e0c82/ascreenshot_dff09a869ff34877b82d4f07c0b4454b_text_export.jpeg)


8\. Gehe in die Repository-Ansicht

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/58e5f9ca-2d22-42d5-8449-58f416e1ebfd/ascreenshot_29d96c47e42f4b80829eb4a6e13855ca_text_export.jpeg)


9\. Klicke auf das "+", um deine Änderung dem Staging hinzuzufügen

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/2d739267-aeaa-4cc3-8c6e-5045fb39d4f9/ascreenshot_ba29652b0eab4cceac642b6e12bdef97_text_export.jpeg)


10\. Ändere den Dateinhalt zu "v3". Die blaue Linie zeigt wieder an, dass es Änderungen gibt. Klicke auf sie

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/73fbf631-a360-4889-9c84-e941fa6f9f34/ascreenshot_19c34da64a0f4e9f927a83fb993e1060_text_export.jpeg)


11\. Über den Dropdown kannst du nun auswählen, ob du den Unterschied der Zeile zum Stand des Repositories sehen willst oder zum Stand des Stagings.

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/1e7d076e-8dee-4a1e-a340-9f87f7f46376/ascreenshot_81a383d1344244038889398ef45086d2_text_export.jpeg)


12\. Klicke auf "Git Local Changes (Index)". Dies zeigt den Unterschied deiner Zeile zum letzten Stand, den du mit dem "+" zum Staging hinzugefügt hast.

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/23d20f63-2aaf-49d2-ac22-bfc94172cdf0/ascreenshot_76e530de5dea4bee8923b59f76b43365_text_export.jpeg)


13\. Wechsle auf "Git Local Changes (Working Tree)". Du siehst die Änderungen im Vergleich zum zuletzt committeten Stand.

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/09b888b3-fdf9-4afe-b926-2544b1e3135a/ascreenshot_365d00a441704f5aa686a86ca48d7c55_text_export.jpeg)


14\. Klicke nun auf das "-", um die Änderungen im Staging zurückzusetzen. Dies wird die Datei selbst nicht verändern, aber dein Staging leeren.

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/24dab890-ec33-4520-b573-7c777e174a00/ascreenshot_c8e65c56322348f39195a8d0e19ac257_text_export.jpeg)


15\. Klicke wieder auf die blaue Linie

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/ec2f1a9d-170e-4ba4-93b4-303f9df6448e/ascreenshot_c9b0124a634b4c759e6b8fe441a0b5ae_text_export.jpeg)


16\. Du siehst, dass nur noch ein Diff zur Verfügung steht: Das vom lokalen Dateizustand zum committeten Stand. Dar Index ("staging") ist verschwunden.

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/0bf5b53f-7153-4fab-93f7-cff4d4c7914f/ascreenshot_f4c633e05f3347e7becb15e757e57824_text_export.jpeg)


17\. Klicke rechts auf die Datei "file.txt"

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/39486410-edb1-4d84-bf69-9bd65c14eb76/ascreenshot_da2cdbf6720444d6b0cc098acf682659_text_export.jpeg)


18\. Klicke auf "Discard Changes"

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/6f54e4d0-1985-493f-83bf-ef141b454e22/ascreenshot_7c221f97157a47ae8f9ebc1214c0c5b6_text_export.jpeg)


19\. Klicke auf "Discard File". Deine Änderungen sind nun auch in der Datei selbst rückgängig gemacht.

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/62f31c96-e1ee-43fb-981d-1a4d007e6770/ascreenshot_8a8f103bfdf84565874884c092a303fc_text_export.jpeg)
