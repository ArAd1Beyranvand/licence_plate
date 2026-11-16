import 'package:flutter/widgets.dart' show EdgeInsets, Offset;
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'monaco_colors.dart';
import 'monaco_country.dart';

class _Field {
  const _Field(this.alphabet, this.left, this.width, this.length, this.group);

  final PlateAlphabet alphabet;
  final double left, width;
  final int length;
  final String group;
}

/// What differs between the three plates; everything else is one builder.
class _Face {
  const _Face({
    required this.width,
    required this.height,
    required this.glyph,
    required this.top,
    required this.pitch,
    required this.fields,
    required this.badge,
    this.shield = false,
    this.year,
    this.caption,
  });

  final double width, height;

  /// Slot box height and top, and the printed pitch between characters.
  final double glyph, top, pitch;
  final List<_Field> fields;
  final PlateBox badge;

  /// A shield with `MC` under the lozenges (front) rather than the year and a
  /// blue `MC` block (rear, motorcycle).
  final bool shield;
  final String? year;
  final PlateBox? caption;
}

/// Where the ink sits, in plate units.
///
/// Canvases are the physical sizes of the article's infobox, 340×110 mm rear
/// and 260×90 mm front; the photos are stretched wider than that, so every
/// x and y below is the flattened photo's pixel position as a fraction of its
/// plate, times the canvas. The motorcycle has no documented size: it keeps
/// the flat photo's 340×173 (aspect 1.97).
///
/// Measured off `flat_2015_Monaco_front_and_rear_plate.png` (1360×692, front
/// y 30–350, rear y 380–692) and `flat_Motorcycle_license_plate_in_Monaco.png`
/// (1360×692, one plate):
///
/// - front: digits ink x 66–245, y 79–299 px (about 62 units, scaled), pitch
///   46.7; shield x 6.7–54.4, y 15.5–74.5.
/// - rear: digits ink x 90–311, pitch 57.6; caption ink x 100–286, centre y
///   94.5, ~11 high; badge x 10.5–68.8, y 10.6–99.4.
/// - motorcycle: `KN` ink x 107–207, `66` x 221–316, both y 42–120 (centre
///   81); caption x 104–318, centre y 141; badge x 20–87.5, y 22.5–132.5.
///
/// The digits want ~130 box units on a 110 plate, which the canvas cannot
/// hold; the box is the full height, so ink is ~80% of reference.
///
/// One field per run: a car's serial is one four-character slot (a letter and
/// three digits, four digits, or three digits and a letter); the motorcycle's
/// is a two-letter slot and a two-digit slot. The year on the badge (2015 on
/// the car photo, 2025 on the motorcycle) is the sticker and changes yearly.
///
/// Not drawn: the provisional (white on red), pending, `CC`/`CD` diplomatic,
/// IAEA and IHB (white on green), tourist and Italian consulate plates have no
/// picture in the article.
abstract final class _Layout {
  static const _Face carRear = _Face(
    width: 340,
    height: 110,
    glyph: 97.5,
    top: 0,
    pitch: 57.6,
    fields: <_Field>[_Field(_serial, 90.5, 221, 4, 'serial')],
    badge: PlateBox(10.5, 10.6, 58.3, 88.8),
    year: '2015',
    caption: PlateBox(97.5, 85.5, 190, 18),
  );

  static const _Face carFront = _Face(
    width: 260,
    height: 90,
    glyph: 90,
    top: 0,
    pitch: 46.7,
    fields: <_Field>[_Field(_serial, 66, 179, 4, 'serial')],
    badge: PlateBox(6.7, 15.5, 47.7, 59),
    shield: true,
  );

  static const _Face motorcycle = _Face(
    width: 340,
    height: 173,
    glyph: 110,
    top: 26,
    pitch: 54,
    fields: <_Field>[
      _Field(_letters, 107, 100, 2, 'letters'),
      _Field(_digits, 221, 95, 2, 'digits'),
    ],
    badge: PlateBox(20, 22.5, 67.5, 110),
    year: '2025',
    caption: PlateBox(104, 132, 214, 18),
  );

  static const PlateAlphabet _serial = MonacoAlphabets.serial;
  static const PlateAlphabet _letters = MonacoAlphabets.letters;
  static const PlateAlphabet _digits = MonacoAlphabets.digits;

  static const double captionGlyph = 18;
}

/// The Monaco plates. A car's group is `serial`; a motorcycle's are `letters`
/// and `digits`. The badge is the arms' red lozenges, drawn in code.
abstract final class MonacoPlates {
  static final PlateSpec carRear = _spec('mc.car_rear', _Layout.carRear);
  static final PlateSpec carFront = _spec('mc.car_front', _Layout.carFront);
  static final PlateSpec motorcycle = _spec(
    'mc.motorcycle',
    _Layout.motorcycle,
  );

