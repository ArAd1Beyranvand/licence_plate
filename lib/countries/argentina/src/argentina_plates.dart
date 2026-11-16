import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'argentina_colors.dart';
import 'argentina_country.dart';
import 'argentina_themes.dart';

/// Where the ink sits. Every plate was flattened to the 400×130 mm plate the
/// article gives (`.plateref/ar/flat_*.png`, 4× scale) and projected onto each
/// axis; the numbers below are in plate units.
///
/// Serial ink is ~73–76 tall (Mercosur 70). At 0.55 ink per box that wants a
/// box of ~133, more than the 130 canvas, so `_slot` caps the box at the
/// largest that fits around the row's centre: ~95% of reference on the banded
/// plates, ~79% on Mercosur, ~72% on the 1985 plates, whose serial sits high.
///
/// The photographed plates are squashed by flattening, so only extents and
/// centres are used. Field boundaries inside a contiguous run (`A004DCM`) are
/// not visible in the ink projection; they are placed on the even glyph pitch.
abstract final class _Layout {
  static const double width = 400, height = 130;

  /// Reference ink height per box. See `plate_creator`: glyph ≈ ink / 0.55.
  static const double inkPerBox = 0.55;

  /// Mercosur: blue band ends at y 37 (`Mercosur_-B`: 5.8–35.8 blue, white
  /// from 37). Serial ink y 45.2–115.
  static const double mercosurBandEnd = 37;
  static const (double, double) mercosurInk = (45.2, 115);

  /// 1995 plates: grey face y 0–24, band y 24–108 (`A004DCM` blue 24–108,
  /// trailer black 23.8–106.5), face below. Serial ink y 29.8–103.2.
  static const double bandStart = 24, bandEnd = 108;
  static const (double, double) bandInk = (29.8, 103.2);

  /// 1995 caption rows (ink): `ARGENTINA` y 9–24, centred on x 195.5 (ink
  /// 118–273); `PROPIEDAD MRECIyC` y 115–124, ink x 120.5–252.
  static const double topCaptionY = 16.5, bottomCaptionY = 119.5;

  /// 1985 plates: serial ink y 11.5–87.8, caption `REP. ARGENTINA` y
  /// 92.5–120.5, ink x 56–335. The dash is a glyph between the two fields.
  static const (double, double) ink1985 = (11.5, 87.8);
  static const double caption1985Y = 106.5, caption1985X = 195.5;
  static const double caption1985Width = 279;

  /// Legacy black plate: ink y 9–119.2.
  static const (double, double) legacyInk = (9, 119.2);
}

/// One field: a run printed and typed as a unit. [left]/[right] is the
/// measured ink span.
class _Field {
  const _Field(this.key, this.alphabet, this.left, this.right, this.length);

  final String key;
  final PlateAlphabet alphabet;
  final double left, right;
  final int length;
}

const PlateAlphabet _letters = ArgentinaAlphabets.letters;
const PlateAlphabet _digits = ArgentinaAlphabets.digits;

_Field _l(String key, double l, double r, int n) =>
    _Field(key, _letters, l, r, n);

_Field _d(String key, double l, double r, int n) =>
    _Field(key, _digits, l, r, n);

/// The glyph height for a row of ink between [ink].$1 and [ink].$2, and the
/// row's centre.
(double, double) _glyph((double, double) ink) {
  final double cy = (ink.$1 + ink.$2) / 2;
  final double box = min(
    (ink.$2 - ink.$1) / _Layout.inkPerBox,
    2 * min(cy, _Layout.height - cy),
  );
  return (box, cy);
}

PlateSlot _slot(_Field f, (double, double) ink, {Color? color}) {
  final (double box, double cy) = _glyph(ink);
  final double width = f.right - f.left, pitch = width / f.length;
  return PlateSlot(
    alphabet: f.alphabet,
    box: PlateBox(f.left, cy - box / 2, width, box),
    length: f.length,
    spacing: f.length == 1 ? 0 : plateRunSpacing(pitch, box),
    color: color,
  );
}

List<PlateTextGroup> _groups(List<_Field> fields) =>
    PlateTextGroup.perSlot(<String?>[for (final f in fields) f.key]);

PlateLabel _caption(
  String text,
  double cx,
  double cy,
  double width,
  double glyph, {
  Color? color,
}) => PlateLabel(
  text: text,
  box: PlateBox.centered(cx, cy, width, glyph),
  glyphHeight: glyph,
  color: color,
);

/// The plates of Argentina.
///
/// Groups, in slot order, are named per field (`series`, `number`, `suffix`,
/// `prefix`, `trailer`); the validators read them. Every spec is the 400×130
/// plate with `noPanel`; colour lives on the theme and the background sections.
///
/// Not implemented: the 1940s and 1972–94 plates, the RNPA motorcycle and
/// `ABC 12` plates (historic series); the 2010 motorcycle plate (proportions
/// cannot be measured from the squashed photo); the paper temporary plate and
/// the Transporte Nacional de Cargas plate (no usable image, obsolete). The
/// coat of arms on the 1995 plates is not drawn: there is no vector for it.
///
/// Prose vs picture: the article gives the 1995 mission format `D 123 xx A`;
/// the photographs read `D059 CPX`, and the picture wins. The 1985 `OI` plate
/// OCRs as `01`; it is the letters `OI`.
abstract final class ArgentinaPlates {
  /// `AB 123 CD`, the Mercosur plate.
  static final PlateSpec standard = _mercosur();

  /// `ABC 123`, white on black.
  static final PlateSpec legacy = _spec('ar.legacy', <_Field>[
    _l('series', 16, 173.2, 3),
    _d('number', 234.2, 384, 3),
  ], _Layout.legacyInk);

