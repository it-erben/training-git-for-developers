# Musterlösung: Code Review Dojo

Diese Musterlösung zeigt für beide Rollen jeweils den Code **vor** und **nach**
dem Review.

## Struktur

```
solution/
├── person-a/          # feature/item-discount
│   ├── before/        # Eingereicht (mit Problemen)
│   └── after/         # Nach Review (korrigiert)
├── person-b/          # feature/customer-export
│   ├── before/        # Eingereicht (mit Problemen)
│   └── after/         # Nach Review (korrigiert)
└── README.md
```

## Person A: Item Discount

### Eingebaute Probleme (before)

| Problem | Kategorie |
|---------|-----------|
| `ApplicationArea` fehlt auf Table- und Page Extension | Inhaltlicher Fehler |
| Keine `MinValue`/`MaxValue` — Rabatt von 999% möglich | Inhaltlicher Fehler |
| `ToolTip` zu generisch | Code-Qualität |

### Erwartete Commit-History (vor Rebase)

```
c3 "WIP"
c2 "fix"
c1 "add discount"
```

### Nach Rebase

```
"feat: add special discount field to Item Card"
```

## Person B: Customer Export

### Eingebaute Probleme (before)

| Problem | Kategorie |
|---------|-----------|
| Hardcodierter Filter `'DE'` statt Parameter | Hardcoding |
| `FindSet()` ohne Prüfung ob Daten vorhanden | Fehlender Fehlerfall |
| Hardcodiertes Trennzeichen und Dateiname | Hardcoding |

### Erwartete Commit-History (vor Cleanup)

```
c2 "bump version to 1.1.0"   ← unzugehörige Änderung (app.json)
c1 "add customer export"
```

### Nach Cleanup

Version-Bump-Commit entfernt, ein sauberer Commit:

```
"feat: add customer CSV export codeunit"
```

## Beispiel-Review-Kommentare

Ein gutes Review von Person A's Code enthält mindestens:

| # | Typ | Kommentar |
|---|-----|-----------|
| 1 | Inhaltlicher Fehler | `ApplicationArea` fehlt — Feld wird in SaaS nicht sichtbar |
| 2 | Inhaltlicher Fehler | Keine `MinValue`/`MaxValue` — Rabatt von 999% oder -50% möglich |
| 3 | Code-Qualität | `ToolTip` ist zu generisch, sollte beschreiben was das Feld tut |
| 4 | Commit-Hygiene | 3 Commits für eine Änderung, Messages nicht aussagekräftig → squashen |
| 5 | Positiv | Gute Wahl der Object-IDs im 50000er-Range, saubere Struktur |

Kommentare zu #1 oder #2 eignen sich für eine **GitHub Suggestion**:

````markdown
```suggestion
field(50100; "Special Discount %"; Decimal)
{
    ApplicationArea = All;
    MinValue = 0;
    MaxValue = 100;
}
```
````
