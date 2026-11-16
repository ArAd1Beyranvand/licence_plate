import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'mexico_colors.dart';
import 'mexico_country.dart';
import 'mexico_themes.dart';

/// Where the ink sits on a Mexican plate, in millimetres.
///
/// The article gives 300 × 150 mm (12 × 6 in), which is the canvas; every
/// reference photograph was fitted to a quadrilateral and flattened onto it
/// by `platekit`, and the numbers below are read off those flats
/// (`.plateref/mx/brief.md`).
///
/// * Standard serial row (Chiapas, Veracruz, Oaxaca, Puebla, Tabasco…): ink
///   y 39..103, x 12..288 (Chiapas 20.8..278.8 of nine glyphs, dashes
///   counted). The dashes take a cell like a character, so the row is
///   `cells` equal pitches; the pitch is 276 / 9 = 30.7.
/// * Federal tourism (`847RB5`): ink y 10.5..103, six cells at pitch 46.
/// * 1992 series (`SLC8377`): ink y 27.8..96, x 27.2..277.2, seven cells.
/// * State name row: ink y 108..139 on every plate that prints it below the
///   serial; `TRANSPORTE PRIVADO AUTOMÓVIL` under it, ink ~6 tall.
/// * Yucatán: band y 0..41.5 (`49834D`), serial ink 47.2..110.8.
///
/// **Estimated, not measured.** The dash is 7 thick and 0.6 of a cell wide,
/// centred 1 below the row's centre, by eye; no brief row isolates it. San
/// Luis Potosí, Chihuahua and Morelos (2013) were not measured by the script:
/// they share the standard row, checked by eye against their originals.
///
/// **Under-height ink, accepted.** Mexican plates are stamped in a condensed
/// face; a slot scales its run to its box and DejaVu Bold is far wider, so the
/// serial is width-limited well below the 64 mm reference ink.
///
/// **Not drawn.** The state crests and artwork behind the serial, barcodes,
/// stickers and holograms, the front/rear legends, the screw holes; and the
/// coloured bottom bands of Jalisco, Puebla, Quintana Roo and Michoacán,
/// whose colours the offline stage did not sample. Every plate prints the
/// state name in the bottom row here, though on Jalisco, Chihuahua and a few
/// others it is printed above the serial.
abstract final class _Layout {
  static const double width = 300, height = 150;

  static const double left = 12, right = 288, serialCentre = 73;
  static const double serialHeight = 116;

  static const double dashThickness = 7, dashFill = 0.6, dashDrop = 1;

  static const double band = 41.5, bandSerialCentre = 79;

  static const double tourismCentre = 57, tourismHeight = 110;

  static const double legacyLeft = 27.2, legacyRight = 277.2, legacyCentre = 62;
  static const double legacyHeight = 120;

  static const PlateBox name = PlateBox(20, 106, 260, 32);
  static const double nameGlyph = 34;

  /// The most name characters that fit at [nameGlyph]; longer names shrink in
  /// proportion (`ESTADO DE MÉXICO` is sixteen).
  static const int nameFit = 14;
  static const PlateBox caption = PlateBox(30, 138, 240, 11);
  static const double captionGlyph = 11;
  static const String captionText = 'TRANSPORTE PRIVADO AUTOMÓVIL';

  static const PlateBox top = PlateBox(60, 6, 180, 30);
  static const double topGlyph = 26;

  static const PlateBox legacyName = PlateBox(60, 100, 180, 32);
  static const double legacyNameGlyph = 30;
  static const PlateBox tourismName = PlateBox(30, 108, 240, 34);
  static const double tourismNameGlyph = 34;
}

/// A run of letters or digits printed and typed as a unit.
@immutable
class MexicoField {
  const MexicoField.letters(this.length) : letters = true;
  const MexicoField.digits(this.length) : letters = false;

  final bool letters;
  final int length;
}

