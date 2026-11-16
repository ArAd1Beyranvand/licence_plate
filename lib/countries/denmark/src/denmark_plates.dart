import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'denmark_colors.dart';
import 'denmark_country.dart';

/// One field's ink on the 520×110 canvas: centre of its run, printed pitch
/// and the y-centre of its ink, all measured off the references flattened to
/// plate units (4 px per unit).
class _Row {
  const _Row({
    required this.ink,
    required this.letters,
    required this.lettersPitch,
    this.mid,
    this.midPitch = 55,
    required this.number,
    required this.numberPitch,
  });

  final double ink;
  final double letters, lettersPitch;
  final double? mid;
  final double midPitch;
  final double number, numberPitch;
}

/// Where the ink sits, in plate coordinates.
///
/// Every serial plate is `AB 12 345`: a letters field, a two-digit field and
/// a three-digit field. Ink is 71 tall on the artwork (y 19.8..90.8), which
/// would need a ~129 box on a 110 canvas; boxes are capped at 106, so ink
/// lands at ~56, about 79 % of reference (`glyphStyle` is 0.72 of the box
/// and is not changed). Where the ink sits off-centre the box is shortened so
/// it stays inside the canvas.
abstract final class _Layout {
  static const double width = 520, height = 110, maxGlyphBox = 106;

  /// 2009 artwork with the EU stripe: letters 73.0..187.8, `12` 221.8..312.0,
  /// `312` 345.8..496.5.
  static const _Row eu = _Row(
    ink: 55.3,
    letters: 130.4,
    lettersPitch: 64.5,
    mid: 267,
    number: 421.2,
    numberPitch: 55,
  );

  /// 2008 artwork without a stripe: 34.0..147.8, 199.0..288.2, 339.5..490.0.
  static const _Row noEu = _Row(
    ink: 54.9,
    letters: 90.9,
    lettersPitch: 64.4,
    mid: 243.6,
    number: 414.8,
    numberPitch: 55,
  );

  /// 1976 artwork (commercial, diplomatic): a wider face, letters
  /// 23.5..155.2, `12` 195.8..291.0, `312` 337.0..497.2.
  static const _Row old = _Row(
    ink: 54.5,
    letters: 89.4,
    lettersPitch: 72.3,
    mid: 243.4,
    number: 417.1,
    numberPitch: 56.5,
  );

  /// Greenland photograph: ink y 14.5..88.8; 47.2..156.5, 187.8..284.8,
  /// 314.5..470.8.
  static const _Row greenland = _Row(
    ink: 51.65,
    letters: 101.9,
    lettersPitch: 61.7,
    mid: 236.3,
    midPitch: 56,
    number: 392.7,
    numberPitch: 57.7,
  );

  /// Fixed temporary plate `DD 12`: letters 125.5..239.2, digits
  /// 269.8..372.0, ink y 20..90.5. The article gives no digit count; the
  /// picture shows two.
  static const _Row fixedTemporary = _Row(
    ink: 55.25,
    letters: 182.4,
    lettersPitch: 64.6,
    number: 320.9,
    numberPitch: 62,
  );

  /// Faroese photograph `BG 339`: letters 110.5..240.0, digits 297.0..475.5,
  /// ink y 14..78.2.
  static const _Row faroe = _Row(
    ink: 46.1,
    letters: 175.3,
    lettersPitch: 72.8,
    number: 386.3,
    numberPitch: 65.9,
  );

  // Panel columns. Standard: EU blue to 50, hologram to 65.5.
  static const double panelEnd = 50, hologramEnd = 65.5;
  static const PlatePanel euPanel = PlatePanel(box: PlateBox(5, 5, 45, 100));

  /// Parrot plates colour the letters block: to 203.5 after the hologram, or
  /// 175.5 from the plate's edge when there is no stripe.
  static const double parrotEuEnd = 203.5, parrotEnd = 175.5;

  // Temporary export: EU blue to 53, hologram to 62, a red year patch at
  // x 76..142 y 35..78, then `14` (192..285) and `880` (315..478), ink
  // y 22..95.
  static const double exportPanelEnd = 53, exportHologramEnd = 62;
  static const double yearInk = 56.5, yearCentre = 106, yearPitch = 33;
  static const double exportInk = 58.5;
  static const double exportPairCentre = 238.5, exportNumberCentre = 396.5;
  static const double exportPitch = 58, yearLeft = 76, yearRight = 142;

  // Faroese panel: a blue rounded block x 9..77, y 10..85.
  static const double faroePanelLeft = 9, faroePanelRight = 77;
  static const double faroePanelTop = 10, faroePanelBottom = 85;

