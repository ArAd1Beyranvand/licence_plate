import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'palau_colors.dart';
import 'palau_country.dart';

/// Where the ink sits on a Palauan plate, in the units the offline stage
/// flattened every reference to: 520×249 (aspect 2.09; the photos fit 1.99..
/// 2.22 and the article's 6×12 in is 2.0). Rows are y extents of ink measured
/// on the flattened photos.
///
/// * Header (state name): ink 17..55, centre ~36, 25..35 tall.
/// * Serial: ink 55..187 on most state plates, centre ~123, 110..125 tall.
/// * Footer: ink 200..231, centre ~216, 25..30 tall.
///
/// **Glyph size.** `glyphStyle` is 0.72 of a box and a bold digit ~0.75 of
/// that, so ink is ~55% of the box. The serial box is therefore 210 tall for
/// ~115 of ink, centred on 123 (it overlaps the header and footer boxes,
/// which only position text), and shrinks when a run's pitch asks for less:
/// a digit advances ~0.43 of the box height, so a run of pitch P takes a box
/// of at most P / 0.43. The measured pitch rules where the font cannot match.
///
/// **Where each serial sits.** The span of every serial is the x extent of
/// its digit run in the brief's row table; plates with a seal on the left
/// start the run right of it. Spans for Koror, Melekeok, Ngardmau
/// (government), Ngatpang, Ngarchelong, Peleliu and Ngiwal are read off the
/// flattened sheet because the row table merges the emblem into the run.
///
/// **Not drawn.** State seals, the bai, the waterfall, the issue-month and
/// year stickers, the wavy diplomatic border and the Judiciary scales are
/// emblems or stickers, not boxes and text; the references are photos and no
/// vector for them was fetched.
abstract final class _Layout {
  static const double width = 520, height = 249;

  static const double headerCentre = 36, headerGlyph = 50, serialCentre = 123;
  static const double serialHeight = 210, footerCentre = 216, footerGlyph = 48;

  /// Digit advance over box height: Roboto's 0.56 em at 0.72 of the box.
  static const double advance = 0.43;

  /// Dash between two fields, in digit pitches.
  static const double dash = 0.6;

  /// Government flag decal (`X_Gov_2019_b`, 2000 px → 520): x 415..494,
  /// y 99..148.
  static const PlateBox flagBox = PlateBox(415, 99, 79, 49);
}

/// One element of a serial: a field (one `PlateSlot`), a printed dash, or an
/// unprinted gap between fields.
class _Item {
  const _Item.field(
    PlateAlphabet this.alphabet,
    int this.length,
    String this.key,
  ) : weight = length * 1.0,
      text = null;
  const _Item.dash()
    : alphabet = null,
      length = 0,
      key = null,
      weight = _Layout.dash,
      text = '-';
  const _Item.gap(this.weight)
    : alphabet = null,
      length = 0,
      key = null,
      text = null;

  final PlateAlphabet? alphabet;
  final int length;
  final String? key;
  final double weight;
  final String? text;
}

/// Palau's plate geometries. Every state issues its own plate, but they are
/// one design: a header naming the state, a serial, a footer. The builder
/// takes the wording and the serial's fields; colours are the theme's.
///
/// Group keys: `letters`, `code`, `digits` or one mixed `serial`.
///
/// Not implemented: Aimeliik government, Hatohobei (hand-stencilled), Ngchesar
/// (a white inset box), Sonsorol (stars), the LGSP/UNEP and PICRC plates, and
/// every pre-2008 livery — the photos for those are CHECK in the brief or the
/// plate is historic.
abstract final class PalauPlates {
  static const _Item _digits4 = _Item.field(PalauAlphabets.digits, 4, 'digits');

