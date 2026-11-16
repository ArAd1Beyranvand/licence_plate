# license_plate

Every licence plate in one Flutter package, with no dependency fan-out.

```dart
import 'package:license_plate/license_plate.dart';
```

| Folder | Contents |
| --- | --- |
| `lib/core` | the country-neutral plate engine (formerly `plate_core`) |
| `lib/alphabet` | shared alphabets (formerly `plate_alphabet`) |
| `lib/keypad` | the on-screen keypad (formerly `plate_keypad`) |
| `lib/countries` | one folder per country, with its plates, themes and assets |

To import a single part, use e.g. `package:license_plate/countries/iran/iran_plate.dart`.
