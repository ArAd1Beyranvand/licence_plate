# license_plate

Every licence plate in one Flutter package. A single dependency gives you the plate engine, shared alphabets, an on-screen keypad and the plates of **182 countries and territories** — flags, fonts and panels included.

A plate is a `const PlateSpec` (canvas geometry, a country panel, slots over alphabets, optional chrome); the widget layer paints whatever the spec says. Adding a plate means adding a const, never a widget.

## What is inside

| Folder | Contents |
| --- | --- |
| `lib/core` | the country-neutral engine: `PlateCanvas`, `PlateSpec`, `PlateController`, validators, themes |
| `lib/alphabet` | shared digit and letter alphabets |
| `lib/keypad` | the optional on-screen `PlateKeypad` and `PlateCharacterPicker` |
| `lib/countries` | one folder per country: `IranPlates`, `GermanPlates`, `FrancePlates`, … plus their themes and assets |

## Install

```yaml
dependencies:
  license_plate: ^0.1.1
```

## Use

```dart
import 'package:flutter/material.dart';
import 'package:license_plate/license_plate.dart';

class MyPlate extends StatelessWidget {
  const MyPlate({super.key});

  @override
  Widget build(BuildContext context) {
    return PlateCanvas(
      spec: ItalyPlates.private,
      theme: ItalyThemes.private,
      // Slots whose alphabet is *chosen* open the keypad's picker.
      onChooseCharacter: (alphabet) =>
          PlateCharacterPicker.show(context, alphabet),
    );
  }
}
```

That is a complete, editable plate: no provider, no bloc, no `Scaffold`.

### Read or drive the characters

A `PlateCanvas` owns its characters in a `PlateController` (a `ChangeNotifier`). Pass your own to read or write the value, follow the active slot, or validate:

```dart
final controller = PlateController(spec: FrancePlates.private);

PlateCanvas(
  spec: FrancePlates.private,
  theme: FranceThemes.private,
  controller: controller,
  onChooseCharacter: noCharacterChooser, // nothing here needs a picker
);
```

Swapping `spec:` on a live canvas carries the value across, matching registers by group key.

### Import only what you need

The barrel file exports everything. To keep a smaller surface, import one part:

```dart
import 'package:license_plate/core/plate_core.dart';
import 'package:license_plate/countries/iran/iran_plate.dart';
```

## Spec and theme per country

Every country exposes `<Country>Plates` (the layouts), `<Country>Themes` (the colours) and `<Country>Country` (the panel and flag):

```dart
PlateCanvas(
  spec: IranPlates.forUsage(IranUsage.taxi),
  theme: IranThemes.forUsage(IranUsage.taxi),
  onChooseCharacter: noCharacterChooser,
);
```

## The model

| Type | Role |
| --- | --- |
| `PlateSpec` | the plate: size, panel, slots, text groups, labels |
| `PlateSlot` + `PlateAlphabet` | one run of characters and what it may hold |
| `PlateCountry` | the panel: flag (SVG or raster) and wording |
| `PlateTheme` | colours; a spec can resolve a theme from what was typed |
| `PlateValidator` | judges a plate — advisory, never blocks a keystroke |
| `PlateController` | the characters, the active slot, validation |

## Example

A runnable gallery lives in [`example/`](example). On Linux:

```sh
cd example
flutter run -d linux
```

## Also published separately

The same code ships as individual packages — [`plate_core`](https://pub.dev/packages/plate_core), [`plate_alphabet`](https://pub.dev/packages/plate_alphabet), [`plate_keypad`](https://pub.dev/packages/plate_keypad) and one `<country>_plate` per country — plus Kotlin, Python and TypeScript ports. Choose `license_plate` when you want everything behind one import; choose the individual packages to depend on a single country.

## License

See [LICENSE](LICENSE).
