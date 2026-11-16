import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'ghana_colors.dart';
import 'ghana_country.dart';
import 'ghana_themes.dart';

/// Plate-unit measurements, read off flattened reference photos; every plate
/// is 520 wide. The one-row fields are good to a few units. The motorcycle
/// plate is **estimated**: the photo is tilted, low resolution and cut at the
/// top, so its height and first row are guesses.
///
/// Boxes are capped at the row height (112 two-row, 100 one-row), so ink lands
/// at 67-85% of the reference; the engine's 0.72 glyph ratio is left alone.
abstract final class _Layout {
  static const double width = 520;

  static const double markWidth = 30;

  static const double twoRowHeight = 228, twoRowBox = 112;
  static const double twoRowRow1 = 61.8, twoRowRow2 = 168;
  static const PlateBox twoRowFlag = PlateBox(370, 10, 57.5, 38.5);
  static const PlateBox twoRowCode = PlateBox(431, 10, 44, 44);

  static const double oneRowHeight = 110, oneRowBox = 100, oneRowCy = 51;
  static const PlateBox oneRowFlag = PlateBox(460, 30, 38, 25);
  static const PlateBox oneRowCode = PlateBox(459, 71, 40, 24);

  static const double motoHeight = 300, motoBox1 = 90, motoBox2 = 110;
  static const double motoRow1 = 70, motoRow2 = 215;
  static const PlateBox motoFlag = PlateBox(438, 168, 62, 41);
  static const PlateBox motoCode = PlateBox(438, 213, 70, 40);
}

/// One field: its group key, alphabet, ink span, row centre, box height, its
/// longest and shortest length.
class _Field {
  const _Field(
    this.key,
    this.letters,
    this.x0,
    this.x1,
    this.cy,
    this.box,
    this.count, {
    this.min,
  });

  final String key;
  final bool letters;
  final double x0, x1, cy, box;
  final int count;
  final int? min;
}

/// A printed separator or caption centred on ([cx], [cy]).
class _Mark {
  const _Mark(this.text, this.cx, this.cy, this.box);

  final String text;
  final double cx, cy, box;
}

/// Ghana's plates, `AS 2567-12`: region code, one to four digits, year.
///
/// [twoRow] serves private and commercial plates; the theme differs. [oneRow]
/// is the one-row commercial plate, [motorcycle] white on blue with `M-10-AS`
/// over the number.
///
/// Not implemented: agricultural, diplomatic and government plates (no
/// picture), and the superseded yellow and 1980s plates. The ring on the
/// one-row and motorcycle plates is drawn as printed; its purpose is
/// undocumented.
abstract final class GhanaPlates {
  static final PlateSpec twoRow = _build(
    id: 'gh.twoRow',
    height: _Layout.twoRowHeight,
    fields: const <_Field>[
      _Field(
        'region',
        true,
        194,
        315.8,
        _Layout.twoRowRow1,
        _Layout.twoRowBox,
        2,
      ),
      _Field(
        'number',
        false,
        29.2,
        283,
        _Layout.twoRowRow2,
        _Layout.twoRowBox,
        4,
        min: 1,
      ),
      _Field(
        'year',
        false,
        367.2,
        482.8,
        _Layout.twoRowRow2,
        _Layout.twoRowBox,
        2,
      ),
    ],
    marks: const <_Mark>[
      _Mark('-', 322, _Layout.twoRowRow2, _Layout.twoRowBox),
      _Mark('GH', 452, 32, 52),
    ],
    codeBox: _Layout.twoRowCode,
    flag: _Layout.twoRowFlag,
  );

  static final PlateSpec oneRow = _build(
    id: 'gh.oneRow',
    height: _Layout.oneRowHeight,
    fields: const <_Field>[
      _Field('region', true, 22.6, 98, _Layout.oneRowCy, _Layout.oneRowBox, 2),
      _Field(
        'number',
        false,
        156,
        316.5,
        _Layout.oneRowCy,
        _Layout.oneRowBox,
        4,
        min: 1,
      ),
      _Field('year', false, 372, 447, _Layout.oneRowCy, _Layout.oneRowBox, 2),
    ],
    marks: const <_Mark>[_Mark('-', 344, _Layout.oneRowCy, _Layout.oneRowBox)],
    codeBox: _Layout.oneRowCode,
    flag: _Layout.oneRowFlag,
    ring: const PlateRingShape(123, _Layout.oneRowCy, 13, 4, GhanaColors.black),
  );