  /// `101 ABC 123`: the trailer's number, then the primary mover's plate.
  static final PlateSpec trailer = _banded(
    'ar.trailer',
    <_Field>[
      _d('trailer', 16, 118.8, 3),
      _l('series', 142.5, 258.2, 3),
      _d('number', 280.5, 384, 3),
    ],
    band: ArgentinaColors.legacyBlack,
    mission: false,
  );

  /// `D 123 ABC`: the category letter is a chosen slot (D diplomatic, C
  /// consular, M special missions, I international, A administrative staff).
  static final PlateSpec mission = _mission();

  /// `CD-1234` (1985 series), the category chosen from CD, CC, ME, OI, PA.
  /// Diplomatic is black on white, the rest red on teal
  /// ([ArgentinaThemes.byMission1985]).
  static final PlateSpec mission1985 = _mission1985();

  static List<PlateSpec> get all => <PlateSpec>[
    standard,
    legacy,
    trailer,
    mission,
    mission1985,
  ];
}

const PlatePanel _noPanel = PlatePanel(box: PlateBox(0, 0, 1, 1));

PlateSpec _spec(
  String id,
  List<_Field> fields,
  (double, double) ink, {
  PlateSection background = PlateSection.plain,
  Color? slotColor,
  List<PlateLabel> labels = const <PlateLabel>[],
  List<PlateDecal> decals = const <PlateDecal>[],
  PlateThemeResolver? resolveTheme,
}) => PlateSpec(
  id: id,
  country: ArgentinaCountry.argentina,
  canvasWidth: _Layout.width,
  canvasHeight: _Layout.height,
  noPanel: true,
  panel: _noPanel,
  background: background,
  slots: <PlateSlot>[
    for (final _Field f in fields) _slot(f, ink, color: slotColor),
  ],
  labels: labels,
  decals: decals,
  textGroups: _groups(fields),
  resolveTheme: resolveTheme,
);

PlateSpec _mercosur() {
  final List<_Field> fields = <_Field>[
    _l('series', 26, 108, 2),
    _d('number', 137.2, 262.2, 3),
    _l('suffix', 289.5, 372.5, 2),
  ];
  return _spec(
    'ar.standard',
    fields,
    _Layout.mercosurInk,
    background: const PlateSection.rows(<PlatePart>[
      PlatePart(
        PlateSection.fill(PlateFill.color(ArgentinaColors.mercosurBlue)),
        end: _Layout.mercosurBandEnd,
      ),
      PlatePart(PlateSection.plain),
    ]),
    labels: <PlateLabel>[
      // Ink x 108–289, y 12.7–28.5; the face is condensed, so the size is set
      // by the width, not the ink height.
      _caption(
        'REPÚBLICA ARGENTINA',
        198.5,
        20.6,
        181,
        22,
        color: ArgentinaColors.white,
      ),
      _caption('MERCOSUR', 28, 28, 44, 10, color: ArgentinaColors.white),
    ],
    decals: const <PlateDecal>[
      PlateDecal(box: PlateBox(360, 9, 32, 20), drawing: ArgentinaCountry.flag),
    ],
  );
}

/// The 1995 mission plates: `ARGENTINA`, a blue band with the serial in white,
/// `PROPIEDAD MRECIyC`. Fields: category letter, three digits, three letters,
/// on the even glyph pitch of the 7-glyph run x 16–384.
PlateSpec _mission() => _banded(
  'ar.mission',
  <_Field>[
    const _Field('prefix', ArgentinaAlphabets.missionClass, 16, 68.6, 1),
    _d('number', 68.6, 226.3, 3),
    _l('suffix', 226.3, 384, 3),
  ],
  band: ArgentinaColors.missionBlue,
  mission: true,
);

PlateSpec _banded(
  String id,
  List<_Field> fields, {
  required Color band,
  required bool mission,
}) {
  return _spec(
    id,
    fields,
    _Layout.bandInk,
    slotColor: ArgentinaColors.white,
    background: PlateSection.rows(<PlatePart>[
      const PlatePart(PlateSection.plain, end: _Layout.bandStart),
      PlatePart(PlateSection.fill(PlateFill.color(band)), end: _Layout.bandEnd),
      const PlatePart(PlateSection.plain),
    ]),
    labels: <PlateLabel>[
      _caption(
        'ARGENTINA',
        195.5,
        _Layout.topCaptionY,
        155,
        27,
        color: ArgentinaColors.missionCaption,
      ),
      if (mission)
        _caption(
          'PROPIEDAD MRECIyC',
          186.3,
          _Layout.bottomCaptionY,
          132,
          16,
          color: ArgentinaColors.missionCaption,
        ),
    ],
  );
}

/// `CD-1234`: two letters, a dash and four digits over `REP. ARGENTINA`. The
/// seven glyphs run x 16–377.8 on a 51.7 pitch: letters 16–119.4, dash
/// 119.4–170.9, digits 170.9–377.8.
PlateSpec _mission1985() {
  final List<_Field> fields = <_Field>[
    const _Field('prefix', ArgentinaAlphabets.mission1985Class, 16, 119.4, 1),
    _d('number', 170.9, 377.8, 4),
  ];
  final (double glyph, double cy) = _glyph(_Layout.ink1985);
  return _spec(
    'ar.mission1985',
    fields,
    _Layout.ink1985,
    resolveTheme: ArgentinaThemes.byMission1985,
    labels: <PlateLabel>[
      PlateLabel(
        text: '-',
        box: PlateBox(119.4, cy - glyph / 2, 51.5, glyph),
        glyphHeight: glyph,
      ),
      _caption(
        'REP. ARGENTINA',
        _Layout.caption1985X,
        _Layout.caption1985Y,
        _Layout.caption1985Width,
        42,
      ),
    ],
  );
}
