# Lab 03: .gitignore in VS Code

Sehe das Verhalten von .gitignore in VS Code.

Öffne VS Code im Verzeichnis `labs/03-ignore/exercise`.

1\. Klicke auf "New File..."

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/e4a8cc2d-e068-4d4d-89af-ecb43f26a33e/sps-redacted-3b5c2da97cda4c10a7189ca47e6dfc5e_d4fc9953b3744586a1af7a31fcaa0e5e_text_export.jpeg)

2\. Vergebe den Namen [[foo.s]]. Füge beliebigen Inhalt in die neue Datei hinzu. Füge danach mit "New file..." eine weitere Datei hinzu.

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/115f2654-19db-48c7-a9a9-3fb3f2964b6a/sps-redacted-2cf4992fb4c5427f89c167df851c8b76_495757a223e24e73b1ed73e33917fb35_text_export.jpeg)

3\. Nenne die Datei [[.gitignore]]

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/7fd35824-e907-43a9-877f-b651e2cd97f7/sps-redacted-a61c83899fe049ddae9709ecf3b0bdc1_6e69cd64efa34c4b86012123c091ca8a_text_export.jpeg)

4\. Füge in die neue Datei den Inhalt [[\*.s]] hinzu. Dir wird kurz darauf auffallen, dass die Datei [[foo.s]] im Dateibrowser ausgegraut ist. Das bedeutet, dass Änderungen an dieser Datei nun von Git ignoriert werden

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/79f0daca-82fb-46da-a38d-8dcfca322214/sps-redacted-bae4640714e24747b172707b87aaf98f_fd3e1e678a8a4185a7da7d4d476f9d3f_text_export.jpeg)

5\. Klicke auf den Knopf für die Repository-Ansicht

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/d98b5bba-a3b7-4dad-8ffc-8a6cfefba972/sps-redacted-f494cf6ad30344ab93f019b1b189b16b_bc375d5c9f0446bb86c7de16670e84f0_text_export.jpeg)

6\. Füge mit dem [[+]]  beide offenen Änderungen der Staging Area hinzu

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/e8109aa5-58d7-4de0-9224-3613ac35fea2/sps-redacted-a95f8a4fc9fd47609565b01aafb9a650_17f407c3790d4b7fad61a3f68b66bafb_text_export.jpeg)

7\. Committe die Änderungen mit einer beliebigen Message. Nun ist auch die .gitignore im Repository committet.

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/9714ff52-3991-46e2-bc3e-7805f5c07f8d/sps-redacted-c19cb9517fa3464c9e9958e6e170a49d_66d54164132645c6b46cee2ec4276c54_text_export.jpeg)

8\. Wir wollen nun sehen, was passiert, wenn man Änderungen an Dateien macht, die nicht von Anfang an in der [[.gitignore]] waren. Füge der [[.gitignore]] die Zeile [[file1.txt]] hinzu

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/78824889-cd23-44ed-b0f0-36b696567f13/sps-redacted-1a1285def4ef4d2b8c9eba56421aeb5c_c7bf5aed3b2b43ea93110a9f9ba2c43a_text_export.jpeg)

9\. Öffne die Dateiansicht

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/22b2126f-ecc6-420b-a4db-868047112aa1/sps-redacted-a8b3fe22bab443d2877718a116958aa6_b59fa80d76874a3d9beb5687c598b519_text_export.jpeg)

10\. Wähle die Datei [[file1.txt]]

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/8da41ec9-b190-4bf5-940e-91b62e12ff3e/sps-redacted-d9575884962b448fb4551ef84ae60fed_032118f2233d4777b6e4eecc23c21e28_text_export.jpeg)

11\. Füge eine weitere Zeile in der Datei hinzu mit beliebigem Inhalt

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/22e059c5-6111-45c8-9464-ff35f2d05b04/sps-redacted-e22b1fb5ed33473c986ebdf417693008_c19b58cdd931492dbe40b7a3302ae6eb_text_export.jpeg)

12\. Gehe wieder in die Repository-Ansicht. Die Datei test.txt wird als geändert erscheinen, obwohl sie in der .gitignore ist! Das liegt daran, dass sie schon existierte, als sie noch nicht von Git ignoriert wurde.

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/95767cf3-3113-42c1-ad07-c6c9c6d7fd9c/screenshot_98458e1892d644c3b5f0e24e5d86bb83_text_export.jpeg)

13\. Klicke im Menü auf "View" -> "Terminal" und gebe den Befehl [["git rm --cached file1.txt"]]  ein.

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/409a20bc-9af8-40b2-945f-e5e79101aa61/sps-redacted-2f90faee489041958225a8a509cbbc12_9180a1682cb548d9b026401ac7c851f7_text_export.jpeg)

14\. Wechsle auf die Repository-Ansicht. Du siehst, dass die endgültige Löschung von [[file1.txt]] im Staging ist.

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/5de61927-eeaf-4a87-b8b6-0eb8cc46ac34/sps-redacted-25edc7aeb70341949a5bd27b77cea539_524d1ce22b284f3d869a6db1aa6c11f5_text_export.jpeg)

15\. Commite die Änderung mit einer beliebigen Message. Die Datei ist nun aus dem Index entfernt, aber weiterhin auf deiner Festplatte vorhanden.

![](https://colony-recorder.s3.amazonaws.com/files/2026-03-19/29709dbf-046d-400c-bfa5-1a698a0172b9/sps-redacted-c3779f312f2e4a37aa99989cb9e558e9_671753fe6df1460d904d66ff06414cb2_text_export.jpeg)
