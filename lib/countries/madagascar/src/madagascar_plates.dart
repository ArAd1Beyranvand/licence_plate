import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'madagascar_country.dart';
import 'madagascar_regions.dart';

/// Plate coordinates on a 520×110 canvas, measured off the reference
/// photographs (`.plateref/mg`) with each field spanning the ink's x extent.
///
/// The temporary plate's photograph is too blurred to measure: the standard
/// geometry is reused with five digits and a three-letter series (`WW` +
/// province), which is estimated.
///
/// **Under-height, accepted.** Reference ink is 74-89 tall on a 110 canvas; a
/// slot's ink is about 55% of its box, so the full 110 box gives about 60.
///
/// **Not drawn.** Red government plates (no picture) and screw holes. The
/// painted military flag is stretched to 2.3:1; the real 3:2 flag is drawn.
abstract final class _Layout {
  static const double width = 520, height = 110;

  static const double flagEnd = 170;
  static const PlatePanel flagPanel = PlatePanel(
    box: PlateBox(0, 0, flagEnd, height),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 25),
  );
}

/// One field's x span on the row: [length] characters of [alphabet], at least
/// [minLength].
class _Field {
  const _Field(
    this.key,
    this.alphabet,
    this.left,
    this.right,
    this.length, [
    this.minLength,
  ]);

  final String key;
  final PlateAlphabet alphabet;
  final double left, right;
  final int length;
  final int? minLength;
}

PlateSpec _row(
  String id,
  List<_Field> fields, {
  List<PlateLabel> labels = const <PlateLabel>[],
  PlatePanel? panel,
  PlateLabelResolver? resolveRegion,
}) {
  return PlateSpec(
    id: 'mg.$id',
    country: MadagascarCountry.madagascar,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    panel: panel ?? const PlatePanel(box: PlateBox(0, 0, 0, 0)),
    noPanel: panel == null,
    background: panel == null
        ? PlateSection.plain
        : PlateSection.columns(<PlatePart>[
            const PlatePart(
              PlateSection.fill(PlateFill.panel),
              end: _Layout.flagEnd,
            ),
            const PlatePart(PlateSection.plain),
          ]),
    labels: labels,
    slots: <PlateSlot>[
      for (final _Field f in fields)
        PlateSlot(
          alphabet: f.alphabet,
          box: PlateBox(f.left, 0, f.right - f.left, _Layout.height),
          length: f.length,
          minLength: f.minLength,
          group: f.key,
        ),
    ],
    resolveRegion: resolveRegion,
  );
}

abstract final class MadagascarPlates {
  /// `1234 TAK`: four digits and two or three letters, the first the province.
  /// Pair with `MadagascarThemes.standard` (white on black from 2014) or
  /// `MadagascarThemes.legacy` (black on white until 2014).
  static final PlateSpec standard = _row('standard', const <_Field>[
    _Field('number', MadagascarAlphabets.digits, 59.2, 267.8, 4),
    _Field('series', MadagascarAlphabets.letters, 308.2, 458.2, 3, 2),
  ], resolveRegion: MadagascarRegions.captionOf);

  /// `12345 WWT`: up to five digits, then `WW` and the province letter.
  /// Pair with `MadagascarThemes.temporary`.
  static final PlateSpec temporary = _row('temporary', const <_Field>[
    _Field('number', MadagascarAlphabets.digits, 40, 300, 5, 1),
    _Field('series', MadagascarAlphabets.letters, 320, 470, 3),
  ], resolveRegion: MadagascarRegions.temporaryCaptionOf);

  /// `W 474 T`: dealer's plate, a fixed `W`, three digits and the province.
  /// Pair with `MadagascarThemes.dealer`.
  static final PlateSpec dealer = _row(
    'dealer',
    const <_Field>[
      _Field('number', MadagascarAlphabets.digits, 186.8, 355.8, 3),
      // Wider than the printed `T` so the glyph is not shrunk to fit.
      _Field('series', MadagascarAlphabets.letters, 397.6, 457.6, 1),
    ],
    resolveRegion: MadagascarRegions.dealerCaptionOf,
    labels: const <PlateLabel>[
      PlateLabel(
        text: 'W',
        box: PlateBox(74.2, 0, 49.3, _Layout.height),
        glyphHeight: _Layout.height,
      ),
    ],
  );

  /// `Z 4878`: gendarmerie `Z` or army `T`, four digits, the flag at the left.
  /// Pair with `MadagascarThemes.military`.
  static final PlateSpec military = _row('military', const <_Field>[
    _Field('series', MadagascarAlphabets.letters, 167.35, 227.35, 1),
    _Field('number', MadagascarAlphabets.digits, 255.8, 446, 4),
  ], panel: _Layout.flagPanel);

  /// `009 PE 895`: country code, `CD`/`CMD`/`CMC`/`PE`, serial. Pair with
  /// `MadagascarThemes.diplomatic`.
  static final PlateSpec diplomatic = _row('diplomatic', const <_Field>[
    _Field('country', MadagascarAlphabets.digits, 66.2, 185.2, 3),
    _Field('series', MadagascarAlphabets.letters, 215.5, 293.5, 3, 2),
    _Field('number', MadagascarAlphabets.digits, 324.2, 449.5, 3, 1),
  ]);

  static final List<PlateSpec> all = <PlateSpec>[
    standard,
    temporary,
    dealer,
    military,
    diplomatic,
  ];
}
