import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'south_africa_country.dart';

/// Where the ink sits, in plate units, on the 520×110 mm plate of the
/// infobox.
///
/// The flattened photographs were stretched to 520×141, so every y measured
/// off them is multiplied by 110/141. The Limpopo and Eastern Cape photos fit
/// at aspect 4.85–4.96 (the plate's own 4.7), which is why they are trusted
/// for y.
///
/// * standard `AAA 123 PP`, flat Limpopo and Eastern Cape: letters x
///   21.8–153, ink y 17.5–131 → 13.7–102; digits x 224.2–353.8; suffix x
///   421.5–499 (`EC`; Limpopo's single `L` sits at 465.5–499).
/// * modern `AA 00 AA PP`, a 250 px Gauteng photograph scaled by 520/250 (x
///   only; its y is not trusted): `BS` x 18.7–93.6, `24` 141.4–218.4, `LD`
///   266–341, `GP` 414–491. Estimated, not measured on a flattened plate.
/// * government yellow, flat Transvaal 1978: ink y 22.2–119.5 of a 4.68
///   plate, field `F8E000`, ink black.
///
/// Ink is ~55% of a slot box (`glyphStyle`: 0.72 of the box, a cap three
/// quarters of that). The references' ink is 84–88 units tall, which would
/// need a box of ~155 on a 110-unit plate; the box is capped at 100, so the
/// ink lands at ~63% of the reference. The 0.72 is the engine's and is left
/// alone.
abstract final class _Layout {
  static const double width = 520, height = 110, box = 100, cy = 57;
}

/// One field: its group key, alphabet, x-span and its length range.
class _Field {
  const _Field(
    this.key,
    this.letters,
    this.left,
    this.right,
    this.length, {
    this.min,
  });

  final String key;
  final bool letters;
  final double left, right;
  final int length;
  final int? min;
}

/// South Africa's plates, on one design per field layout.
///
/// * [standard] — `ABC 123 EC`: three letters, up to three digits, and the
///   province suffix of one or two letters (`L`, `MP`, `EC` ...). Black on
///   white in most provinces, green in the Northern Cape, black on a printed
///   landscape in the Eastern Cape, Free State and North West, black on yellow
///   for government (`G`) and defence-force (`M`) vehicles.
/// * [modern] — Gauteng and KwaZulu-Natal `BS 24 LD GP`, blue on white.
///
/// Not implemented: the provincial emblems, crests and landscapes (artwork,
/// not drawn); the Western Cape `CA 123-456` plate (its photos are too small
/// to place the dash); diplomatic plates (`C BBN 371 D`, no picture in the
/// article); police plates (the only photo is a blurred Gauteng crop); and the
/// 1963–1980 Cape, Transvaal and homeland plates, which are obsolete.
abstract final class SouthAfricaPlates {
  static final PlateSpec standard = _build('za.standard', const <_Field>[
    _Field('series', true, 22, 153, 3),
    _Field('number', false, 224.5, 353.5, 3, min: 1),
    _Field('province', true, 421.5, 499, 2, min: 1),
  ]);

  static final PlateSpec modern = _build('za.modern', const <_Field>[
    _Field('series', true, 18.7, 93.6, 2),
    _Field('number', false, 141.4, 218.4, 2),
    _Field('letters', true, 266, 341, 2),
    _Field('province', true, 414, 491, 2, min: 1),
  ]);

  static List<PlateSpec> get all => <PlateSpec>[standard, modern];

  static PlateSpec _build(String id, List<_Field> fields) {
    final List<PlateSlot> slots = <PlateSlot>[];
    final List<PlateTextGroup> groups = <PlateTextGroup>[];
    for (final _Field f in fields) {
      groups.add(PlateTextGroup(<int>[slots.length], key: f.key));
      final double width = f.right - f.left;
      slots.add(
        PlateSlot(
          alphabet: f.letters
              ? SouthAfricaAlphabets.letters
              : SouthAfricaAlphabets.digits,
          box: PlateBox(
            f.left,
            _Layout.cy - _Layout.box / 2,
            width,
            _Layout.box,
          ),
          length: f.length,
          minLength: f.min,
          spacing: f.min != null
              ? 0
              : plateRunSpacing(width / f.length, _Layout.box),
        ),
      );
    }
    return PlateSpec(
      id: id,
      country: SouthAfricaCountry.south_africa,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      slots: slots,
      textGroups: groups,
    );
  }
}
