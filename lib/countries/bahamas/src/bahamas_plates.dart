import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'bahamas_alphabets.dart';
import 'bahamas_country.dart';

/// Where the ink sits, in plate units on a 300×152 canvas (152×300 mm, scaled
/// by 300/152 from the flattened references).
///
/// **Glyph size.** The font is 0.72 of the slot and a bold cap is ~0.75 of
/// that, so ink ≈ 0.55 × the height written. Captions are set at ink / 0.55.
///
/// **Under-height serials, accepted.** The references show ~70 of ink, which
/// would need a ~125 slot; the real faces are far narrower than DejaVu Bold,
/// so five digits at 125 would be 316 wide on a 300 plate, and a run wider than
/// its box is scaled down whole. Each serial is instead as tall as its run
/// fits ([advance] × height × characters), leaving the ink 70–80% of the
/// reference.
///
/// **Not modelled:** the per-year validity stickers, the raster "BAHAMAS"
/// tourism logo on the 1992 plate, screw holes, and the 2016 plates, which have
/// no image. The 1992 photograph is cropped and in perspective, so that
/// plate's positions are the least certain (CHECK). The 1997 photograph is
/// blurred and foreshortened; it takes the 1987 geometry, which the identical
/// five-digit format supports.
abstract final class _Layout {
  static const double width = 300, height = 152;

  /// Width of one DejaVu Bold digit/cap per unit of slot height: 0.72 × 0.696,
  /// rounded up a little so a run fits its box.
  static const double advance = 0.51;
}

/// One series' rows. Centres are x or y of the ink; heights are the box
/// heights to write (ink ÷ 0.55).
@immutable
class _Design {
  const _Design({
    required this.id,
    required this.top,
    required this.bottom,
    required this.topCenter,
    required this.topGlyph,
    required this.bottomCenter,
    required this.bottomGlyph,
    required this.serialCenterY,
    required this.serialHeight,
    required this.serialCenterX,
    required this.digits,
    this.prefix = false,
    this.captionCenterX = 150,
    this.bottomCenterX,
    this.captionWidth = 220,
    this.bottomWidth = 200,
    this.extraLabels = const <PlateLabel>[],
  });

  final String id, top, bottom;
  final double topCenter, topGlyph, bottomCenter, bottomGlyph, serialCenterY;
  final double serialHeight, serialCenterX;
  final int digits;
  final bool prefix;
  final double captionCenterX;
  final double? bottomCenterX;
  final double captionWidth, bottomWidth;
  final List<PlateLabel> extraLabels;
}

/// The Bahamas's plate series, all one shape: a caption row, a serial of
/// digits (preceded, on the truck series, by a one-letter field) and a caption
/// row below. They differ only in data held by a [_Design]; colour is the
/// theme's.
///
/// Text groups: `serial` (3–5 digits) and, on the truck series, `prefix` (the
/// class letter, `T`).
///
/// * [yellow] — 1987–89, black on yellow, `NASSAU` / 5 digits / `BAHAMAS`.
/// * [green] — 1990–91, white on green, `ABACO` / 4 digits / `BAHAMAS`; the
///   serial is centred at x 143 because the sticker sits at the right.
/// * [pale] — 1977, black on pale cyan, `HARBOUR ISLAND` / `T` + 3 digits /
///   slogan.
/// * [landfall] — 1992–96 truck, blue on yellow, `1492` / `T` + 4 digits /
///   island.
/// * [blue] — 1997–2015, gold on blue, 1987 geometry.
abstract final class BahamasPlates {
  static _Design _nassau(String id) => _Design(
    id: id,
    top: 'NASSAU',
    bottom: 'BAHAMAS',
    topCenter: 19.2,
    topGlyph: 27,
    bottomCenter: 129.6,
    bottomGlyph: 35,
    serialCenterY: 72.5,
    serialHeight: 100,
    serialCenterX: 152,
    digits: 5,
  );

