import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'haiti_colors.dart';
import 'haiti_country.dart';

/// Where the ink sits on a Haitian plate, in plate units.
///
/// The canvas is 520×264, the aspect of the article's 300×152 mm. Every
/// number is read off the flattened photo of that design (`tools/platekit`,
/// 2080×1056 px → 520×264): row extents from its ink projection, the rest
/// from the contact sheet, so a position read that way is good to ~±5.
///
/// **Under-height ink, accepted.** A serial ink 115–125 tall would need a
/// ~210–225 slot (`glyphStyle` sets 0.72 of the slot and a bold digit is ~0.73
/// of that). The slots are as tall as the canvas allows; `plate_core` is
/// unchanged.
///
/// Not modelled: the coat of arms printed in a tint on the 1998 plates and in
/// the 2003 flag, the 2014 plate's map of Haiti and hologram, the 2006 plate's
/// pink map, validation stickers, and the region name of the 2006 plate
/// (a fixed "Ouest" here). The 2014 private plate has no photograph.
abstract final class _Layout {
  static const double width = 520, height = 264;

  // 2014 passenger transport (photo 2080×1056 → ×0.25): ink y 66..198,
  // letters x 40..146, dot 154..170, digits 180..500; stacked HAITI x 4..34,
  // y 42..205; "Transport Passagers" y 198..226 centred 263; slogan y 231..262.
  static const double t14Top = 14, t14Height = 230;
  static const PlateBox t14Letters = PlateBox(36, t14Top, 114, t14Height);
  static const PlateBox t14Digits = PlateBox(178, t14Top, 322, t14Height);
  static const PlateRule t14Dot = PlateRule(box: PlateBox(155, 117, 15, 13));

  // 2006 regional: ink y 83..203, HAITI y 38..75 centred x 259, band
  // x 24..500 y 212..248 with the name centred at 259.
  static const double r06Top = 44, r06Height = 200;
  static const PlateBox r06Letters = PlateBox(20, r06Top, 112, r06Height);
  static const PlateBox r06Digits = PlateBox(205, r06Top, 294, r06Height);

  // 2003: serial ink y 44..159, HAITI y 18..39 centred x 280, band
  // x 22..385 y 202..235, flag block x 384..497 y 193..244.
  static const double s03Top = 8, s03Height = 187;
  static const PlateBox s03Digits = PlateBox(230, s03Top, 268, s03Height);
  static const PlateBox s03Letter1 = PlateBox(80, s03Top, 76, s03Height);
  static const PlateBox s03Letter2 = PlateBox(22, s03Top, 140, s03Height);
  static const PlateBox s03Band = PlateBox(22, 202, 363, 33);
  static const PlateBox s03Flag = PlateBox(384, 193, 113, 51);

  // 1998: serial ink y 66..190, HAITI y 28..58 centred x 272, caption row
  // y 199..231 centred x 256.
  static const double s98Top = 18, s98Height = 220;
  static const PlateBox s98Letters = PlateBox(29, s98Top, 122, s98Height);
  static const PlateBox s98Digits = PlateBox(238, s98Top, 259, s98Height);
  static const PlateBox s98DigitsWide = PlateBox(205, s98Top, 292, s98Height);
}

/// Haiti's plate geometries, one per design; the categories of a design differ
/// by caption and by the length of the letter field.
///
/// Every spec has a `series` group (the letters, where the plate has any) and
/// a `number` group (the digits).
///
/// **Implemented:** the 2014 passenger-transport plate, the 2006 regional
/// plate, the 2003 series (private, location, transport passagers) and the
/// 1998 series (taxi, transport, international organisation).
///
/// **Not implemented:** the plates of 1923–1997, of which only the
/// 1977/1987/1989/1996 ones were photographed; they are long superseded. The
/// 1995–96 transport plate (CHECK in the brief) was not measured. The 2014
/// private plate has no image on the page. Where the brief's field split
/// disagreed with the picture (2003 transport "5 digits", 1998 international
/// "5 digits") the picture wins: four digits.
abstract final class HaitiPlates {
  static final List<PlateTextGroup> _lettersAndNumber = PlateTextGroup.perSlot(
    <String>['series', 'number'],
  );
  static const List<PlateTextGroup> _numberOnly = <PlateTextGroup>[
    PlateTextGroup(<int>[0], key: 'number'),
  ];

  static PlateSlot _letters(int count, PlateBox box) =>
      PlateSlot(alphabet: HaitiAlphabets.letters, box: box, length: count);

  static PlateSlot _digits(int count, PlateBox box) =>
      PlateSlot(alphabet: HaitiAlphabets.digits, box: box, length: count);

  static PlateSpec _spec({
    required String id,
    required double canvasHeight,
    required List<PlateSlot> slots,
    List<PlateBand> bands = const <PlateBand>[],
    List<PlateRule> rules = const <PlateRule>[],
    List<PlateLabel> labels = const <PlateLabel>[],
    List<PlateDecal> decals = const <PlateDecal>[],
  }) => PlateSpec(
    id: id,
    country: HaitiCountry.haiti,
    canvasWidth: _Layout.width,
    canvasHeight: canvasHeight,
    noPanel: true,
    panel: PlatePanel(box: PlateBox(0, 0, 0, canvasHeight)),
    slots: slots,
    textGroups: slots.length == 1 ? _numberOnly : _lettersAndNumber,
    bands: bands,
    rules: rules,
    labels: labels,
    decals: decals,
  );

