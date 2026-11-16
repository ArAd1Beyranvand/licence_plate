import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'equatorial_guinea_colors.dart';
import 'equatorial_guinea_country.dart';
import 'equatorial_guinea_regions.dart';

/// Measured on the reference photo flattened to 520×110.
///
/// The reference ink is ~80 tall; with the 0.55 ink ratio a 100-unit box gives
/// ~55, so the characters land near 70% of the reference. The box is capped at
/// 100 on the 110-unit plate.
abstract final class _Layout {
  static const double width = 520, height = 110, box = 100, cy = 54.5;

  static const double provinceCx0 = 118.5, provincePitch = 57;
  static const double numberCx0 = 265, numberPitch = 54.8;
  static const double seriesCx = 469, seriesWidth = 56;

  /// The two dashes, 20×11, centred at x 222 and 418.5, y 52–63.
  static const PlateBox dashLeft = PlateBox(212, 52, 20, 11);
  static const PlateBox dashRight = PlateBox(408.5, 52, 20, 11);

  /// "GE" under the emblem, ink 26 tall.
  static const PlateBox ge = PlateBox(26, 68, 50, 30);
  static const double geGlyph = 46;

  /// The CEMAC emblem circle; the crop is 199×194 px, so 25×27 units.
  static const PlateBox emblem = PlateBox(37, 17.5, 25, 27);

  static const PlateBox sticker = PlateBox(487, 15, 20.5, 20.5);
}

/// The regular plate, `AB-123-C` in one row (province code, number, series),
/// with the CEMAC emblem and "GE" at the left and a sticker at the right.
///
/// Not implemented: the older plates without the emblem.
abstract final class EquatorialGuineaPlates {
  static final PlateSpec regular = _spec('gq.regular');

  static List<PlateSpec> get all => <PlateSpec>[regular];

  /// The CEMAC logo cropped from the reference plate; no vector source exists.
  static const PlateDecal _emblem = PlateDecal(
    image: AssetImage(
      'assets/countries/equatorial_guinea/icons/cemac_emblem.png',
      package: 'license_plate',
    ),
    box: _Layout.emblem,
  );

  static PlateSpec _spec(String id) {
    final double top = _Layout.cy - _Layout.box / 2;
    PlateSlot group(
      PlateAlphabet alphabet,
      int count,
      double cx0,
      double pitch,
    ) => plateRun(
      alphabet,
      count,
      left: cx0 - pitch / 2,
      top: top,
      pitch: pitch,
      height: _Layout.box,
    );
    final PlateSlot province = group(
      EquatorialGuineaAlphabets.letters,
      2,
      _Layout.provinceCx0,
      _Layout.provincePitch,
    );
    final PlateSlot number = group(
      EquatorialGuineaAlphabets.digits,
      3,
      _Layout.numberCx0,
      _Layout.numberPitch,
    );
    final PlateSlot series = PlateSlot(
      alphabet: EquatorialGuineaAlphabets.letters,
      box: PlateBox(
        _Layout.seriesCx - _Layout.seriesWidth / 2,
        top,
        _Layout.seriesWidth,
        _Layout.box,
      ),
    );
    return PlateSpec(
      id: id,
      country: EquatorialGuineaCountry.equatorial_guinea,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      slots: <PlateSlot>[province, number, series],
      bands: const <PlateBand>[
        PlateBand(box: _Layout.sticker, color: EquatorialGuineaColors.sticker),
      ],
      rules: const <PlateRule>[
        PlateRule(box: _Layout.dashLeft),
        PlateRule(box: _Layout.dashRight),
      ],
      labels: const <PlateLabel>[
        PlateLabel(text: 'GE', box: _Layout.ge, glyphHeight: _Layout.geGlyph),
      ],
      decals: const <PlateDecal>[_emblem],
      textGroups: PlateTextGroup.perSlot(<String>[
        'province',
        'number',
        'series',
      ]),
      resolveRegion: EquatorialGuineaRegions.captionOf,
    );
  }
}
