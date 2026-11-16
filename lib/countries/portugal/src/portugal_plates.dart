import 'package:flutter/widgets.dart' show EdgeInsets;
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'portugal_colors.dart';
import 'portugal_country.dart';

/// Plate units on 520×110. The reference flats are 520×332 (height stretched
/// 3.02×), so x is read as is and y is multiplied by 110/332. The current
/// plate's columns were projected on the pixels; every other plate's were read
/// by eye, good to a few units. Frame (4.3 ≈ 0.04) and band ends likewise.
///
/// Current `AA 00 AA` (vector `Portuguese_licence_plate`): band ends 53.3,
/// ink y 18.1–91.8; `AA` 77–205.5 (centres 108.5, 174), `00` 236.8–330.8
/// (257.9, 309.6), `AA` 359–487.5 (390.5, 456). `P` y 67–90, centred on the
/// band.
///
/// Dated `41·BE·81` (`Chapa98`): band ends 46.8, ribbon from x 468 to the
/// edge, ink y 17.6–99.9; `41` 51–147, `BE` 190–317, `81` 348–444; square
/// dots 13×14 at cx 174.2 and 332.5, y 51–65. Ribbon digits: year `06` y
/// 17.6–44.3, month `01` y 71.9–99, both centred 491, with a 4.3 dash at
/// y 56.8, x 473–507.
///
/// 1992 `72·93·FQ` (`Chapa92-98`, no ribbon): `72` 60–170, `93` 226–331,
/// `FQ` 400–516 (Q clipped by the window in the brief; pitch of F continued).
/// The photo prints a dot then a colon; both are drawn as the dot.
///
/// US Forces `A1·23·BC`: band 48 with `U`, ribbon as above; `A1` 63–156,
/// `23` 214–302.5, `BC` 356–453, dots centred 180 and 339.3.
///
/// GNR `GNR J·2558`: band ends 45.5; `GNR` 49–239, `J` 257–299, dot 305–317
/// y 49–61, digits 322–513.5 (pitch 49.5), ink y 12.5–95.6.
///
/// Trailer `L-186880`: band ends 57.2; `L` 69–112, dash 125–138 y 45–56,
/// six digits at centres 170 + 60.3 n (the `8` of the second digit is at
/// 230.5, `0` at 471).
///
/// Diplomatic `200-CD530`: no band. The photo crops the leading `2`, so the
/// embassy field is drawn from x 0 to its measured right edge 151; dash
/// 153–185 y 52–65; `CD` 187–325; `530` 325–499; ink y 17.6–95.6.
///
/// 1937 `DL-84-15` (white on black, no band): `DL` 24–143, `84` 208–327.5,
/// `15` 398.5–487.8 (pitch of `84` continued, the `1` sits left in its cell),
/// dashes 156.5–190.8 and 345–380, centred on y 55 (thickness 12, borrowed
/// from the diplomatic dash; not measured).
///
/// Every ink is 74–83 tall on a 110 plate; a box that tall would need ~140,
/// so each slot box is the full canvas height and the ink lands near 58,
/// 70–78% of reference.
abstract final class _Layout {
  static const double width = 520, height = 110, box = 110, top = 0;

  static const double starsTop = 2, starsHeight = 70.4, ribbonStart = 468;

  static const double pTop = 63.5, pHeight = 30, pGlyph = 45;

  static const double dotSize = 13, dotTop = 51, dotHeight = 14;
  static const double dashHeight = 12, dashTop = 49;
}

/// One fixed run: [count] characters whose first cell is centred on [cx].
class _Run {
  const _Run(this.alphabet, this.count, this.cx, this.pitch);

  final PlateAlphabet alphabet;
  final int count;
  final double cx, pitch;
}

/// The Portuguese plates. Groups are `first`, `second`, `third` on the
/// three-field registrations (plus `year`, `month` in the date ribbon),
/// `letter`, `number` on a GNR plate, `district`, `number` on a trailer plate
/// and `embassy`, `code`, `number` on a diplomatic plate.
///
/// [private] is the current series, `AA 00 AA`, black on white with the EU
/// band and no separators. [dated] is the 2005–2020 `00·AA·00` with the yellow
/// month/year ribbon, [legacy] the 1992–1998 `00·00·AA` without it,
/// [usForces] the `A1·23·BC` plate of Lajes with a `U` on the band, [gnr] the
/// National Republican Guard, [trailer] the district letter and six digits,
/// [diplomatic] the red `CD` plate and [historic] the 1937–1992 white-on-black
/// `AA-00-00`.
///
/// Not implemented: the 1998–2005 `00·00·AA` with a ribbon (the same design as
/// [dated] with the fields in another order), the 1911–1936 zone plates, the
/// 1997 imported-vehicle series, tactical military plates (the [historic]
/// design with `MG`/`ME`/`MX`/`AP`/`AM` prefixes), and the Cape Verde,
/// Mozambique and Angola plates, which belong to those countries' packages.
abstract final class PortugalPlates {
  static final PlateSpec private = _spec(
    id: 'pt.private',
    bandEnd: 53.3,
    runs: const <_Run>[
      _Run(PortugalAlphabets.letters, 2, 108.5, 65.5),
      _Run(PortugalAlphabets.digits, 2, 257.9, 51.7),
      _Run(PortugalAlphabets.letters, 2, 390.5, 65.5),
    ],
  );