  // Vanity: one run centred in the field after the stripe (73.5..503.5) or
  // across the whole plate. Ink y 14..94.
  static const PlateBox vanityEu = PlateBox(73.5, 0, 430, 108);
  static const PlateBox vanityPlain = PlateBox(14, 0, 492, 108);
}

class _Field {
  const _Field(
    this.key,
    this.alphabet,
    this.centre,
    this.pitch,
    this.count,
    this.ink, {
    this.color,
  });

  final String key;
  final PlateAlphabet alphabet;
  final double centre, pitch, ink;
  final int count;
  final Color? color;

  PlateSlot get slot {
    final double h = min(
      _Layout.maxGlyphBox,
      2 * min(ink, _Layout.height - ink),
    );
    return plateRun(
      alphabet,
      count,
      centre: centre,
      top: ink - h / 2,
      pitch: pitch,
      height: h,
      color: color,
    );
  }
}

/// Denmark's plate geometries. A livery is the theme's; a stripe, a coloured
/// letters block or a year patch is part of the spec.
///
/// Serial plates have the text groups `letters`, `mid` (two digits, absent on
/// the fixed temporary and Faroese plates) and `number`; the export plate adds
/// `year` first; the vanity plate is one `text` field of two to seven
/// characters.
///
/// Not implemented, with the reason: the royal crown plate (no usable
/// picture, a crown not a vector), DEMA, ambulance and fire-brigade plates
/// (each carries a local crest between the serials, one per unit), armed
/// forces, historical, airport and gooseneck plates (no reference picture).
/// The Danish flag on the article is not printed on any plate.
abstract final class DenmarkPlates {
  static final PlateAlphabet _letters = DenmarkAlphabets.letters;

  /// Private plate with the EU stripe.
  static final PlateSpec privateEu = _serial(
    id: 'dk.privateEu',
    row: _Layout.eu,
    stripe: true,
  );

  /// Private plate without the stripe.
  static final PlateSpec private = _serial(id: 'dk.private', row: _Layout.noEu);

  /// Parrot plate: commercial vehicles also allowed private use, with the
  /// letters printed on yellow.
  static final PlateSpec parrotEu = _serial(
    id: 'dk.parrotEu',
    row: _Layout.eu,
    stripe: true,
    yellowEnd: _Layout.parrotEuEnd,
  );

  static final PlateSpec parrot = _serial(
    id: 'dk.parrot',
    row: _Layout.noEu,
    yellowEnd: _Layout.parrotEnd,
  );

  /// Commercial plate: black on yellow, in the 1976 face.
  static final PlateSpec commercial = _serial(
    id: 'dk.commercial',
    row: _Layout.old,
  );

  /// Diplomatic plate: white on blue in the 1976 face, serials 76 and 77.
  static final PlateSpec diplomatic = _serial(
    id: 'dk.diplomatic',
    row: _Layout.old,
  );

  /// Greenland: letters `GR` or `GL`, no stripe.
  static final PlateSpec greenland = _serial(
    id: 'dk.greenland',
    row: _Layout.greenland,
  );

  /// Fixed temporary plate: red letters and digits, no stripe.
  static final PlateSpec fixedTemporary = _serial(
    id: 'dk.fixedTemporary',
    row: _Layout.fixedTemporary,
    numberCount: 2,
  );

  /// Faroese plate: `AB 123`, the Faroese flag over `FO` on a blue block.
  static final PlateSpec faroeIslands = PlateSpec(
    id: 'dk.faroeIslands',
    country: DenmarkCountry.faroeIslands,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    panel: const PlatePanel(
      box: PlateBox.fromLTRB(
        _Layout.faroePanelLeft,
        _Layout.faroePanelTop,
        _Layout.faroePanelRight,
        _Layout.faroePanelBottom,
      ),
    ),
    background: const PlateSection.columns(<PlatePart>[
      PlatePart(PlateSection.plain, end: _Layout.faroePanelLeft),
      PlatePart(
        PlateSection.rows(<PlatePart>[
          PlatePart(PlateSection.plain, end: _Layout.faroePanelTop),
          PlatePart(
            PlateSection.fill(PlateFill.panel),
            end: _Layout.faroePanelBottom,
          ),
          PlatePart(PlateSection.plain),
        ]),
        end: _Layout.faroePanelRight,
      ),
      PlatePart(PlateSection.plain),
    ]),
    slots: _slots(_rowFields(_Layout.faroe, numberCount: 3)),
    textGroups: _groups(_rowFields(_Layout.faroe, numberCount: 3)),
  );