  static const List<PlateTextGroup> _serialOnly = <PlateTextGroup>[
    PlateTextGroup(<int>[0], key: 'serial'),
  ];
  static const List<PlateTextGroup> _prefixed = <PlateTextGroup>[
    PlateTextGroup(<int>[0], key: 'prefix'),
    PlateTextGroup(<int>[1], key: 'serial'),
  ];

  static PlateLabel _caption(
    String text,
    double centerX,
    double centerY,
    double glyph,
    double width,
  ) => PlateLabel(
    text: text,
    box: PlateBox.centered(centerX, centerY, width, glyph),
    glyphHeight: glyph,
  );

  static PlateSpec _plate(_Design d) {
    final double h = d.serialHeight, cell = _Layout.advance * h;
    final double top = d.serialCenterY - h / 2, serialWidth = cell * d.digits;
    final double run = serialWidth + (d.prefix ? cell : 0);
    final double left = d.serialCenterX - run / 2;
    return PlateSpec(
      id: d.id,
      country: BahamasCountry.bahamas,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      noPanel: true,
      panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
      slots: <PlateSlot>[
        if (d.prefix)
          PlateSlot(
            alphabet: BahamasAlphabets.letters,
            box: PlateBox(left, top, cell, h),
          ),
        PlateSlot(
          alphabet: BahamasAlphabets.digits,
          box: PlateBox(left + (d.prefix ? cell : 0), top, serialWidth, h),
          length: d.digits,
        ),
      ],
      labels: <PlateLabel>[
        _caption(
          d.top,
          d.captionCenterX,
          d.topCenter,
          d.topGlyph,
          d.captionWidth,
        ),
        _caption(
          d.bottom,
          d.bottomCenterX ?? d.captionCenterX,
          d.bottomCenter,
          d.bottomGlyph,
          d.bottomWidth,
        ),
        ...d.extraLabels,
      ],
      textGroups: d.prefix ? _prefixed : _serialOnly,
    );
  }

  /// The Nassau plate, 1987 yellow and 1997 blue: the livery is the theme's.
  static final PlateSpec nassau = _plate(_nassau('bs.nassau'));

  static final PlateSpec green = _plate(
    const _Design(
      id: 'bs.green',
      top: 'ABACO',
      bottom: 'BAHAMAS',
      topCenter: 16.8,
      topGlyph: 24,
      bottomCenter: 133.5,
      bottomGlyph: 25,
      serialCenterY: 76,
      serialHeight: 110,
      serialCenterX: 143,
      digits: 4,
      captionCenterX: 144,
    ),
  );

  static final PlateSpec pale = _plate(
    const _Design(
      id: 'bs.pale',
      top: 'HARBOUR ISLAND',
      bottom: 'ITS BETTER IN THE BAHAMAS',
      topCenter: 21.7,
      topGlyph: 27,
      bottomCenter: 123,
      bottomGlyph: 18,
      serialCenterY: 69.5,
      serialHeight: 100,
      serialCenterX: 151,
      digits: 3,
      prefix: true,
      captionCenterX: 151,
      captionWidth: 240,
      bottomWidth: 250,
    ),
  );

  static final PlateSpec landfall = _plate(
    const _Design(
      id: 'bs.landfall',
      top: '1492',
      bottom: 'ANDROS',
      topCenter: 51,
      topGlyph: 34,
      bottomCenter: 134,
      bottomGlyph: 22,
      serialCenterY: 98.5,
      serialHeight: 100,
      serialCenterX: 150,
      digits: 4,
      prefix: true,
      captionCenterX: 100,
      bottomCenterX: 150,
      captionWidth: 80,
      bottomWidth: 160,
      extraLabels: <PlateLabel>[
        // The right-hand "1992" of "1492 … 1992", mirrored about the plate's
        // centre; the photograph cuts it off.
        PlateLabel(
          text: '1992',
          box: PlateBox(160, 34, 80, 34),
          glyphHeight: 34,
        ),
      ],
    ),
  );
}