/// The shape of a serial: its fields, and where a dash is printed between
/// them. [dashes] has one entry per boundary, so `fields.length - 1`.
@immutable
class MexicoFormat {
  const MexicoFormat({
    required this.id,
    required this.fields,
    required this.dashes,
  });

  final String id;
  final List<MexicoField> fields;
  final List<bool> dashes;

  int get characters => fields.fold(0, (int n, MexicoField f) => n + f.length);

  /// Equal pitches the row is divided into: a dash takes a cell.
  int get cells => characters + dashes.where((bool d) => d).length;

  /// `ABC-12-34`, `AB-1234-A`, `123-ABC`: the state private-car series.
  static const MexicoFormat letters3Digits2Digits2 = MexicoFormat(
    id: 'aaa-dd-dd',
    fields: <MexicoField>[
      MexicoField.letters(3),
      MexicoField.digits(2),
      MexicoField.digits(2),
    ],
    dashes: <bool>[true, true],
  );
  static const MexicoFormat letters2Digits2Digits3 = MexicoFormat(
    id: 'aa-dd-ddd',
    fields: <MexicoField>[
      MexicoField.letters(2),
      MexicoField.digits(2),
      MexicoField.digits(3),
    ],
    dashes: <bool>[true, true],
  );
  static const MexicoFormat letters3Digits3Letter1 = MexicoFormat(
    id: 'aaa-ddd-a',
    fields: <MexicoField>[
      MexicoField.letters(3),
      MexicoField.digits(3),
      MexicoField.letters(1),
    ],
    dashes: <bool>[true, true],
  );
  static const MexicoFormat letters2Digits4Letter1 = MexicoFormat(
    id: 'aa-dddd-a',
    fields: <MexicoField>[
      MexicoField.letters(2),
      MexicoField.digits(4),
      MexicoField.letters(1),
    ],
    dashes: <bool>[true, true],
  );
  static const MexicoFormat digits2Digits2Letters3 = MexicoFormat(
    id: 'dd-dd-aaa',
    fields: <MexicoField>[
      MexicoField.digits(2),
      MexicoField.digits(2),
      MexicoField.letters(3),
    ],
    dashes: <bool>[true, true],
  );

  /// Mexico City: `477-PNK`. Letters I, O and Q are not issued.
  static const MexicoFormat digits3Letters3 = MexicoFormat(
    id: 'ddd-aaa',
    fields: <MexicoField>[MexicoField.digits(3), MexicoField.letters(3)],
    dashes: <bool>[true],
  );

  /// Federal tourism (SPF), `847RB5`: no dash.
  static const MexicoFormat tourism = MexicoFormat(
    id: 'ddd-aa-d',
    fields: <MexicoField>[
      MexicoField.digits(3),
      MexicoField.letters(2),
      MexicoField.digits(1),
    ],
    dashes: <bool>[false, false],
  );

  /// Morelos antique, `3NE-88`: the first three characters run together.
  static const MexicoFormat antique = MexicoFormat(
    id: 'd-aa-dd',
    fields: <MexicoField>[
      MexicoField.digits(1),
      MexicoField.letters(2),
      MexicoField.digits(2),
    ],
    dashes: <bool>[false, true],
  );

  /// The 1992 series, `SLC8377`: three letters then four digits, no dash.
  static const MexicoFormat legacy = MexicoFormat(
    id: 'aaa-dddd',
    fields: <MexicoField>[MexicoField.letters(3), MexicoField.digits(4)],
    dashes: <bool>[false],
  );
}

const PlatePanel _noPanel = PlatePanel(box: PlateBox(0, 0, 0, _Layout.height));

/// The keys of a format's text groups, in field order.
const List<String> mexicoFieldKeys = <String>['first', 'second', 'third'];