  static final PlateSpec dated = _spec(
    id: 'pt.dated',
    bandEnd: 46.8,
    ribbon: true,
    runs: const <_Run>[
      _Run(PortugalAlphabets.digits, 2, 75, 48),
      _Run(PortugalAlphabets.letters, 2, 221.5, 63.5),
      _Run(PortugalAlphabets.digits, 2, 372, 48),
    ],
    dots: const <double>[174.2, 332.5],
  );

  static final PlateSpec legacy = _spec(
    id: 'pt.legacy',
    bandEnd: 47,
    runs: const <_Run>[
      _Run(PortugalAlphabets.digits, 2, 85, 55),
      _Run(PortugalAlphabets.digits, 2, 251.7, 53),
      _Run(PortugalAlphabets.letters, 2, 424, 58.5),
    ],
    dots: const <double>[197, 363],
  );

  static final PlateSpec usForces = _spec(
    id: 'pt.us_forces',
    bandEnd: 48,
    bandLetter: 'U',
    ribbon: true,
    runs: const <_Run>[
      _Run(PortugalAlphabets.mixed, 2, 86.3, 46.5),
      _Run(PortugalAlphabets.digits, 2, 236, 44.3),
      _Run(PortugalAlphabets.letters, 2, 380, 48.5),
    ],
    dots: const <double>[180, 339.3],
  );

  static final PlateSpec historic = _spec(
    id: 'pt.historic',
    runs: const <_Run>[
      _Run(PortugalAlphabets.letters, 2, 51.4, 59.4),
      _Run(PortugalAlphabets.digits, 2, 238, 59.8),
      _Run(PortugalAlphabets.digits, 2, 400.8, 59.6),
    ],
    dashes: const <(double, double)>[(156.5, 34.3), (345, 35)],
  );

  static final PlateSpec gnr = PlateSpec(
    id: 'pt.gnr',
    country: PortugalCountry.portugal,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    panel: _panel(45.5),
    background: _background(45.5, false),
    slots: <PlateSlot>[
      _span(PortugalAlphabets.letters, 248, 60, 1),
      _run(const _Run(PortugalAlphabets.digits, 4, 344.3, 49.5)),
    ],
    labels: <PlateLabel>[
      _bandLetter('P', 45.5),
      const PlateLabel(
        text: 'GNR',
        box: PlateBox(49, _Layout.top, 190, _Layout.box),
        glyphHeight: 100,
      ),
    ],
    rules: <PlateRule>[_dot(311)],
    textGroups: PlateTextGroup.perSlot(<String>['letter', 'number']),
  );

  /// The district letter or letters (`L`, `AN`) then up to six digits. The
  /// article gives no range for the digits; the photo shows six.
  static final PlateSpec trailer = PlateSpec(
    id: 'pt.trailer',
    country: PortugalCountry.portugal,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    panel: _panel(57.2),
    background: _background(57.2, false),
    slots: <PlateSlot>[
      _span(PortugalAlphabets.letters, 61, 61, 2, minLength: 1),
      _span(PortugalAlphabets.digits, 140, 362, 6, minLength: 1),
    ],
    labels: <PlateLabel>[_bandLetter('P', 57.2)],
    rules: const <PlateRule>[PlateRule(box: PlateBox(125, 45, 13, 11))],
    textGroups: PlateTextGroup.perSlot(<String>['district', 'number']),
  );

