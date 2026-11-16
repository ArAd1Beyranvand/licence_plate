import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'ethiopia_colors.dart';
import 'ethiopia_country.dart';
import 'ethiopia_missions.dart';
import 'ethiopia_themes.dart';

/// Where the ink sits, in plate units. Every reference was flattened offline to
/// 520×110; the photos' own aspects differ, so each canvas is 520 wide at the
/// photo's aspect and the flat y values are scaled by `height / 110`.
///
/// **Regional** (`Ethiopia_License_plate20021`, aspect 4.79 → 520×108.5): the
/// class disc ink x 14–65.2, y 29.8–81.8 (flat); the Ge'ez pair x 86.5–112.8,
/// y 7.8–99.8, stacked; six digits x 167.2–465, y 13.8–94.5 at a pitch of 51.5;
/// the Latin pair x 481.8–502.2, y 7.2–99.8, stacked.
///
/// **Private** (`Ethiopia_License_plate20261`, aspect 3.57 → 520×145.7): six
/// digits x 109.5–493, y 14.5–92.8 (flat) at a pitch of 66.4. The strip to
/// their left carries the Ge'ez "ኢት", "ETH" and a QR code; only the two labels
/// are reproduced, the QR code is a per-plate image.
///
/// **Diplomatic** (`Ethiopia_License_plateCD`, aspect 4.03 → 520×129): two
/// digits x 35.2–137.5, a yellow band x 165.2–207.7 holding the stacked Ge'ez
/// pair, four digits x 252–472 at a pitch of 58.6, a yellow band x 484–520
/// holding the stacked `CD`.
///
/// The typeface is a condensed one (a digit is 40 wide for 81 tall), so a box
/// as tall as the canvas is the most the pitch allows; ink comes out near 70%
/// of the reference height (box × 0.72 × cap ratio), which is the engine's
/// limit, not a measurement.
abstract final class _Layout {
  static const double width = 520;

  // Regional.
  static const double regionalHeight = 108.5;
  static const double regionalPitch = 51.5, regionalDigitsLeft = 161.5;
  static const double discCx = 39.6, discCy = 55, discDiameter = 51.5;
  static const double regionalGeezCx = 99.65, regionalLatinCx = 492;

  // Private.
  static const double privateHeight = 145.7;
  static const double privatePitch = 66.4, privateDigitsLeft = 102.65;

  // Diplomatic.
  static const double diplomaticHeight = 129, diplomaticPitch = 58.4;
  static const double missionLeft = 28.3, numberLeft = 244.8;
  static const double bandAStart = 165.2, bandAEnd = 207.7, bandBStart = 484;
  static const double diplomaticGeezCx = 186.45, diplomaticTypeCx = 502;
}

/// Three designs. The regional plate (2002–2026) is
/// `1 አአ 123456 AA`: a class digit in a disc, two stacked Ge'ez letters, six
/// digits, two stacked Latin letters. The private plate (2026) is six digits.
/// The diplomatic plate is `04 ኩ 0123 CD` with the Ge'ez pair and the type
/// stacked on yellow bands.
///
/// The article also shows plates of the 1950s, the 1980s government series and
/// c.2000 two-row plates; they are superseded and not implemented. Each spec
/// pairs with its theme through [EthiopiaThemes.themeOf].
abstract final class EthiopiaPlates {
  static final PlateSpec regional = _regional();

  static final PlateSpec private = _private();

  static final PlateSpec diplomatic = _diplomatic();

  static List<PlateSpec> get all => <PlateSpec>[regional, private, diplomatic];
}

/// One run of [length] digits at a fixed [pitch]; the spacing brings the
/// font's ~0.6 em advance up to it.
PlateSlot _digits(
  double left,
  double height,
  double pitch,
  int length, {
  PlateAlphabet? alphabet,
}) => plateRun(
  alphabet ?? EthiopiaAlphabets.digits,
  length,
  left: left,
  top: 0,
  pitch: pitch,
  height: height,
);