abstract final class MexicoPlates {
  /// One serial row: a slot per field and a rule per printed dash, laid on
  /// [cells] equal pitches between [left] and [right].
  static ({List<PlateSlot> slots, List<PlateRule> rules}) _row(
    MexicoFormat format, {
    required double left,
    required double right,
    required double centre,
    required double height,
  }) {
    final double pitch = (right - left) / format.cells;
    final slots = <PlateSlot>[];
    final rules = <PlateRule>[];
    int cell = 0;
    for (int i = 0; i < format.fields.length; i++) {
      final MexicoField field = format.fields[i];
      slots.add(
        plateRun(
          field.letters ? MexicoAlphabets.letters : MexicoAlphabets.digits,
          field.length,
          left: left + cell * pitch,
          top: centre - height / 2,
          pitch: pitch,
          height: height,
        ),
      );
      cell += field.length;
      if (i < format.dashes.length && format.dashes[i]) {
        rules.add(
          PlateRule(
            box: PlateBox(
              left + cell * pitch + pitch * (1 - _Layout.dashFill) / 2,
              centre + _Layout.dashDrop - _Layout.dashThickness / 2,
              pitch * _Layout.dashFill,
              _Layout.dashThickness,
            ),
          ),
        );
        cell++;
      }
    }
    return (slots: slots, rules: rules);
  }

  static List<PlateTextGroup> _groups(MexicoFormat format) => <PlateTextGroup>[
    for (int i = 0; i < format.fields.length; i++)
      PlateTextGroup(
        <int>[i],
        prefix: i > 0 && format.dashes[i - 1] ? '-' : '',
        key: mexicoFieldKeys[i],
      ),
  ];

  static PlateLabel _name(String name) => PlateLabel(
    text: name,
    box: _Layout.name,
    glyphHeight:
        _Layout.nameGlyph * min<double>(1, _Layout.nameFit / name.length),
  );

  /// A state's private-car plate: the serial row, the state's name under it
  /// and `TRANSPORTE PRIVADO AUTOMÓVIL` under that.
  ///
  /// [top] is the state's name printed in a coloured band across the top, as
  /// Yucatán's is; the serial row then sits lower.
  static PlateSpec _state({
    required String id,
    String? name,
    List<String>? states,
    MexicoFormat format = MexicoFormat.letters3Digits2Digits2,
    String? top,
    Color? topColor,
    Color? topText,
  }) {
    final row = _row(
      format,
      left: _Layout.left,
      right: _Layout.right,
      centre: top == null ? _Layout.serialCentre : _Layout.bandSerialCentre,
      height: _Layout.serialHeight,
    );
    return PlateSpec(
      id: 'mx.$id',
      country: MexicoCountry.mexico,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      noPanel: true,
      panel: _noPanel,
      background: top == null
          ? PlateSection.plain
          : PlateSection.rows(<PlatePart>[
              PlatePart(
                PlateSection.fill(PlateFill.color(topColor!)),
                end: _Layout.band,
              ),
              const PlatePart(PlateSection.plain),
            ]),
      rules: row.rules,
      labels: <PlateLabel>[
        if (top != null)
          PlateLabel(
            text: top,
            box: _Layout.top,
            glyphHeight: _Layout.topGlyph,
            color: topText,
          ),
        if (name != null) _name(name),
        const PlateLabel(
          text: _Layout.captionText,
          box: _Layout.caption,
          glyphHeight: _Layout.captionGlyph,
        ),
      ],
      slots: <PlateSlot>[
        ...row.slots,
        if (states != null)
          PlateSlot(alphabet: MexicoThemes.states(states), box: _Layout.name),
      ],
      textGroups: <PlateTextGroup>[
        ..._groups(format),
        if (states != null)
          PlateTextGroup(<int>[format.fields.length], key: 'state'),
      ],
      resolveTheme: states == null ? null : MexicoThemes.byState,
    );
  }

  /// `ABC-12-34`. Values are [first, second, third, state]; the state is
  /// printed in the name row and picks the livery.
  static final PlateSpec standard = _state(
    id: 'state',
    states: <String>[
      'BAJA CALIFORNIA',
      'CAMPECHE',
      'CHIAPAS',
      'CHIHUAHUA',
      'GUERRERO',
      'JALISCO',
      'MICHOACÁN',
      'MORELOS',
      'OAXACA',
      'PUEBLA',
      'QUERÉTARO',
      'SAN LUIS POTOSÍ',
      'SONORA',
      'ESTADO DE MÉXICO',
      'TABASCO',
      'VERACRUZ',
    ],
  );

