import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'togo_colors.dart';
import 'togo_country.dart';
import 'togo_themes.dart';

/// Where the ink sits, in plate units (520×110 mm), measured off the flattened
/// photos of the regular and the commercial plate. Both are one design; the
/// two differ by a few units in where the digits start (the glyphs differ), so
/// the figures here are the mean.
///
/// * digits, four, ink x 98.2–321.8 / 89.2–315.8, y 17.2–94.5 (centre 55.85).
/// * dot, a 31.5-unit grey disc, x 335–366.5 / 337–369, y 42.5–73.5.
/// * letters, two, ink x 380–493.2 / 383.8–494.
/// * flag x 24.5–76, y 18.5–56.5, `TG` below it.
///
/// Ink is ~55% of a slot box (`glyphStyle`: 0.72 of the box, a cap three
/// quarters of that). The 77-unit reference ink would need a 140-unit box on a
/// 110-unit plate, so the boxes are capped at 102 (~70% of the reference ink).
/// The 0.72 is the engine's and is left alone.
abstract final class _Layout {
  static const double width = 520, height = 110, box = 102, top = 4.85;

  static const double digitsLeft = 93.5, digitsPitch = 56.3;
  static const double lettersLeft = 381.3, lettersPitch = 56.5;

  static const PlateBox dot = PlateBox(336, 42.5, 31.5, 31.5);

  static const PlatePanel panel = PlatePanel(
    box: PlateBox(0, 0, 100.5, 110),
    padding: EdgeInsets.fromLTRB(24.5, 18.5, 24, 10),
  );
}

/// Togo's plates.
///
/// [regular] is `1234·AB`, blue on white, flag and `TG` at the left; the
/// commercial plate is the same spec in [TogoThemes.commercial] (red on yellow).
///
/// Not implemented: the two-line `AB / 1234` variant, the government
/// (`G / A 1234`, white on light green) and diplomatic (`12CD34`, white on
/// blue) plates — the article describes them but pictures none, so there is no
/// reference to measure. The small sticker number under the flag on the
/// commercial photo is not drawn.
abstract final class TogoPlates {
  static final PlateSpec regular = _build('tg.regular');

  static List<PlateSpec> get all => <PlateSpec>[regular];

  static PlateSpec _build(String id) {
    return PlateSpec(
      id: id,
      country: TogoCountry.togo,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      panel: _Layout.panel,
      slots: <PlateSlot>[
        plateRun(
          TogoAlphabets.digits,
          4,
          left: _Layout.digitsLeft,
          top: _Layout.top,
          pitch: _Layout.digitsPitch,
          height: _Layout.box,
          group: 'number',
        ),
        plateRun(
          TogoAlphabets.letters,
          2,
          left: _Layout.lettersLeft,
          top: _Layout.top,
          pitch: _Layout.lettersPitch,
          height: _Layout.box,
          group: 'series',
        ),
      ],
      decals: const <PlateDecal>[
        PlateDecal(
          drawing: PlateDrawing(100, 100, <PlateShape>[
            PlateCircleShape(50, 50, 50, TogoColors.dot),
          ]),
          box: _Layout.dot,
        ),
      ],
    );
  }
}
