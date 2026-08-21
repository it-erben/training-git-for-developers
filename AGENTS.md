# Arbeitsregeln

## Ton

- Knapp. Sag, was zu sagen ist, dann Schluss. Kein Vorgeplänkel, keine
  Zusammenfassung des gerade Getanen, kein „gute Frage“, kein Wiederholen der
  Aufgabe.
- Keine Füll-Adjektive (robust, nahtlos, mächtig, umfassend, produktionsreif).
  Knapp sagen, was der Code tut, nicht wie gut er ist. Nicht paraphrasieren, was
  die nächsten Zeilen tun. Stattdessen das WARUM und WIE erklären, wenn das dem
  Verständnis wirklich hilft.
- Docs und READMEs: was es ist, wie man es nutzt, was es bereitstellt. Sonst
  nichts.
- Commit-Nachrichten: conventional-commit, Imperativ, möglichst einzeilig. Den
  Scope richtig wählen — Release-Tooling routet unter Umständen darüber. Breaking
  Changes bekommen ein `!` (`feat(api)!: …`) oder einen `BREAKING CHANGE:`-Footer.
  Betreffzeile ≤ 72 Zeichen, Imperativ („add“, „fix“, nicht „added“, „fixes“).
  Body auf 72 Zeichen umbrechen.
- Kleine, fokussierte Commits bevorzugen. Release-Tooling leitet Versionssprünge
  und Changelog oft aus den Commit-Betreffzeilen ab.
- Keine Ticket-Nummern in Code, Commits oder Docs.
- Kommentare erklären das *Warum*, nicht das *Was*. Code-Kommentare benennen die
  Absicht oder eine Einschränkung, die der Code nicht zeigen kann. Kommentare
  löschen, die den Code nur wiederholen.
- Kommentare und Docs immer als Ganzes betrachten. Nie nur anhängen. Im Kontext
  prüfen und auf den faktischen Stand bringen. Im Zweifel im Code recherchieren.
  Veraltete und aus dem Kontext gefallene Verweise entfernen, ebenso frühere
  Beobachtungen, Schilderungen von Situationen, die zu einer früheren Änderung
  führten, Maschinennamen oder -adressen sowie jede Vermutung über die
  nachgelagerte Nutzung dieses Repos und seiner Artefakte — abgesehen von
  gültigen, aktuellen Beispielen.
- Auf ein anderes Repository oder Projekt nur verweisen, wenn dessen Zustand der
  unmittelbare Grund für die Änderung ist (ein Dependency-Bump, ein eingespielter
  Fix, ein an eine veröffentlichte Version gebundener API-Vertrag). Kontext für
  Reviewer, Dank oder Querverweise gehören in den PR-Thread oder ein Issue, nicht
  in den Commit.
- Deklarative Fakten schreiben. Keine Personalpronomen („ich“, „wir“, „du“).
  Keine Leseransprache: kein „beachte, dass…“, „wie man sieht…“, „wir haben uns
  entschieden…“, „das sollte helfen…“. Die Regel gilt für Dokumentation, die
  ein Artefakt beschreibt. Ausgenommen sind Folien und Lab-Anleitungen, siehe
  unten.
- Nicht erzählen. Keine Historie, was zuerst versucht wurde, was scheiterte oder
  welche Alternativen erwogen wurden.
- Keine Füll-Verben ohne Konkretes. „Aufräumen“, „verbessern“, „refactoren“
  allein sagen nichts; entweder die tatsächliche Änderung benennen oder die Zeile
  weglassen.
- Keine Checklisten, keine „Summary“-/„Test plan“-Abschnitte, keine
  Marketing-Sprache, keine Emojis.

## Folien

Sieben Marp-Decks unter `slides/<NN-thema>/slides.md`. Lehrmaterial, das die
Pronomen- und Leseransprache-Regel aufhebt.

- **Geduzt.** „du“, „dir“, „dein“. Nicht siezen und nicht ihrzen; das Verhältnis
  liegt bei 33 zu 2 gegen Siezen.
- Frontmatter: `header: "Modul NN: Thema"`, `footer: "CC BY-NC-SA 4.0,
  Alexander Erben"`, `paginate: true`.
- Titelfolie ist `# Modul NN`, darunter `## Thema: Kurzformel`. Danach
  `## Lernziele` als stichwortartige Liste dessen, was das Modul klärt — keine
  ganzen Sätze.
- Alle weiteren Folientitel sind `##`.
- Git-Konzepte über das Modell erklären, nicht über die Kommandozeile: ein
  Branch ist ein beweglicher Zeiger, `HEAD` zeigt auf einen Branch. Das
  Kommando kommt danach.
- Zeigt eine Folie einen Zustand, dann als Zeiger-Notation mit `→`
  (`` `main` → zeigt auf Commit `a1b2` ``).
- Hash-Beispiele bleiben kurz und erfunden (`a1b2`, `c3d4`), nie aus einem
  echten Repo kopieren.
- Neue Decks in die Tabelle in `slides/README.md` eintragen. Sie ist das
  Inhaltsverzeichnis des Kurses.

## Lab-Anleitungen

27 Labs unter `labs/NN-thema/`. Die Nummer ist die Reihenfolge im Kurs.

- Geduzt wie die Folien; das Verhältnis liegt bei 389 zu 4 gegen Siezen.
- **Zwei Werkzeugvarianten.** Labs 01–18 und 20 haben je eine
  `terminal/README.md` und eine `vscode/README.md`. Die `README.md` des Labs
  ist dann nur ein Deckblatt: ein Absatz zum Thema plus eine Tabelle
  „Variante | Link“. Die eigentliche Anleitung steht in den Varianten, nie im
  Deckblatt.
