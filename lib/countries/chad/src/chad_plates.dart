import 'dart:math';

import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'chad_country.dart';
import 'chad_regions.dart';

/// Where the ink sits, in plate units.
///
/// Size 520×110 from the article. Both references are photographs flattened
/// to that rectangle and projected onto each axis.
///
/// Regular (`23V1234A`): ink y 13.5–97 (centre 55.25), characters
/// x 20.8–~447 in eight evenly spaced cells (pitch 53.25, read off the sheet).
/// CEMAC roundel x 456.5–503.5, y 12.5–59; "TCH" below it, ink about 28 tall.
///
/// Temporary (`09C0329TT`): ink y 10.2–91.5 (centre 50.85), nine cells from
/// x 20.8 to ~400 (pitch ~42.2, read off the sheet). The same roundel and
/// "TCH" sit at the right; the dealer strip along the bottom edge ("DIAGNOSE
/// PLAQUES …") and the year stamp are not drawn.
///
/// The reference ink is ~83 tall on a 110 plate; reproducing it needs a
/// ~150-unit box, so the box is capped at 104 and the ink lands near 65%.
/// The CEMAC roundel is left blank: Commons has no standalone vector.
abstract final class _Layout {
  static const double width = 520, height = 110, box = 104, left = 20.8;

  static const double regularCy = 55.25, regularPitch = 53.25;
  static const double temporaryCy = 50.85, temporaryPitch = 42.2;

  static const PlateBox tch = PlateBox(456, 66, 48, 36);
  static const double tchGlyph = 44;
}

/// Chad's plates, 2001 scheme on the French FNI model.
///
/// * `private`: `23 V 1234 A`, black on white. Groups `region` (2 digits),
///   `type` (1 letter), `number` (4 digits), `tail` (the series letter).
/// * `temporary`: `09 C 0329 TT`, light on red; the same groups, the tail
///   being the two-letter `TT`.
///
/// Not implemented: taxi (blue), state and gendarmerie (yellow), police
/// (red), military (painted yellow) and diplomatic plates. The article gives
/// colours only as prose and has no picture of them.
abstract final class ChadPlates {
  static final PlateSpec private = _spec(
    id: 'td.private',
    tailCount: 1,
    cy: _Layout.regularCy,
    pitch: _Layout.regularPitch,
  );

  static final PlateSpec temporary = _spec(
    id: 'td.temporary',
    tailCount: 2,
    cy: _Layout.temporaryCy,
    pitch: _Layout.temporaryPitch,
  );

  static List<PlateSpec> get all => <PlateSpec>[private, temporary];

  static PlateSpec _spec({
    required String id,
    required int tailCount,
    required double cy,
    required double pitch,
  }) {
    final List<PlateSlot> slots = <PlateSlot>[];
    int cells = 0;
    void run(String key, PlateAlphabet alphabet, int count) {
      slots.add(
        plateRun(
          alphabet,
          count,
          left: _Layout.left + cells * pitch,
          top: max(0, cy - _Layout.box / 2),
          pitch: pitch,
          height: _Layout.box,
          group: key,
        ),
      );
      cells += count;
    }

    run('region', ChadAlphabets.digits, 2);
    run('type', ChadAlphabets.letters, 1);
    run('number', ChadAlphabets.digits, 4);
    run('tail', ChadAlphabets.letters, tailCount);
    return PlateSpec(
      id: id,
      country: ChadCountry.chad,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      slots: slots,
      labels: const <PlateLabel>[
        PlateLabel(
          text: 'TCH',
          box: _Layout.tch,
          glyphHeight: _Layout.tchGlyph,
        ),
      ],
      resolveRegion: ChadRegions.captionOf,
    );
  }
}