  /// 2014 passenger transport: `AB·01234`. Stacked HAITI at the left edge, the
  /// serial, then "Transport Passagers" and the slogan beneath it.
  static final PlateSpec transport2014 = _spec(
    id: 'ht.transport2014',
    canvasHeight: _Layout.height,
    slots: <PlateSlot>[
      _letters(2, _Layout.t14Letters),
      _digits(5, _Layout.t14Digits),
    ],
    rules: const <PlateRule>[_Layout.t14Dot],
    labels: const <PlateLabel>[
      PlateLabel(
        text: 'H\nA\nÏ\nT\nI',
        box: PlateBox(2, 40, 34, 168),
        glyphHeight: 46,
        lineHeight: 0.98,
        color: HaitiColors.salmonRed,
      ),
      PlateLabel(
        text: 'Transport Passagers',
        box: PlateBox(108, 198, 310, 28),
        glyphHeight: 42,
      ),
      PlateLabel(
        text: 'La perle des Antilles',
        box: PlateBox(140, 232, 246, 30),
        glyphHeight: 40,
        color: HaitiColors.caption,
      ),
    ],
  );

  /// 2006–2013 regional plate: `AA·12345`, HAÏTI above the serial and a black
  /// band at the foot carrying the department's name.
  static final PlateSpec regional2006 = _spec(
    id: 'ht.regional2006',
    canvasHeight: _Layout.height,
    slots: <PlateSlot>[
      _letters(2, _Layout.r06Letters),
      _digits(5, _Layout.r06Digits),
    ],
    bands: const <PlateBand>[
      PlateBand(box: PlateBox(24, 212, 476, 36), color: HaitiColors.greenInk),
    ],
    labels: const <PlateLabel>[
      PlateLabel(
        text: 'HAÏTI',
        box: PlateBox(160, 36, 200, 40),
        glyphHeight: 67,
        color: HaitiColors.lightBlue,
      ),
      PlateLabel(
        text: 'Ouest',
        box: PlateBox(159, 214, 200, 32),
        glyphHeight: 50,
        color: HaitiColors.caption,
      ),
    ],
  );

  static PlateSpec _series2003(
    String id, {
    required int letters,
    required String caption,
    required double captionWidth,
  }) => _spec(
    id: id,
    canvasHeight: _Layout.height,
    slots: <PlateSlot>[
      if (letters > 0)
        _letters(
          letters,
          letters == 1 ? _Layout.s03Letter1 : _Layout.s03Letter2,
        ),
      _digits(4, _Layout.s03Digits),
    ],
    bands: const <PlateBand>[
      PlateBand(box: _Layout.s03Band, color: HaitiColors.navy),
    ],
    decals: const <PlateDecal>[
      // The flag's own arms are left out: see `_Layout`.
      PlateDecal(drawing: _flagBlock, box: _Layout.s03Flag),
    ],
    labels: <PlateLabel>[
      const PlateLabel(
        text: 'HAÏTI',
        box: PlateBox(190, 13, 180, 31),
        glyphHeight: 37,
        color: HaitiColors.paleGrey,
      ),
      PlateLabel(
        text: caption,
        box: PlateBox(24, 202, captionWidth, 33),
        glyphHeight: 36,
        color: HaitiColors.caption,
      ),
    ],
  );

  static const PlateDrawing _flagBlock = PlateDrawing(113, 51, <PlateShape>[
    PlateRectShape(0, 0, 113, 25.5, HaitiColors.flagBlue),
    PlateRectShape(0, 25.5, 113, 25.5, HaitiColors.flagRed),
  ]);

  /// 2003 private: `A·1234`, "Privé" on the band.
  static final PlateSpec private2003 = _series2003(
    'ht.private2003',
    letters: 1,
    caption: 'Privé',
    captionWidth: 100,
  );

  /// 2003 location (vehicle for hire): `1234`.
  static final PlateSpec location2003 = _series2003(
    'ht.location2003',
    letters: 0,
    caption: 'Location',
    captionWidth: 170,
  );

  /// 2003 transport passagers: `AB·1234`.
  static final PlateSpec transport2003 = _series2003(
    'ht.transport2003',
    letters: 2,
    caption: 'Transport Passagers',
    captionWidth: 350,
  );

  static PlateSpec _series1998(
    String id, {
    required int letters,
    required String caption,
  }) => _spec(
    id: id,
    canvasHeight: _Layout.height,
    slots: <PlateSlot>[
      if (letters > 0) _letters(letters, _Layout.s98Letters),
      _digits(4, letters > 0 ? _Layout.s98Digits : _Layout.s98DigitsWide),
    ],
    labels: <PlateLabel>[
      const PlateLabel(
        text: 'HAÏTI',
        box: PlateBox(170, 20, 204, 46),
        glyphHeight: 55,
        color: HaitiColors.captionBlue,
      ),
      PlateLabel(
        text: caption,
        box: const PlateBox(106, 199, 300, 32),
        glyphHeight: 40,
        color: HaitiColors.captionBlue,
      ),
    ],
  );

  /// 1998 taxi: `AB 1234`, "Taxi" in blue beneath.
  static final PlateSpec taxi1998 = _series1998(
    'ht.taxi1998',
    letters: 2,
    caption: 'Taxi',
  );

  /// 1998 transport: `AB 1234`.
  static final PlateSpec transport1998 = _series1998(
    'ht.transport1998',
    letters: 2,
    caption: 'Transport',
  );

  /// 1998 international organisation: `1234`.
  static final PlateSpec organisation1998 = _series1998(
    'ht.organisation1998',
    letters: 0,
    caption: 'Org. Internationale',
  );

  static final List<PlateSpec> all = <PlateSpec>[
    transport2014,
    regional2006,
    private2003,
    location2003,
    transport2003,
    taxi1998,
    transport1998,
    organisation1998,
  ];
}