  static final PlateSpec motorcycle = _build(
    id: 'gh.motorcycle',
    height: _Layout.motoHeight,
    fields: const <_Field>[
      _Field('class', true, 58, 116, _Layout.motoRow1, _Layout.motoBox1, 1),
      _Field('year', false, 182, 275, _Layout.motoRow1, _Layout.motoBox1, 2),
      _Field('region', true, 314, 442, _Layout.motoRow1, _Layout.motoBox1, 2),
      _Field(
        'number',
        false,
        124,
        419,
        _Layout.motoRow2,
        _Layout.motoBox2,
        4,
        min: 1,
      ),
    ],
    marks: const <_Mark>[
      _Mark('-', 151, _Layout.motoRow1, _Layout.motoBox1),
      _Mark('-', 295, _Layout.motoRow1, _Layout.motoBox1),
    ],
    codeBox: _Layout.motoCode,
    flag: _Layout.motoFlag,
    ring: const PlateRingShape(78, _Layout.motoRow2, 33, 5, GhanaColors.ink),
  );

  static List<PlateSpec> get all => <PlateSpec>[twoRow, oneRow, motorcycle];

  static PlateSpec _build({
    required String id,
    required double height,
    required List<_Field> fields,
    required List<_Mark> marks,
    required PlateBox codeBox,
    required PlateBox flag,
    PlateRingShape? ring,
  }) {
    final slots = <PlateSlot>[];
    final groups = <PlateTextGroup>[];
    for (final f in fields) {
      groups.add(PlateTextGroup(<int>[slots.length], key: f.key));
      final double pitch = (f.x1 - f.x0) / f.count;
      slots.add(
        PlateSlot(
          alphabet: f.letters ? GhanaAlphabets.letters : GhanaAlphabets.digits,
          box: PlateBox(f.x0, f.cy - f.box / 2, f.x1 - f.x0, f.box),
          length: f.count,
          minLength: f.min,
          spacing: f.min != null || f.count == 1
              ? 0
              : plateRunSpacing(pitch, f.box),
        ),
      );
    }
    return PlateSpec(
      id: id,
      country: GhanaCountry.ghana,
      canvasWidth: _Layout.width,
      canvasHeight: height,
      slots: slots,
      labels: <PlateLabel>[
        for (final m in marks)
          if (m.text == 'GH')
            PlateLabel(text: m.text, box: codeBox, glyphHeight: m.box)
          else
            PlateLabel(
              text: m.text,
              box: PlateBox.centered(m.cx, m.cy, _Layout.markWidth, m.box),
              glyphHeight: m.box,
            ),
      ],
      decals: <PlateDecal>[
        PlateDecal(drawing: GhanaCountry.flag, box: flag),
        if (ring != null)
          PlateDecal(
            drawing: PlateDrawing(
              (ring.radius + ring.width) * 2,
              (ring.radius + ring.width) * 2,
              <PlateShape>[
                PlateRingShape(
                  ring.radius + ring.width,
                  ring.radius + ring.width,
                  ring.radius,
                  ring.width,
                  ring.color,
                ),
              ],
            ),
            box: PlateBox(
              ring.cx - ring.radius - ring.width,
              ring.cy - ring.radius - ring.width,
              (ring.radius + ring.width) * 2,
              (ring.radius + ring.width) * 2,
            ),
          ),
      ],
      textGroups: groups,
    );
  }

  /// The theme each spec is drawn in by default.
  static PlateTheme themeOf(PlateSpec spec) => switch (spec.id) {
    'gh.twoRow' => GhanaThemes.private,
    'gh.oneRow' => GhanaThemes.commercialOneRow,
    _ => GhanaThemes.motorcycle,
  };
}