  static PlateSpec _plate({
    required String id,
    required String header,
    String? footer = 'REPUBLIC OF PALAU',
    required List<_Item> serial,
    required double left,
    required double right,
    double headerCentre = _Layout.headerCentre,
    double headerGlyph = _Layout.headerGlyph,
    double serialCentre = _Layout.serialCentre,
    double serialHeight = _Layout.serialHeight,
    double footerCentre = _Layout.footerCentre,
    double footerGlyph = _Layout.footerGlyph,
    List<PlateLabel> extraLabels = const <PlateLabel>[],
    List<PlateDecal> decals = const <PlateDecal>[],
  }) {
    final double weights = serial.fold(
      0.0,
      (double a, _Item i) => a + i.weight,
    );
    final double pitch = (right - left) / weights;
    final double h = <double>[
      serialHeight,
      pitch / _Layout.advance,
    ].reduce((double a, double b) => a < b ? a : b);
    final double top = serialCentre - h / 2;

    final List<PlateSlot> slots = <PlateSlot>[];
    final List<PlateLabel> labels = <PlateLabel>[
      PlateLabel(
        text: header,
        box: PlateBox(20, headerCentre - headerGlyph / 2, 480, headerGlyph),
        glyphHeight: headerGlyph,
      ),
      if (footer != null)
        PlateLabel(
          text: footer,
          box: PlateBox(20, footerCentre - footerGlyph / 2, 480, footerGlyph),
          glyphHeight: footerGlyph,
        ),
      ...extraLabels,
    ];
    double x = left;
    for (final _Item item in serial) {
      final double w = item.weight * pitch;
      if (item.alphabet != null) {
        slots.add(
          PlateSlot(
            alphabet: item.alphabet!,
            box: PlateBox(x, top, w, h),
            length: item.length,
            group: item.key,
          ),
        );
      } else if (item.text != null) {
        labels.add(
          PlateLabel(
            text: item.text!,
            box: PlateBox(x, top, w, h),
            glyphHeight: h,
          ),
        );
      }
      x += w;
    }
    return PlateSpec(
      id: id,
      country: PalauCountry.palau,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      noPanel: true,
      panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
      slots: slots,
      labels: labels,
      decals: decals,
    );
  }

  static final PlateSpec airai = _plate(
    id: 'pw.airai',
    header: 'AIRAI STATE',
    footer: 'HOME OF MEDECHII BELAU',
    serial: const <_Item>[_digits4],
    left: 178.5,
    right: 467.2,
  );

  static final PlateSpec angaur = _plate(
    id: 'pw.angaur',
    header: 'Angaur State',
    serial: const <_Item>[
      _Item.field(PalauAlphabets.letters, 1, 'letters'),
      _Item.gap(0.7),
      _digits4,
    ],
    left: 32.5,
    right: 454.5,
  );

  static final PlateSpec kayangel = _plate(
    id: 'pw.kayangel',
    header: 'KAYANGEL STATE',
    serial: const <_Item>[_digits4],
    left: 153.8,
    right: 455,
  );

  /// Five digits (`18374`); the run's left edge is estimated, the row table
  /// merging the bai into it.
  static final PlateSpec koror = _plate(
    id: 'pw.koror',
    header: 'STATE OF KOROR',
    footer: 'BOUNTIFUL ISLES',
    serial: const <_Item>[_Item.field(PalauAlphabets.digits, 5, 'digits')],
    left: 130,
    right: 497,
  );

  /// The black plate, `2K5136`: one mixed run the photo prints without a gap.
  static final PlateSpec kororBlack = _plate(
    id: 'pw.kororBlack',
    header: 'STATE OF KOROR',
    footer: 'BOUNTIFUL ISLES',
    serial: const <_Item>[
      _Item.field(PalauAlphabets.alphanumeric, 6, 'serial'),
    ],
    left: 36.2,
    right: 486.8,
  );

  static final PlateSpec melekeok = _plate(
    id: 'pw.melekeok',
    header: 'STATE OF MELEKEOK',
    serial: const <_Item>[_digits4],
    left: 215,
    right: 491,
  );

  static final PlateSpec ngaraard = _plate(
    id: 'pw.ngaraard',
    header: 'STATE OF NGARAARD',
    serial: const <_Item>[_digits4],
    left: 181.5,
    right: 477,
  );

  static final PlateSpec ngarchelong = _plate(
    id: 'pw.ngarchelong',
    header: 'NGARCHELONG STATE',
    serial: const <_Item>[_digits4],
    left: 190,
    right: 485,
  );

  static final PlateSpec ngardmau = _plate(
    id: 'pw.ngardmau',
    header: 'STATE OF NGARDMAU',
    serial: const <_Item>[_digits4],
    left: 162.8,
    right: 468.8,
  );

  /// Three digits (`018`) under "GOVERNMENT".
  static final PlateSpec ngardmauGovernment = _plate(
    id: 'pw.ngardmauGovernment',
    header: 'STATE OF NGARDMAU',
    footer: 'GOVERNMENT',
    serial: const <_Item>[_Item.field(PalauAlphabets.digits, 3, 'digits')],
    left: 100,
    right: 385,
  );

