import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'northern_cyprus_colors.dart';
import 'northern_cyprus_country.dart';

/// Measured off the 2018 artwork (2080×440 normalised to 520×110): the strip
/// runs 0–52 to the plate's edge; ink rows y 22.5–87 everywhere. Spans
/// (letters | digits): private 144–242 | 289–426, rental 120–268 | 314–452,
/// government 97–238 | 286–473, diplomatic 122–266 | 312–450. Visitor and
/// temporary spans are read off the montage, not measured. Ink is ~55% of the
/// box, so boxes use the full row; the strip's small emblem is not drawn.
abstract final class _Layout {
  static const double width = 520, height = 110, rowTop = 2, rowHeight = 106;
  static const double stripEnd = 52;
}

abstract final class NorthernCyprusPlates {
  static PlateSlot _slot(
    PlateAlphabet a,
    double left,
    double right,
    int length, {
    int? minLength,
  }) {
    final double pitch = (right - left) / length;
    return PlateSlot(
      alphabet: a,
      box: PlateBox(left, _Layout.rowTop, right - left, _Layout.rowHeight),
      length: length,
      minLength: minLength ?? length,
      spacing: length == 1 ? 0 : plateRunSpacing(pitch, _Layout.rowHeight),
    );
  }

  static PlateSpec _spec(
    String id,
    List<PlateSlot> slots,
    List<String> keys, {
    List<PlateLabel> labels = const <PlateLabel>[],
  }) => PlateSpec(
    id: id,
    country: NorthernCyprusCountry.northern_cyprus,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
    background: const PlateSection.columns(<PlatePart>[
      PlatePart(
        PlateSection.fill(PlateFill.color(NorthernCyprusColors.strip)),
        end: _Layout.stripEnd,
      ),
      PlatePart(PlateSection.plain),
    ]),
    slots: slots,
    labels: labels,
    textGroups: <PlateTextGroup>[
      for (var i = 0; i < keys.length; i++)
        PlateTextGroup(<int>[i], key: keys[i]),
    ],
  );

  static const PlateAlphabet _l = NorthernCyprusAlphabets.letters;
  static const PlateAlphabet _d = NorthernCyprusAlphabets.digits;

  static final PlateSpec private = _spec(
    'xn.private',
    <PlateSlot>[_slot(_l, 144, 242, 2), _slot(_d, 289, 426, 3, minLength: 1)],
    const <String>['letters', 'digits'],
  );

  static final PlateSpec rental = _spec(
    'xn.rental',
    <PlateSlot>[_slot(_l, 120, 268, 3), _slot(_d, 314, 452, 3, minLength: 1)],
    const <String>['letters', 'digits'],
  );

  static final PlateSpec government = _spec(
    'xn.government',
    <PlateSlot>[_slot(_l, 97, 238, 3), _slot(_d, 286, 473, 4, minLength: 1)],
    const <String>['letters', 'digits'],
  );

  static final PlateSpec visitor = _spec(
    'xn.visitor',
    <PlateSlot>[_slot(_l, 121, 220, 2), _slot(_d, 266, 450, 4, minLength: 1)],
    const <String>['letters', 'digits'],
  );

  static final PlateSpec temporary = _spec(
    'xn.temporary',
    <PlateSlot>[
      _slot(_l, 88, 190, 2),
      _slot(_d, 236, 412, 4, minLength: 1),
      _slot(_l, 448, 497, 1),
    ],
    const <String>['letters', 'digits', 'suffix'],
  );

  static final PlateSpec diplomatic = _spec(
    'xn.diplomatic',
    <PlateSlot>[_slot(_l, 122, 266, 2), _slot(_d, 312, 450, 3, minLength: 1)],
    const <String>['letters', 'digits'],
    labels: const <PlateLabel>[
      PlateLabel(text: 'CD', box: PlateBox(70, 6, 50, 30), glyphHeight: 34),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    rental,
    government,
    visitor,
    temporary,
    diplomatic,
  ];
}