  /// `AB-12-345`.
  static final PlateSpec twoLetters = _state(
    id: 'state_aa',
    states: <String>['COAHUILA', 'ZACATECAS'],
    format: MexicoFormat.letters2Digits2Digits3,
  );

  /// `ABC-123-A`, except Yucatán's banded plate.
  static final PlateSpec threeDigits = _state(
    id: 'state_aaa_a',
    states: <String>['NUEVO LEÓN', 'QUINTANA ROO'],
    format: MexicoFormat.letters3Digits3Letter1,
  );

  static final PlateSpec bajaCaliforniaSur = _state(
    id: 'bcs',
    name: 'BAJA CALIFORNIA SUR',
    format: MexicoFormat.digits2Digits2Letters3,
  );
  static final PlateSpec mexicoCity = _state(
    id: 'cdmx',
    name: 'DISTRITO FEDERAL',
    format: MexicoFormat.digits3Letters3,
  );
  static final PlateSpec sinaloa = _state(
    id: 'sin',
    name: 'SINALOA',
    format: MexicoFormat.letters2Digits4Letter1,
  );
  static final PlateSpec yucatan = _state(
    id: 'yuc',
    name: 'YUCATAN',
    format: MexicoFormat.letters3Digits3Letter1,
    top: 'Yucatán',
    topColor: MexicoColors.yucatanBand,
    topText: MexicoColors.white,
  );

  /// Federal tourism service (SPF Turismo), `847RB5`: the serial fills the
  /// top and `SPF TURISMO MEX` runs under it.
  static final PlateSpec tourism = () {
    final row = _row(
      MexicoFormat.tourism,
      left: _Layout.left,
      right: _Layout.right,
      centre: _Layout.tourismCentre,
      height: _Layout.tourismHeight,
    );
    return PlateSpec(
      id: 'mx.spf',
      country: MexicoCountry.mexico,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      noPanel: true,
      panel: _noPanel,
      rules: row.rules,
      labels: const <PlateLabel>[
        PlateLabel(
          text: 'SPF TURISMO MEX',
          box: _Layout.tourismName,
          glyphHeight: _Layout.tourismNameGlyph,
        ),
      ],
      slots: row.slots,
      textGroups: _groups(MexicoFormat.tourism),
    );
  }();

  /// Morelos antique car (`Auto Antiguo`), `3NE-88`.
  static final PlateSpec antique = _state(
    id: 'antique',
    name: 'AUTO ANTIGUO',
    format: MexicoFormat.antique,
  );

  /// The 1992 national series, `SLC8377`, with the state code and `MEX`
  /// beneath. Green on white inside a heavy rim. The state is a code in the
  /// design, so it is a fixed label here, not a name.
  static final PlateSpec legacy = () {
    final row = _row(
      MexicoFormat.legacy,
      left: _Layout.legacyLeft,
      right: _Layout.legacyRight,
      centre: _Layout.legacyCentre,
      height: _Layout.legacyHeight,
    );
    return PlateSpec(
      id: 'mx.1992',
      country: MexicoCountry.mexico,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      noPanel: true,
      panel: _noPanel,
      rules: row.rules,
      labels: const <PlateLabel>[
        PlateLabel(
          text: 'CHIH MEX',
          box: _Layout.legacyName,
          glyphHeight: _Layout.legacyNameGlyph,
        ),
      ],
      slots: row.slots,
      textGroups: _groups(MexicoFormat.legacy),
    );
  }();

  /// Every plate, for hosts and tests that walk them.
  static final List<PlateSpec> all = <PlateSpec>[
    standard,
    twoLetters,
    threeDigits,
    bajaCaliforniaSur,
    mexicoCity,
    sinaloa,
    yucatan,
    tourism,
    antique,
    legacy,
  ];
}