  static final PlateSpec ngatpang = _plate(
    id: 'pw.ngatpang',
    header: 'NGATPANG STATE',
    serial: const <_Item>[_digits4],
    left: 100,
    right: 405,
  );

  static final PlateSpec ngeremlengui = _plate(
    id: 'pw.ngeremlengui',
    header: 'NGEREMLENGUI STATE',
    footer: 'Republic of Palau',
    serial: const <_Item>[_Item.field(PalauAlphabets.digits, 3, 'digits')],
    left: 151.8,
    right: 367.8,
  );

  /// `K79-691`: a letter, a two-digit code, a dash, three digits.
  static final PlateSpec ngiwal = _plate(
    id: 'pw.ngiwal',
    header: 'NGIWAL STATE',
    footer: 'CHAD RA KIULUUL',
    serial: const <_Item>[
      _Item.field(PalauAlphabets.letters, 1, 'letters'),
      _Item.field(PalauAlphabets.digits, 2, 'code'),
      _Item.dash(),
      _Item.field(PalauAlphabets.digits, 3, 'digits'),
    ],
    left: 150,
    right: 497,
  );

  static final PlateSpec peleliu = _plate(
    id: 'pw.peleliu',
    header: 'STATE OF PELELIU',
    footer: 'ODESANGEL PRIDE',
    serial: const <_Item>[_digits4],
    left: 110,
    right: 400,
  );

  /// `AS-776`: two letters, a separator, three digits.
  static final PlateSpec aimeliik = _plate(
    id: 'pw.aimeliik',
    header: 'AIMELIIK STATE',
    serial: const <_Item>[
      _Item.field(PalauAlphabets.letters, 2, 'letters'),
      _Item.dash(),
      _Item.field(PalauAlphabets.digits, 3, 'digits'),
    ],
    left: 45,
    right: 300,
  );

  /// National government, `1234`, with the flag in plate colours at the right:
  /// the ink field, the plate's colour for the disc.
  static final PlateSpec government = _plate(
    id: 'pw.government',
    header: 'GOVERNMENT',
    serial: const <_Item>[_digits4],
    left: 140,
    right: 390,
    decals: const <PlateDecal>[
      PlateDecal(
        drawing: PlateDrawing(800, 500, <PlateShape>[
          PlateRectShape(0, 0, 800, 500, PalauColors.governmentInk),
          PlateCircleShape(350, 250, 150, PalauColors.governmentField),
        ]),
        box: _Layout.flagBox,
      ),
    ],
  );

  /// `991`. Measured by hand off the original photo (330×161, ×1.576):
  /// digits x 158..355, header centre 46, footer centre 211.
  static final PlateSpec judiciary = _plate(
    id: 'pw.judiciary',
    header: 'JUDICIARY',
    footer: 'REPUBLIC OF PALAU',
    serial: const <_Item>[_Item.field(PalauAlphabets.digits, 3, 'digits')],
    left: 158,
    right: 355,
    headerCentre: 46,
    footerCentre: 211,
  );

  /// `A 069` under a large "DIPLOMAT": header ink 40..107 (67 tall), serial
  /// ink 120..202. Wavy border not drawn.
  static final PlateSpec diplomatic = _plate(
    id: 'pw.diplomatic',
    header: 'DIPLOMAT',
    footer: null,
    serial: const <_Item>[
      _Item.field(PalauAlphabets.letters, 1, 'letters'),
      _Item.gap(1),
      _Item.field(PalauAlphabets.digits, 3, 'digits'),
    ],
    left: 145.5,
    right: 392.5,
    headerCentre: 73.5,
    headerGlyph: 100,
    serialCentre: 161,
    serialHeight: 150,
  );

  /// Belau National Museum, `BNM-5502`, with its two caption lines.
  static final PlateSpec museum = _plate(
    id: 'pw.museum',
    header: 'Belau National Museum',
    footer: 'Republic of Palau',
    serial: const <_Item>[
      _Item.field(PalauAlphabets.letters, 3, 'letters'),
      _Item.dash(),
      _Item.field(PalauAlphabets.digits, 4, 'digits'),
    ],
    left: 49,
    right: 468,
    headerCentre: 32,
    headerGlyph: 55,
    serialCentre: 144,
    serialHeight: 200,
    footerCentre: 224,
    footerGlyph: 28,
    extraLabels: const <PlateLabel>[
      PlateLabel(
        text: 'A Cherechar a Lokelii',
        box: PlateBox(20, 47, 480, 28),
        glyphHeight: 28,
      ),
    ],
  );
}