/// Two single-character cells drawn apart, one above the other, centred on
/// [cx]; the Ge'ez or Latin pair printed upright down the plate.
List<PlateSlot> _stack(
  PlateAlphabet alphabet,
  double cx,
  double width,
  double top,
  double cellHeight,
) => <PlateSlot>[
  for (var i = 0; i < 2; i++)
    PlateSlot(
      alphabet: alphabet,
      box: PlateBox(cx - width / 2, top + i * cellHeight, width, cellHeight),
    ),
];

PlateSpec _regional() {
  const h = _Layout.regionalHeight;
  const r = _Layout.discDiameter;
  return PlateSpec(
    id: 'et.regional',
    country: EthiopiaCountry.ethiopia,
    canvasWidth: _Layout.width,
    canvasHeight: h,
    slots: <PlateSlot>[
      PlateSlot(
        alphabet: EthiopiaAlphabets.digits,
        box: const PlateBox(_Layout.discCx - 18, _Layout.discCy - 25, 36, 50),
      ),
      ..._stack(EthiopiaAlphabets.geez, _Layout.regionalGeezCx, 40, 0, h / 2),
      _digits(_Layout.regionalDigitsLeft, h, _Layout.regionalPitch, 6),
      ..._stack(
        EthiopiaAlphabets.letters,
        _Layout.regionalLatinCx,
        30,
        0,
        h / 2,
      ),
    ],
    decals: const <PlateDecal>[
      PlateDecal(
        drawing: PlateDrawing(r, r, <PlateShape>[
          PlateRingShape(r / 2, r / 2, r / 2 - 1.75, 3.5, EthiopiaColors.blue),
        ]),
        box: PlateBox.centered(_Layout.discCx, _Layout.discCy, r, r),
      ),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'class'),
      PlateTextGroup(<int>[1, 2], key: 'geez'),
      PlateTextGroup(<int>[3], key: 'number'),
      PlateTextGroup(<int>[4, 5], key: 'code'),
    ],
  );
}

PlateSpec _private() {
  const h = _Layout.privateHeight;
  return PlateSpec(
    id: 'et.private',
    country: EthiopiaCountry.ethiopia,
    canvasWidth: _Layout.width,
    canvasHeight: h,
    slots: <PlateSlot>[
      _digits(_Layout.privateDigitsLeft, h, _Layout.privatePitch, 6),
    ],
    labels: const <PlateLabel>[
      // Ink y 6–27 flat (ኢት) and 43–55.5 (ETH), scaled by 145.7/110.
      PlateLabel(text: 'ኢት', box: PlateBox(17.5, 8, 44, 48), glyphHeight: 56),
      PlateLabel(text: 'ETH', box: PlateBox(17.5, 57, 44, 17), glyphHeight: 28),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'number'),
    ],
  );
}

PlateSpec _diplomatic() {
  const h = _Layout.diplomaticHeight;
  return PlateSpec(
    id: 'et.diplomatic',
    country: EthiopiaCountry.ethiopia,
    canvasWidth: _Layout.width,
    canvasHeight: h,
    // The bands run to the plate's top and bottom edges.
    background: const PlateSection.columns(<PlatePart>[
      PlatePart(PlateSection.plain, end: _Layout.bandAStart),
      PlatePart(
        PlateSection.fill(PlateFill.color(EthiopiaColors.yellow)),
        end: _Layout.bandAEnd,
      ),
      PlatePart(PlateSection.plain, end: _Layout.bandBStart),
      PlatePart(PlateSection.fill(PlateFill.color(EthiopiaColors.yellow))),
    ]),
    slots: <PlateSlot>[
      _digits(_Layout.missionLeft, h, _Layout.diplomaticPitch, 2),
      ..._stack(
        EthiopiaAlphabets.geez,
        _Layout.diplomaticGeezCx,
        42,
        0,
        0.5 * 120.6,
      ),
      _digits(_Layout.numberLeft, h, _Layout.diplomaticPitch, 4),
      ..._stack(
        EthiopiaAlphabets.letters,
        _Layout.diplomaticTypeCx,
        30,
        13.6,
        47,
      ),
    ],
    restrictions: const <PlateRestriction>[EthiopiaMissions.restriction],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'mission'),
      PlateTextGroup(<int>[1, 2], key: 'series'),
      PlateTextGroup(<int>[3], key: 'number'),
      PlateTextGroup(<int>[4, 5], key: 'type'),
    ],
  );
}