  /// Embassy code of one to three digits, `CD`, three digits.
  static final PlateSpec diplomatic = PlateSpec(
    id: 'pt.diplomatic',
    country: PortugalCountry.portugal,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    slots: <PlateSlot>[
      _span(PortugalAlphabets.digits, 0, 151, 3, minLength: 1),
      _span(PortugalAlphabets.diplomaticCode, 187, 138, 2),
      _span(PortugalAlphabets.digits, 325, 174, 3),
    ],
    rules: const <PlateRule>[PlateRule(box: PlateBox(153, 52, 32, 13))],
    textGroups: PlateTextGroup.perSlot(<String>['embassy', 'code', 'number']),
  );

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    dated,
    legacy,
    usForces,
    gnr,
    trailer,
    diplomatic,
    historic,
  ];

  static PlatePanel _panel(double bandEnd) => PlatePanel(
    box: PlateBox(1, _Layout.starsTop, bandEnd, _Layout.starsHeight),
    padding: EdgeInsets.zero,
  );

  /// The euroband (and the date ribbon) are the background, under the frame.
  static PlateSection _background(double bandEnd, bool ribbon) =>
      PlateSection.columns(<PlatePart>[
        PlatePart(const PlateSection.fill(PlateFill.panel), end: bandEnd),
        if (ribbon) ...<PlatePart>[
          const PlatePart(PlateSection.plain, end: _Layout.ribbonStart),
          const PlatePart(
            PlateSection.fill(PlateFill.color(PortugalColors.ribbonYellow)),
          ),
        ] else
          const PlatePart(PlateSection.plain),
      ]);

  static PlateLabel _bandLetter(String text, double bandEnd) => PlateLabel(
    text: text,
    box: PlateBox(0, _Layout.pTop, bandEnd, _Layout.pHeight),
    glyphHeight: _Layout.pGlyph,
    color: PortugalColors.white,
  );

  static PlateRule _dot(double cx) => PlateRule(
    box: PlateBox(
      cx - _Layout.dotSize / 2,
      _Layout.dotTop,
      _Layout.dotSize,
      _Layout.dotHeight,
    ),
  );

  /// A fixed run at the printed pitch.
  static PlateSlot _run(_Run r) => plateRun(
    r.alphabet,
    r.count,
    left: r.cx - r.pitch / 2,
    top: _Layout.top,
    pitch: r.pitch,
    height: _Layout.box,
  );

  /// A field over an explicit span; a variable one keeps spacing 0.
  static PlateSlot _span(
    PlateAlphabet alphabet,
    double left,
    double width,
    int length, {
    int? minLength,
  }) => PlateSlot(
    alphabet: alphabet,
    box: PlateBox(left, _Layout.top, width, _Layout.box),
    length: length,
    minLength: minLength,
  );

  /// The three-field registrations: [runs] are the fields in order, [dots]
  /// are square dots between them, [dashes] are `(left, width)` dashes.
  static PlateSpec _spec({
    required String id,
    required List<_Run> runs,
    double? bandEnd,
    String bandLetter = 'P',
    bool ribbon = false,
    List<double> dots = const <double>[],
    List<(double, double)> dashes = const <(double, double)>[],
  }) {
    final bool band = bandEnd != null;
    return PlateSpec(
      id: id,
      country: PortugalCountry.portugal,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      panel: band ? _panel(bandEnd) : PlatePanel.none,
      noPanel: !band,
      background: band ? _background(bandEnd, ribbon) : PlateSection.plain,
      slots: <PlateSlot>[
        for (final _Run r in runs) _run(r),
        if (ribbon) ...<PlateSlot>[
          _date(6.5), // year, y 17.6–44.3
          _date(61), // month, y 71.9–99
        ],
      ],
      labels: <PlateLabel>[if (band) _bandLetter(bandLetter, bandEnd)],
      rules: <PlateRule>[
        for (final double cx in dots) _dot(cx),
        for (final (double left, double width) in dashes)
          PlateRule(
            box: PlateBox(left, _Layout.dashTop, width, _Layout.dashHeight),
          ),
        if (ribbon) const PlateRule(box: PlateBox(473, 54.7, 34, 4.3)),
      ],
      textGroups: <PlateTextGroup>[
        const PlateTextGroup(<int>[0], key: 'first'),
        const PlateTextGroup(<int>[1], key: 'second'),
        const PlateTextGroup(<int>[2], key: 'third'),
        if (ribbon) ...const <PlateTextGroup>[
          PlateTextGroup(<int>[3], key: 'year'),
          PlateTextGroup(<int>[4], key: 'month'),
        ],
      ],
    );
  }

  /// A two-digit ribbon field centred on x 491, 49 tall (ink 26.7).
  static PlateSlot _date(double top) => PlateSlot(
    alphabet: PortugalAlphabets.digits,
    box: PlateBox(473, top, 36, 49),
    length: 2,
  );
}
