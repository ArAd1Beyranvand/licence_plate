import 'package:flutter/painting.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'papua_new_guinea_colors.dart';
import 'papua_new_guinea_country.dart';

/// Where the ink sits, in plate units. 372 × 134 mm (the article's Australian
/// standard), the references flattened to that size by `tools/platekit`.
///
/// Reference rows (BAA-000, ZWP, TT-3447): caption "PNG" ink y 9.2–24.5,
/// centred on x 184; main row ink y 31.8–119.8 (88 tall, centre 75.8), letters
/// at a pitch of ~53 from x 18.2, digits at ~46 ending x 357, a dot between.
/// The plate is 134 tall, so the field boxes are capped at 112 (y 20–132, ink
/// ~0.55 of it ≈ 61, about 70% of the reference's 88) and the caption sits
/// above them.
///
/// Estimated, not measured: the stacked "PNG" of the diplomatic plate (x ≈
/// 8–22, from the sheet at ~1.1 units per pixel) and the dot's size.
abstract final class _Layout {
  static const double width = 372, height = 134, border = 0.03;

  static const double rowTop = 20, rowHeight = 112;
  static const double rowCentre = rowTop + rowHeight / 2;

  /// Per-letter and per-digit pitch, x 18.2–178 for 3 letters, 220–357 for 3
  /// digits.
  static const double letterPitch = 53, digitPitch = 46;

  static const double leftEdge = 18, rightEdge = 357;

  /// Left edge when "PNG" is stacked at the left (diplomatic).
  static const double stackedLeftEdge = 44;

  /// Caption "PNG": ink 15 tall, glyph ≈ ink / 0.55.
  static const PlateBox caption = PlateBox(134, 5, 104, 24);
  static const double captionGlyph = 27;

  /// The stacked "PNG": one letter per row, ink ~29 tall each.
  static const double stackX = 6, stackWidth = 28;
  static const List<double> stackY = <double>[16, 51, 86];
  static const double stackHeight = 32, stackGlyph = 52;

  static const double dotGlyph = 40, dotWidth = 24;
}

/// What differs between the single-row designs: the letters, the digits, the
/// ink of the letters, where "PNG" is.
class _Design {
  const _Design({
    required this.leadLength,
    int? leadMinLength,
    required this.numberLength,
    int? numberMinLength,
    this.leadColor,
    this.stacked = false,
  }) : leadMinLength = leadMinLength ?? leadLength,
       numberMinLength = numberMinLength ?? numberLength;

  final int leadLength, leadMinLength;
  final int numberLength, numberMinLength;
  final Color? leadColor;
  final bool stacked;
}

/// The current plates, one row: a letters field, a dot and a digits field, with
/// "PNG" above (or stacked at the left on the diplomatic plate). Colour is the
/// theme's; pair each spec with its theme of the same name.
///
/// Every field is one slot: `lead` (letters) and `number` (digits), the
/// number of taxi plates running 4 to 5 digits.
///
/// Not implemented: the "Euro Flag" variants (national or provincial flag on
/// the left, drawn with a bird of paradise), the Prime Minister's and
/// Governor-General's plates (emblem), the Bougainville plate, Defence Force
/// plates, personalised plates (any six characters), commemorative one-offs
/// and every pre-1975 series. The red "P" of provincial plates is not
/// reproduced: a field has one ink.
abstract final class PapuaNewGuineaPlates {
  /// `BAA-000` general, `PAA-000` provincial (theme `provincial`).
  static final PlateSpec general = _spec(
    'pg.general',
    const _Design(leadLength: 3, numberLength: 3),
  );

  /// `AA-000`; also `CC-033` consular (theme `consular`).
  static final PlateSpec motorcycle = _spec(
    'pg.motorcycle',
    const _Design(leadLength: 2, numberLength: 3),
  );

  /// `TR-0001` from 1993; also `TT-3447` trade (theme `trade`).
  static final PlateSpec trailer = _spec(
    'pg.trailer',
    const _Design(leadLength: 2, numberLength: 4),
  );

  /// `T-0000`; `T-00000` after 9999.
  static final PlateSpec taxi = _spec(
    'pg.taxi',
    const _Design(leadLength: 1, numberLength: 5, numberMinLength: 4),
  );

  /// `H-0001`; also `P-0000` PMV (themes `pmvBlue`, `pmvOrange`).
  static final PlateSpec hire = _spec(
    'pg.hire',
    const _Design(leadLength: 1, numberLength: 4),
  );

  /// `ZA-000` and `ZPD-000`, national government; red letters.
  static final PlateSpec government = _spec(
    'pg.government',
    const _Design(
      leadLength: 3,
      leadMinLength: 2,
      numberLength: 3,
      leadColor: PapuaNewGuineaColors.governmentRed,
    ),
  );

  /// `DC-053`, diplomatic corps, "PNG" stacked at the left.
  static final PlateSpec diplomatic = _spec(
    'pg.diplomatic',
    const _Design(leadLength: 2, numberLength: 3, stacked: true),
  );

  static List<PlateSpec> get all => <PlateSpec>[
    general,
    motorcycle,
    trailer,
    taxi,
    hire,
    government,
    diplomatic,
  ];

  static PlateSpec _spec(String id, _Design d) {
    final double left = d.stacked ? _Layout.stackedLeftEdge : _Layout.leftEdge;
    final double leadWidth = d.leadLength * _Layout.letterPitch;
    final double numberWidth = d.numberLength * _Layout.digitPitch;
    final double numberLeft = _Layout.rightEdge - numberWidth;
    final double dotCentre = (left + leadWidth + numberLeft) / 2;

    PlateSlot field(
      PlateAlphabet alphabet,
      double left,
      double width,
      int length,
      int minLength,
      double pitch, {
      Color? color,
    }) => PlateSlot(
      alphabet: alphabet,
      box: PlateBox(left, _Layout.rowTop, width, _Layout.rowHeight),
      length: length,
      minLength: minLength,
      color: color,
      spacing: plateRunSpacing(pitch, _Layout.rowHeight),
    );

    return PlateSpec(
      id: id,
      country: PapuaNewGuineaCountry.papua_new_guinea,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      borderWidthRatioOverride: _Layout.border,
      slots: <PlateSlot>[
        field(
          PapuaNewGuineaAlphabets.letters,
          left,
          leadWidth,
          d.leadLength,
          d.leadMinLength,
          _Layout.letterPitch,
          color: d.leadColor,
        ),
        field(
          PapuaNewGuineaAlphabets.digits,
          numberLeft,
          numberWidth,
          d.numberLength,
          d.numberMinLength,
          _Layout.digitPitch,
        ),
      ],
      labels: <PlateLabel>[
        if (d.stacked)
          for (int i = 0; i < 3; i++)
            PlateLabel(
              text: 'PNG'[i],
              box: PlateBox(
                _Layout.stackX,
                _Layout.stackY[i],
                _Layout.stackWidth,
                _Layout.stackHeight,
              ),
              glyphHeight: _Layout.stackGlyph,
            )
        else
          const PlateLabel(
            text: 'PNG',
            box: _Layout.caption,
            glyphHeight: _Layout.captionGlyph,
          ),
        PlateLabel(
          text: '•',
          box: PlateBox.centered(
            dotCentre,
            _Layout.rowCentre,
            _Layout.dotWidth,
            _Layout.dotWidth,
          ),
          glyphHeight: _Layout.dotGlyph,
        ),
      ],
      textGroups: PlateTextGroup.perSlot(<String>['lead', 'number']),
    );
  }
}