  static List<PlateSpec> get all => <PlateSpec>[carRear, carFront, motorcycle];

  static PlateSpec _spec(String id, _Face f) {
    final double slotSpacing = plateRunSpacing(f.pitch, f.glyph);
    final PlateBox badge = f.badge;
    final double midX = badge.left;
    return PlateSpec(
      id: id,
      country: MonacoCountry.monaco,
      canvasWidth: f.width,
      canvasHeight: f.height,
      panel: const PlatePanel(
        box: PlateBox(0, 0, 0, 0),
        padding: EdgeInsets.zero,
      ),
      noPanel: true,
      slots: <PlateSlot>[
        for (final _Field s in f.fields)
          PlateSlot(
            alphabet: s.alphabet,
            box: PlateBox(s.left, f.top, s.width, f.glyph),
            length: s.length,
            spacing: s.length > 1 ? slotSpacing : 0,
          ),
      ],
      textGroups: <PlateTextGroup>[
        for (int i = 0; i < f.fields.length; i++)
          PlateTextGroup(<int>[i], key: f.fields[i].group),
      ],
      decals: <PlateDecal>[
        PlateDecal(
          drawing: f.shield
              ? _shield(badge.width, badge.height)
              : _badge(badge.width, badge.height),
          box: badge,
        ),
      ],
      labels: <PlateLabel>[
        if (f.shield)
          PlateLabel(
            text: 'MC',
            box: PlateBox(
              midX,
              badge.top + badge.height * 0.47,
              badge.width,
              28,
            ),
            glyphHeight: 26,
          )
        else ...<PlateLabel>[
          PlateLabel(
            text: f.year!,
            box: PlateBox(
              midX,
              badge.top + badge.height * 0.55,
              badge.width,
              14,
            ),
            glyphHeight: f.height > 150 ? 14 : 12,
            color: MonacoColors.badgeBlue,
          ),
          PlateLabel(
            text: 'MC',
            box: PlateBox(
              midX,
              badge.top + badge.height * 0.74,
              badge.width,
              20,
            ),
            glyphHeight: f.height > 150 ? 28 : 24,
            color: MonacoColors.white,
          ),
        ],
        if (f.caption != null)
          PlateLabel(
            text: 'PRINCIPAUTE DE MONACO',
            box: f.caption!,
            glyphHeight: _Layout.captionGlyph,
          ),
      ],
    );
  }

  /// The rear and motorcycle badge: a blue frame round white, the lozenges on
  /// top and a blue block below for the white `MC`.
  static PlateDrawing _badge(double w, double h) {
    final double inset = w * 0.035;
    return PlateDrawing(w, h, <PlateShape>[
      PlateRectShape(0, 0, w, h, MonacoColors.badgeBlue),
      PlateRectShape(
        inset,
        inset,
        w - 2 * inset,
        h * 0.655 - inset,
        MonacoColors.white,
      ),
      ..._lozenges(w * 0.11, h * 0.09, w * 0.78, h * 0.45, 5),
    ]);
  }

  /// The front badge: a shield, blue outline round white, three rows of
  /// lozenges above the `MC` label.
  static PlateDrawing _shield(double w, double h) {
    final double i = w * 0.06;
    return PlateDrawing(w, h, <PlateShape>[
      PlatePolygonShape(<Offset>[
        Offset.zero,
        Offset(w, 0),
        Offset(w, h * 0.78),
        Offset(w / 2, h),
        Offset(0, h * 0.78),
      ], MonacoColors.blue),
      PlatePolygonShape(<Offset>[
        Offset(i, i),
        Offset(w - i, i),
        Offset(w - i, h * 0.76 - i / 2),
        Offset(w / 2, h - i * 1.5),
        Offset(i, h * 0.76 - i / 2),
      ], MonacoColors.white),
      ..._lozenges(w * 0.12, h * 0.1, w * 0.76, h * 0.3, 3),
    ]);
  }

  /// Staggered rows of five and four red diamonds, tip to tip, inside the
  /// given rectangle.
  static List<PlateShape> _lozenges(
    double left,
    double top,
    double width,
    double height,
    int rows,
  ) {
    const int columns = 5;
    final double dw = width / columns, p = height / (rows + 1);
    return <PlateShape>[
      for (int r = 0; r < rows; r++)
        for (int c = 0; c < (r.isEven ? columns : columns - 1); c++)
          PlatePolygonShape(<Offset>[
            Offset(left + dw * (c + (r.isEven ? 0.5 : 1)), top + p * r),
            Offset(left + dw * (c + (r.isEven ? 1 : 1.5)), top + p * (r + 1)),
            Offset(left + dw * (c + (r.isEven ? 0.5 : 1)), top + p * (r + 2)),
            Offset(left + dw * (c + (r.isEven ? 0 : 0.5)), top + p * (r + 1)),
          ], MonacoColors.red),
    ];
  }
}
