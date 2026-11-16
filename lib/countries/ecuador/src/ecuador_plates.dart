import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'ecuador_country.dart';

/// Where the ink sits, in plate units. The documented plate is 404×154 mm
/// (2.62); the references were flattened to 520×200 (2.60) and every number
/// is off them, so the canvas is 520×200 and y is 0.9% tall against the mm.
///
/// Ink runs, measured on the flattened 2012 artwork (`Particular`,
/// `Comercial`, `Diplomático`, `Internación Temporal`):
///
/// * caption `ECUADOR`: x 166–352 (centred at 259), ink y 5–37.25, 32 tall.
/// * characters: ink y 75.5–165.75, 90 tall, centre 120.6; every run has a
///   pitch of 55.5.
/// * standard `AAC-0123`: letter centres 77, 132.7, 188; dash x 220–244.8
///   (centre 232.4), y 120.75–129 (centre 124.9); digit centres 276, 332,
///   387, 443.
/// * protocol `CD-0123`: letter centres 104.5, 160.6; dash centre 204.3;
///   digit centres 248.4, 304, 359.3, 415.2. `IT` is the same plate (the
///   narrow `I` is centred in its cell).
/// * the band runs to y 42 (the edge is blurred over 40.5–44); the ANT mark
///   at x 15–48, y 4–42 is not drawn.
///
/// **Under-height ink, accepted.** 90 of ink would need a ~164 box on a
/// 200-unit plate with the ink centred at 120.6, which leaves 158 at most
/// before the box leaves the canvas; the boxes are 156. The glyph is then
/// width-limited by its 55.5 cell, since the font's digits are wider than
/// the plate's condensed face. `plate_core` is unchanged.
abstract final class _Layout {
  static const double width = 520, height = 200;

  static const double bandEnd = 42;

  static const double captionCx = 259, captionCy = 21.1, captionBox = 42;
  static const double captionWidth = 300, captionGlyph = 58;

  static const double pitch = 55.5, runCy = 120.6, runBox = 156;
  static const double runTop = runCy - runBox / 2;

  static const double dashCy = 124.9, dashBox = 148, dashWidth = 30;
  static const double dashGlyph = 115;
}

/// Where the runs of one design start: the first letter's centre, and the
/// dash and first digit's.
class _Design {
  const _Design(
    this.id,
    this.letters,
    this.lettersCx,
    this.dashCx,
    this.digitsCx,
  );

  final String id;
  final int letters;
  final double lettersCx, dashCx, digitsCx;
}

/// Ecuador's plates, one design per layout; the livery is the theme's.
///
/// * [standard] — `ABC-0123`: a province letter, a key letter naming the type
///   and a third letter, then three or four digits. Private, commercial,
///   government, official-use and decentralised-government plates are this
///   spec; only the band colour differs.
/// * [protocol] — `CD-0123`: a two-letter code (`CC`, `CD`, `OI`, `AT`, `IT`)
///   and three or four digits. Diplomatic and international-organisation
///   plates.
///
/// The digits are one slot of `minLength: 3`, `length: 4`: the article gives
/// `ABC-123` (old) and `ABC-1234` (new), both current.
///
/// Not implemented: the police plate (pictured as a blank shape, being phased
/// out), the 1989–2014 plates that colour the whole face, and the military,
/// motorcycle and temporary plates, which the article describes without a
/// picture.
abstract final class EcuadorPlates {
  static final List<PlateTextGroup> _groups = PlateTextGroup.perSlot(<String>[
    'letters',
    'number',
  ]);

  static final PlateSpec standard = _build(
    const _Design('ec.standard', 3, 77, 232.4, 276),
  );

  static final PlateSpec protocol = _build(
    const _Design('ec.protocol', 2, 104.5, 204.3, 248.4),
  );

  static List<PlateSpec> get all => <PlateSpec>[standard, protocol];

  static PlateSpec _build(_Design d) {
    const double p = _Layout.pitch;
    return PlateSpec(
      id: d.id,
      country: EcuadorCountry.ecuador,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      noPanel: true,
      panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
      background: const PlateSection.rows(<PlatePart>[
        PlatePart(PlateSection.fill(PlateFill.divider), end: _Layout.bandEnd),
        PlatePart(PlateSection.plain),
      ]),
      slots: <PlateSlot>[
        plateRun(
          EcuadorAlphabets.letters,
          d.letters,
          left: d.lettersCx - p / 2,
          top: _Layout.runTop,
          pitch: p,
          height: _Layout.runBox,
        ),
        PlateSlot(
          alphabet: EcuadorAlphabets.digits,
          box: PlateBox(
            d.digitsCx - p / 2,
            _Layout.runTop,
            4 * p,
            _Layout.runBox,
          ),
          length: 4,
          minLength: 3,
        ),
      ],
      labels: <PlateLabel>[
        PlateLabel(
          text: 'ECUADOR',
          box: PlateBox.centered(
            _Layout.captionCx,
            _Layout.captionCy,
            _Layout.captionWidth,
            _Layout.captionBox,
          ),
          glyphHeight: _Layout.captionGlyph,
        ),
        PlateLabel(
          text: '-',
          box: PlateBox.centered(
            d.dashCx,
            _Layout.dashCy,
            _Layout.dashWidth,
            _Layout.dashBox,
          ),
          glyphHeight: _Layout.dashGlyph,
        ),
      ],
      textGroups: _groups,
    );
  }
}
