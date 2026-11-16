import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'iceland_colors.dart';
import 'iceland_country.dart';

/// Plate units measured off references flattened to 520×110. Stacked plates
/// use a 222×120 canvas (the photographs' 1.85 aspect, no size documented).
/// The engine's 0.55 ink ratio means a slot is taller than its ink: 104 for
/// single rows, and 62 for stacked rows, which may not leave the canvas.
abstract final class _Layout {
  static const double width = 520, height = 110, slotTop = 3, slotHeight = 104;

  static const double firstLeft = 80, firstWidth = 136;
  static const double secondLeft = 312, secondWidth = 178;

  static const double vanityLeft = 79, vanityWidth = 420;

  static const double flagLeft = 20, flagTop = 21;
  static const double flagWidth = 38, flagHeight = 27;
  static const double isLeft = 14, isTop = 58, isWidth = 52, isHeight = 30;
  static const double isGlyph = 46;

  // The diamond marking a VAT-free vehicle; `EM_U65` is cropped, so its size
  // and place in the lead space are estimated, not measured.
  static const double diamondLeft = 14, diamondTop = 30;
  static const double diamondWidth = 62, diamondHeight = 50;

  static const double stackedWidth = 222, stackedHeight = 120;
  static const double rowHeight = 62, row1Top = 5, row2Top = 58;
  static const double stackedFirstLeft = 63, stackedFirstWidth = 82;
  static const double stackedSecondLeft = 66, stackedSecondWidth = 128;
  static const double dashLeft = 163, dashWidth = 31;
}

/// Iceland's plate geometries. Fields: `letters` (two) and `serial` (three
/// characters); the vanity plate is the single field `serial`, two to six
/// characters. The inspection sticker between the fields is variable and left
/// blank.
abstract final class IcelandPlates {
  static final PlateSpec standard = _row(
    id: 'is.standard',
    decals: const <PlateDecal>[
      PlateDecal(
        drawing: IcelandCountry.flagDrawing,
        box: PlateBox(
          _Layout.flagLeft,
          _Layout.flagTop,
          _Layout.flagWidth,
          _Layout.flagHeight,
        ),
      ),
    ],
    labels: const <PlateLabel>[
      PlateLabel(
        text: 'IS',
        box: PlateBox(
          _Layout.isLeft,
          _Layout.isTop,
          _Layout.isWidth,
          _Layout.isHeight,
        ),
        glyphHeight: _Layout.isGlyph,
      ),
    ],
  );

  static final PlateSpec plain = _row(id: 'is.plain');

  static final PlateSpec commercial = _row(
    id: 'is.commercial',
    decals: const <PlateDecal>[
      PlateDecal(
        drawing: PlateDrawing(62, 50, <PlateShape>[
          PlatePolygonShape(<Offset>[
            Offset(31, 0),
            Offset(62, 25),
            Offset(31, 50),
            Offset(0, 25),
          ], IcelandColors.red),
        ]),
        box: PlateBox(
          _Layout.diamondLeft,
          _Layout.diamondTop,
          _Layout.diamondWidth,
          _Layout.diamondHeight,
        ),
      ),
    ],
  );

  static final PlateSpec diplomatic = _row(
    id: 'is.diplomatic',
    first: IcelandAlphabets.diplomaticPrefix,
  );

  static final PlateSpec temporary = _row(
    id: 'is.temporary',
    first: IcelandAlphabets.dealerPrefix,
    second: IcelandAlphabets.digits,
  );

  static final PlateSpec vanity = _spec(
    id: 'is.vanity',
    width: _Layout.width,
    height: _Layout.height,
    slots: const <PlateSlot>[
      PlateSlot(
        alphabet: IcelandAlphabets.vanity,
        box: PlateBox(
          _Layout.vanityLeft,
          _Layout.slotTop,
          _Layout.vanityWidth,
          _Layout.slotHeight,
        ),
        length: 6,
        minLength: 2,
      ),
    ],
    groups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'serial'),
    ],
  );

  /// Moped and off-road: `AB-` over `C12`.
  static final PlateSpec stacked = _spec(
    id: 'is.stacked',
    width: _Layout.stackedWidth,
    height: _Layout.stackedHeight,
    slots: <PlateSlot>[
      _field(
        IcelandAlphabets.letters,
        2,
        left: _Layout.stackedFirstLeft,
        width: _Layout.stackedFirstWidth,
        top: _Layout.row1Top,
        height: _Layout.rowHeight,
      ),
      _field(
        IcelandAlphabets.serial,
        3,
        left: _Layout.stackedSecondLeft,
        width: _Layout.stackedSecondWidth,
        top: _Layout.row2Top,
        height: _Layout.rowHeight,
      ),
    ],
    labels: const <PlateLabel>[
      PlateLabel(
        text: '-',
        box: PlateBox(
          _Layout.dashLeft,
          _Layout.row1Top,
          _Layout.dashWidth,
          _Layout.rowHeight,
        ),
        glyphHeight: _Layout.rowHeight,
      ),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[
    standard,
    plain,
    commercial,
    diplomatic,
    temporary,
    vanity,
    stacked,
  ];

  static const List<PlateTextGroup> _groups = <PlateTextGroup>[
    PlateTextGroup(<int>[0], key: 'letters'),
    PlateTextGroup(<int>[1], key: 'serial'),
  ];

  static PlateSlot _field(
    PlateAlphabet alphabet,
    int count, {
    required double left,
    required double width,
    required double top,
    required double height,
  }) => plateRun(
    alphabet,
    count,
    left: left,
    top: top,
    pitch: width / count,
    height: height,
  );

  static PlateSpec _spec({
    required String id,
    required double width,
    required double height,
    required List<PlateSlot> slots,
    List<PlateTextGroup> groups = _groups,
    List<PlateDecal> decals = const <PlateDecal>[],
    List<PlateLabel> labels = const <PlateLabel>[],
  }) => PlateSpec(
    id: id,
    country: IcelandCountry.iceland,
    canvasWidth: width,
    canvasHeight: height,
    noPanel: true,
    panel: PlatePanel(box: PlateBox(0, 0, 0, height)),
    slots: slots,
    decals: decals,
    labels: labels,
    textGroups: groups,
  );

  static PlateSpec _row({
    required String id,
    PlateAlphabet first = IcelandAlphabets.letters,
    PlateAlphabet second = IcelandAlphabets.serial,
    List<PlateDecal> decals = const <PlateDecal>[],
    List<PlateLabel> labels = const <PlateLabel>[],
  }) => _spec(
    id: id,
    width: _Layout.width,
    height: _Layout.height,
    slots: <PlateSlot>[
      _field(
        first,
        2,
        left: _Layout.firstLeft,
        width: _Layout.firstWidth,
        top: _Layout.slotTop,
        height: _Layout.slotHeight,
      ),
      _field(
        second,
        3,
        left: _Layout.secondLeft,
        width: _Layout.secondWidth,
        top: _Layout.slotTop,
        height: _Layout.slotHeight,
      ),
    ],
    decals: decals,
    labels: labels,
  );
}
