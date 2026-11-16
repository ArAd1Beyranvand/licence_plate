import 'package:flutter/widgets.dart' show AssetImage, EdgeInsets;
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'cameroon_colors.dart';
import 'cameroon_country.dart';
import 'cameroon_regions.dart';

/// Ink placement in plate coordinates on 520 × 110; the photos are flattened
/// to that (aspects 4.65 and 4.59 against 4.73) and projected onto each axis.
///
/// **Regular** (`____1`):
///
///   serial ink     x  91 .. 465   y 15.5 .. 94.5   (L T 1 2 8 A B, pitch ~54)
///   CMR            x  14 ..  76   y  70 ..  94     (cap height 24)
///   CEMAC emblem   x 20.5 .. 67.5 y 13.5 ..  60
///   sticker        x 484.5 .. 504 y 15 .. 34.5     (808080)
///
/// **Diplomatic** (`Kameroen3_license_plate`): ink y 17 .. 95, glyph centres
/// C 98.7, M 152.6 | D 229.5 | 3 333, 8 389 | 2 482. The photo prints a dot
/// between some groups and a sticker; neither is modelled.
///
/// The ink is 78 tall on a 110 plate; matching it would need a 142 box, so the
/// box is the full 110 and the serial lands near 77% of the reference.
abstract final class _Layout {
  static const double width = 520, height = 110;

  static const double serialLeft = 88, serialRight = 468;
  static const double serialTop = 0, serialBox = 110;

  static const PlateBox emblem = PlateBox(20.5, 13.5, 47, 46.5);
  static const PlateBox cmr = PlateBox(14, 62, 62, 40);
  static const double cmrGlyph = 40;
  static const PlateBox sticker = PlateBox(484.5, 15, 19.5, 19.5);

  static const double diplomaticPitch = 54, centreC = 98.7, centreD = 229.5;
  static const double centre3 = 333, centre2 = 482;
}

class _Run {
  const _Run(this.key, this.alphabet, this.count);
  final String key;
  final PlateAlphabet alphabet;
  final int count;
}

/// Cameroon's plates. [private] is `LT 128 AB` (groups `region`, `number`,
/// `series`); [diplomatic] is `CM D 38 2`. Both carry the CEMAC emblem, a
/// raster decal because no usable vector exists, and `CMR`.
///
/// Not implemented, for want of a measured plate: state, postal, military and
/// police plates, cargo and custom-number variants, and the old series. The
/// regular plate is the three-digit form; four digits also occur.
abstract final class CameroonPlates {
  static const AssetImage _emblem = AssetImage(
    'assets/countries/cameroon/icons/cemac_emblem.png',
    package: 'license_plate',
  );

  static final PlateSpec private = _spec(
    id: 'cm.private',
    runs: const <_Run>[
      _Run('region', CameroonAlphabets.letters, 2),
      _Run('number', CameroonAlphabets.digits, 3),
      _Run('series', CameroonAlphabets.letters, 2),
    ],
    sticker: true,
    resolveRegion: CameroonRegions.captionOf,
  );

  static final PlateSpec diplomatic = _spec(
    id: 'cm.diplomatic',
    runs: const <_Run>[],
    cells: <(_Run, double)>[
      (const _Run('mission', CameroonAlphabets.letters, 2), _Layout.centreC),
      (const _Run('type', CameroonAlphabets.letters, 1), _Layout.centreD),
      (const _Run('number', CameroonAlphabets.digits, 2), _Layout.centre3),
      (const _Run('suffix', CameroonAlphabets.digits, 1), _Layout.centre2),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[private, diplomatic];

  /// [runs] fill the serial span evenly; each of [cells] is a run whose first
  /// cell is centred at the given x, at the diplomatic pitch.
  static PlateSpec _spec({
    required String id,
    required List<_Run> runs,
    List<(_Run, double)> cells = const <(_Run, double)>[],
    bool sticker = false,
    PlateLabelResolver? resolveRegion,
  }) {
    final List<PlateSlot> slots = <PlateSlot>[];
    void add(_Run run, double left, double pitch) {
      slots.add(
        plateRun(
          run.alphabet,
          run.count,
          left: left,
          top: _Layout.serialTop,
          pitch: pitch,
          height: _Layout.serialBox,
          group: run.key,
        ),
      );
    }

    final int total = runs.fold(0, (int n, _Run r) => n + r.count);
    final double pitch =
        (_Layout.serialRight - _Layout.serialLeft) / (total == 0 ? 1 : total);
    double x = _Layout.serialLeft;
    for (final _Run run in runs) {
      add(run, x, pitch);
      x += run.count * pitch;
    }
    for (final (_Run run, double cx) in cells) {
      add(run, cx - _Layout.diplomaticPitch / 2, _Layout.diplomaticPitch);
    }
    return PlateSpec(
      id: id,
      country: CameroonCountry.cameroon,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      panel: const PlatePanel(
        box: PlateBox(0, 0, 0, 0),
        padding: EdgeInsets.zero,
      ),
      noPanel: true,
      decals: const <PlateDecal>[
        PlateDecal(image: _emblem, box: _Layout.emblem),
      ],
      bands: <PlateBand>[
        if (sticker)
          const PlateBand(box: _Layout.sticker, color: CameroonColors.sticker),
      ],
      labels: const <PlateLabel>[
        PlateLabel(
          text: 'CMR',
          box: _Layout.cmr,
          glyphHeight: _Layout.cmrGlyph,
        ),
      ],
      slots: slots,
      resolveRegion: resolveRegion,
    );
  }
}