- Eine Variantenanleitung beginnt mit einem Absatz, der an das vorherige Lab
  anschließt und die Frage stellt, die dieses Lab beantwortet („Aber was
  passiert, wenn auf beiden Branches die gleiche Stelle geändert wurde?“).
- Danach `## Aufgaben`, darin `###`-Zwischenüberschriften für die Phasen
  („Den Konflikt auslösen“, „Den Konflikt verstehen“, „Den Konflikt lösen“,
  „Ergebnis prüfen“).
- **Die Nummerierung läuft über die Zwischenüberschriften hinweg durch.** Ein
  neuer `###`-Abschnitt beginnt nicht wieder bei 1. Beim Einfügen eines
  Schrittes alle folgenden Nummern nachziehen.
- Jeder Schritt nennt das Kommando im Fence und darunter, was Git daraufhin
  meldet. Die Ausgabe ist Teil der Aufgabe, nicht Beiwerk.
- Ausgabe von Git in Fettschrift zitieren, wo sie ein Zustand ist
  (**both modified**).
- `> **Tipp:**` als Blockzitat für Wege, die nicht zum Lösungsweg gehören.
- Abschluss ist `## Nützliche Befehle`, eine Tabelle Befehl → Beschreibung mit
  genau den Kommandos, die im Lab vorkamen, plus dem Notausstieg
  (`git merge --abort`).
- Knapp auf Satzebene gilt weiterhin: keine Füll-Adjektive, kein Marketing,
  keine Zusammenfassung des Abschnitts darüber.

## Vor dem Abschluss

- Lint, Tests und Build des Projekts für alles Berührte ausführen.
- `pre-commit run --all-files` laufen lassen und alle Befunde beheben.
- Ein berührtes Lab wirklich aufsetzen und durchspielen:
  `cd labs/NN-thema && bash setup.sh`, danach `bash clean-all.sh`. Ein Lab,
  dessen Setup nicht läuft, ist im Kurs unbrauchbar.
- Nicht „fertig“ behaupten, ohne die Prüfung ausgeführt zu haben. Belege vor
  Behauptungen.
- Alle TODO-Marker entfernen, die du in deiner Sitzung hinzugefügt hast, und
  nacharbeiten — oder dem Nutzer sagen, dass ein Follow-up nötig ist. Alle Marker
  und Verweise auf deine eigene Aufgabenliste oder historische Arbeitsschritte
  (P2, P3a, Item 1, Task A usw.) samt ihrer Erzählung entfernen. Wenn wirklich
  etwas offen bleibt, dem Nutzer außerhalb von Code, Docs, Markdown, Kommentaren,
  PR-Beschreibungen, Commit-Nachrichten oder allem anderen in diesem Repo und
  seiner angeschlossenen Pipeline Bescheid geben.

## Aufbau dieses Repos

- `slides/01-…` bis `slides/07-…` — sieben Marp-Decks, Index in
  `slides/README.md`.
- `labs/01-…` bis `labs/27-…` — Übungen. 22 davon bringen ein `setup.sh` und
  ein `setup.ps1` mit, die das Übungs-Repository unter `exercise/` in den
  Ausgangszustand versetzen.
- `labs/setup-all.sh` und `labs/clean-all.sh` (plus `.ps1`) fahren über alle
  Labs. Labs ohne `setup.sh` werden übersprungen.
- `labs/README.md` — Installationsanleitung für Teilnehmer, getrennt nach
  Windows und Unix.
- `solutions/` — Lösungshinweise, nur für die Labs 21, 22 und 23.

## Fallstricke dieses Repos

- **Jedes `setup.sh` braucht ein `setup.ps1`.** Der Kurs läuft überwiegend auf
  Windows. Aktuell sind es 22 zu 22; ein neues Lab ohne PowerShell-Variante
  fällt erst im Kurs auf.
- **Die Labs ab 19 haben keine Werkzeugvarianten.** `19-save-my-commit` und
  `21` bis `27` sind werkzeugunabhängig und haben nur eine `README.md`. Dort
  kein `terminal/`- oder `vscode/`-Verzeichnis nachrüsten, ohne den Inhalt
  wirklich zu teilen.
- **Nur drei Labs haben Lösungen.** Die übrigen sind über das Setup-Skript und
  den Endzustand des Übungs-Repositorys verifizierbar, nicht über eine
  Musterlösung.
- **`.snapshots/` ist leer.** Kein Ablageort, kein Mechanismus, der es füllt.
- **Zeilenumbrüche zerreißen Fettschrift.** In
  `labs/07-merge-conflict/terminal/README.md:34` endet eine Zeile auf ein
  einzelnes `*`, die Auszeichnung `**Konfliktmarker**` ist damit kaputt.
  Markdown nach einem Reflow nicht nur linten, sondern gerendert ansehen.
- **markdownlint erlaubt hier 120 Zeichen** (`MD013.line_length: 120`, Tabellen
  und Codeblöcke ausgenommen). Die bestehenden Labs brechen trotzdem bei rund
  80 um; dabei bleiben.
- Beispiel-Repositories in den Labs nutzen `master` als Standardbranch, die
  Folien reden von `main`. Beim Ändern eines Labs den Branchnamen prüfen, der
  im jeweiligen Setup-Skript wirklich entsteht.
