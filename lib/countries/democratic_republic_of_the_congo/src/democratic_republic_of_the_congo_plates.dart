import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'democratic_republic_of_the_congo_colors.dart';
import 'democratic_republic_of_the_congo_country.dart';
import 'democratic_republic_of_the_congo_regions.dart';

typedef _Alphabets = DemocraticRepublicOfTheCongoAlphabets;

/// Plate units (520×110) measured off the flattened artwork
/// `Plaque_d_immatriculation_en_RD_du_Congo` (4 px per unit): digit ink y
/// 15.2–95 (80 tall, so the 100-unit slot box is the most a 110 plate holds);
/// digits centred 90.5, 146, 198, 253 (pitch ~54); letters 311.4, 369.2
/// (pitch 57.8); province digits 436.5, 489 (pitch 52.6). The flag is x 11–57,
/// y 22–56 and "CGO" ink x 10.5–60.5, y 72–95.
///
/// The other designs were NOT measured: their photographs sit inside a wide
/// scene and the flattening distorted them, so their ink height (~62 units on
/// 110), field order and the dot between fields are read off the pictures and
/// the glyph advance (0.6 × 0.72 × box) places the runs, centred on the plate.
abstract final class _Layout {
  static const double width = 520, height = 110;

  static const double cy = 55.1, box = 100;
  static const PlateBox flag = PlateBox(11, 22, 46, 34);
  static const PlateBox cgo = PlateBox(8, 63.5, 55, 40);
  static const double cgoGlyph = 38;
  static const PlateBox hologram = PlateBox(400.5, 6, 9.5, 99);

  static const double lineBox = 86, fardcBox = 70;

  static const double unWidth = 300, unHeight = 250, unBox = 104;
  static const double unTop = 12, unBottom = 128;
}

/// A run in a one-line plate: a typed field or fixed printed text.
class _Run {
  const _Run.field(this.alphabet, this.length, {int? minLength})
    : minLength = minLength ?? length,
      text = null;
  const _Run.text(String this.text)
    : alphabet = null,
      length = 0,
      minLength = 0;

  final PlateAlphabet? alphabet;
  final int length, minLength;
  final String? text;

  int get chars => text?.length ?? length;
}

/// The plates of the Democratic Republic of the Congo.
///
/// Designs: [private] (flag, `1234 AB 10`, hologram strip), one dotted
/// one-line builder for the [organisation], [fardc], [police] and
/// [diplomatic] plates, and the two-line [unitedNations] plate.
///
/// Not implemented: the older provincial series, EUSEC/EUPOL (yellow on dark
/// blue) and the governmental plates (PR, AA, ASEN, ADJ), for which no
/// reference picture exists; the FARDC badge on the right is not drawn.
/// The article says FARDC takes seven digits; the picture shows `767.05.18`,
/// and the picture wins.
abstract final class DemocraticRepublicOfTheCongoPlates {
  static final PlateSpec private = _private();

  /// `045.IT.015`: three digits naming the organisation, IT, three digits.
  static final PlateSpec organisation = _dotted(
    'cd.organisation',
    const <_Run>[
      _Run.field(_Alphabets.digits, 3),
      _Run.text('IT'),
      _Run.field(_Alphabets.digits, 3),
    ],
    keys: const <String?>['organisation', null, 'number'],
  );

  /// `FARDC 767.05.18`.
  static final PlateSpec fardc = _dotted(
    'cd.fardc',
    const <_Run>[
      _Run.text('FARDC'),
      _Run.field(_Alphabets.digits, 3),
      _Run.field(_Alphabets.digits, 2),
      _Run.field(_Alphabets.digits, 2),
    ],
    keys: const <String?>[null, 'unit', 'series', 'number'],
    box: _Layout.fardcBox,
    dotAfter: 1,
  );

  /// `PNC 01.0049`, the initials stacked at the left.
  static final PlateSpec police = _dotted(
    'cd.police',
    const <_Run>[
      _Run.field(_Alphabets.digits, 2),
      _Run.field(_Alphabets.digits, 4),
    ],
    keys: const <String?>['province', 'number'],
    leftInset: 70,
    stacked: 'P\nN\nC',
  );

  /// `013.CD.213`: country code, CD (or CC for the consular corps), 2 or 3
  /// digits.
  static final PlateSpec diplomatic = _dotted(
    'cd.diplomatic',
    const <_Run>[
      _Run.field(_Alphabets.digits, 3),
      _Run.field(_Alphabets.letters, 2),
      _Run.field(_Alphabets.digits, 3, minLength: 2),
    ],
    keys: const <String?>['country', 'mark', 'number'],
  );