  /// Temporary export plate: the EU stripe, a red patch holding the year of
  /// validity (white on red), two digits and three digits.
  static final PlateSpec exportTemporary = () {
    final List<_Field> fields = <_Field>[
      _Field(
        'year',
        DenmarkAlphabets.digits,
        _Layout.yearCentre,
        _Layout.yearPitch,
        2,
        _Layout.yearInk,
        color: DenmarkColors.white,
      ),
      _Field(
        'mid',
        DenmarkAlphabets.digits,
        _Layout.exportPairCentre,
        _Layout.exportPitch,
        2,
        _Layout.exportInk,
      ),
      _Field(
        'number',
        DenmarkAlphabets.digits,
        _Layout.exportNumberCentre,
        _Layout.exportPitch,
        3,
        _Layout.exportInk,
      ),
    ];
    return PlateSpec(
      id: 'dk.exportTemporary',
      country: DenmarkCountry.denmark,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      panel: _Layout.euPanel,
      background: const PlateSection.columns(<PlatePart>[
        PlatePart(
          PlateSection.fill(PlateFill.panel),
          end: _Layout.exportPanelEnd,
        ),
        PlatePart(
          PlateSection.fill(PlateFill.color(DenmarkColors.hologram)),
          end: _Layout.exportHologramEnd,
        ),
        PlatePart(PlateSection.plain),
      ]),
      bands: const <PlateBand>[
        PlateBand(
          box: PlateBox(
            _Layout.yearLeft,
            35,
            _Layout.yearRight - _Layout.yearLeft,
            43,
          ),
          color: DenmarkColors.exportRed,
        ),
      ],
      slots: _slots(fields),
      textGroups: _groups(fields),
    );
  }();

  /// Vanity plate with the stripe: two to seven letters and digits.
  static final PlateSpec vanityEu = _vanity(
    id: 'dk.vanityEu',
    box: _Layout.vanityEu,
    stripe: true,
  );

  static final PlateSpec vanity = _vanity(
    id: 'dk.vanity',
    box: _Layout.vanityPlain,
  );

  static List<PlateSpec> get all => <PlateSpec>[
    privateEu,
    private,
    parrotEu,
    parrot,
    commercial,
    diplomatic,
    greenland,
    fixedTemporary,
    faroeIslands,
    exportTemporary,
    vanityEu,
    vanity,
  ];

  static List<_Field> _rowFields(_Row row, {int numberCount = 3}) => <_Field>[
    _Field('letters', _letters, row.letters, row.lettersPitch, 2, row.ink),
    if (row.mid != null)
      _Field(
        'mid',
        DenmarkAlphabets.digits,
        row.mid!,
        row.midPitch,
        2,
        row.ink,
      ),
    _Field(
      'number',
      DenmarkAlphabets.digits,
      row.number,
      row.numberPitch,
      numberCount,
      row.ink,
    ),
  ];

  static List<PlateSlot> _slots(List<_Field> fields) => <PlateSlot>[
    for (final _Field f in fields) f.slot,
  ];

  static List<PlateTextGroup> _groups(List<_Field> fields) =>
      PlateTextGroup.perSlot(<String?>[for (final f in fields) f.key]);

  /// The stripe columns shared by the EU plates: blue, then the hologram.
  static List<PlatePart> _stripe() => const <PlatePart>[
    PlatePart(PlateSection.fill(PlateFill.panel), end: _Layout.panelEnd),
    PlatePart(
      PlateSection.fill(PlateFill.color(DenmarkColors.hologram)),
      end: _Layout.hologramEnd,
    ),
  ];

  static PlateSpec _serial({
    required String id,
    required _Row row,
    bool stripe = false,
    double? yellowEnd,
    int numberCount = 3,
  }) {
    final List<_Field> fields = _rowFields(row, numberCount: numberCount);
    return PlateSpec(
      id: id,
      country: DenmarkCountry.denmark,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      panel: stripe ? _Layout.euPanel : PlatePanel.none,
      noPanel: !stripe,
      background: PlateSection.columns(<PlatePart>[
        if (stripe) ..._stripe(),
        if (yellowEnd != null) ...<PlatePart>[
          PlatePart(
            const PlateSection.fill(
              PlateFill.color(DenmarkColors.parrotYellow),
            ),
            end: yellowEnd,
          ),
        ],
        const PlatePart(PlateSection.plain),
      ]),
      slots: _slots(fields),
      textGroups: _groups(fields),
    );
  }

  static PlateSpec _vanity({
    required String id,
    required PlateBox box,
    bool stripe = false,
  }) => PlateSpec(
    id: id,
    country: DenmarkCountry.denmark,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    panel: stripe ? _Layout.euPanel : PlatePanel.none,
    noPanel: !stripe,
    background: PlateSection.columns(<PlatePart>[
      if (stripe) ..._stripe(),
      const PlatePart(PlateSection.plain),
    ]),
    slots: <PlateSlot>[
      PlateSlot(
        alphabet: DenmarkAlphabets.vanity,
        box: box,
        length: 7,
        minLength: 2,
        group: 'text',
      ),
    ],
  );
}