  /// `UN` over five digits.
  static final PlateSpec unitedNations = _unitedNations();

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    organisation,
    fardc,
    police,
    diplomatic,
    unitedNations,
  ];

  /// A fixed field of [length] characters centred on [cx], spaced to the
  /// printed [pitch].
  static PlateSlot _field(
    PlateAlphabet alphabet,
    int length,
    double cx,
    double pitch,
    double top,
    double height, {
    int? minLength,
    double? spacingPitch,
  }) => PlateSlot(
    alphabet: alphabet,
    box: PlateBox(cx - length * pitch / 2, top, length * pitch, height),
    length: length,
    minLength: minLength,
    spacing: minLength == null
        ? plateRunSpacing((spacingPitch ?? pitch), height)
        : 0,
  );

  static PlateSpec _private() => PlateSpec(
    id: 'cd.private',
    country:
        DemocraticRepublicOfTheCongoCountry.democratic_republic_of_the_congo,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    bands: const <PlateBand>[
      PlateBand(
        box: _Layout.hologram,
        color: DemocraticRepublicOfTheCongoColors.hologram,
      ),
    ],
    slots: <PlateSlot>[
      _field(
        _Alphabets.digits,
        4,
        144.5,
        54,
        _Layout.cy - _Layout.box / 2,
        _Layout.box,
      ),
      _field(
        _Alphabets.letters,
        2,
        340.3,
        57.8,
        _Layout.cy - _Layout.box / 2,
        _Layout.box,
      ),
      _field(
        _Alphabets.digits,
        2,
        462.8,
        52.6,
        _Layout.cy - _Layout.box / 2,
        _Layout.box,
      ),
    ],
    textGroups: PlateTextGroup.perSlot(<String>[
      'number',
      'series',
      'province',
    ]),
    resolveRegion: DemocraticRepublicOfTheCongoRegions.captionOf,
    decals: const <PlateDecal>[
      PlateDecal(
        drawing: DemocraticRepublicOfTheCongoCountry.flagDrawing,
        box: _Layout.flag,
      ),
    ],
    labels: const <PlateLabel>[
      PlateLabel(text: 'CGO', box: _Layout.cgo, glyphHeight: _Layout.cgoGlyph),
    ],
  );

  /// One line of [runs] centred on the plate (shifted right by [leftInset]),
  /// a dot between runs except where [dotAfter] says the gap is a space.
  static PlateSpec _dotted(
    String id,
    List<_Run> runs, {
    required List<String?> keys,
    double box = _Layout.lineBox,
    double leftInset = 0,
    String? stacked,
    int? dotAfter,
  }) {
    final double advance = 0.6 * 0.72 * box, gap = advance;
    final double top = _Layout.cy - box / 2;
    final double total =
        runs.fold<double>(0, (double sum, _Run r) => sum + r.chars * advance) +
        (runs.length - 1) * gap;
    double x = (_Layout.width + leftInset - total) / 2;
    final List<PlateSlot> slots = <PlateSlot>[];
    final List<PlateTextGroup> groups = <PlateTextGroup>[];
    final List<PlateLabel> labels = <PlateLabel>[];
    for (int i = 0; i < runs.length; i++) {
      final _Run run = runs[i];
      final double w = run.chars * advance;
      if (run.text != null) {
        labels.add(
          PlateLabel(
            text: run.text!,
            box: PlateBox(x, top, w, box),
            glyphHeight: box,
          ),
        );
      } else {
        slots.add(
          PlateSlot(
            alphabet: run.alphabet!,
            box: PlateBox(x, top, w, box),
            length: run.length,
            minLength: run.minLength == run.length ? null : run.minLength,
          ),
        );
        groups.add(PlateTextGroup(<int>[slots.length - 1], key: keys[i]));
      }
      x += w;
      if (i < runs.length - 1) {
        if (dotAfter != i) {
          labels.add(
            PlateLabel(
              text: '.',
              box: PlateBox(x, top, gap, box),
              glyphHeight: box,
            ),
          );
        }
        x += gap;
      }
    }
    if (stacked != null) {
      labels.add(
        PlateLabel(
          text: stacked,
          box: const PlateBox(20, 8, 40, 94),
          glyphHeight: 30,
          lineHeight: 1,
        ),
      );
    }
    return PlateSpec(
      id: id,
      country:
          DemocraticRepublicOfTheCongoCountry.democratic_republic_of_the_congo,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      slots: slots,
      textGroups: groups,
      labels: labels,
    );
  }

  static PlateSpec _unitedNations() => PlateSpec(
    id: 'cd.united_nations',
    country:
        DemocraticRepublicOfTheCongoCountry.democratic_republic_of_the_congo,
    canvasWidth: _Layout.unWidth,
    canvasHeight: _Layout.unHeight,
    slots: <PlateSlot>[
      _field(
        _Alphabets.letters,
        2,
        _Layout.unWidth / 2,
        0.6 * 0.72 * _Layout.unBox * 1.1,
        _Layout.unTop,
        _Layout.unBox,
      ),
      _field(
        _Alphabets.digits,
        5,
        _Layout.unWidth / 2,
        0.6 * 0.72 * _Layout.unBox,
        _Layout.unBottom,
        _Layout.unBox,
      ),
    ],
    textGroups: PlateTextGroup.perSlot(<String>['prefix', 'number']),
  );
}
