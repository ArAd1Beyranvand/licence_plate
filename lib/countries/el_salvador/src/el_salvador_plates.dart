import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'el_salvador_country.dart';

/// Where the ink sits, in plate units.
///
/// Both references are photographs flattened to 608×308 (`platekit`) and
/// projected onto each axis; fractions below are of that flat image.
///
/// Car (152×300 mm, the article's North American size; canvas 300×152):
/// caption `EL SALVADOR` y .13–.244, x .137–.617; serial y .273–.753
/// (cy .513), `P` x .155–.255, `0000` x .30–.842 (pitch ~36); `CENTRO AMERICA`
/// cap height ~.105, x .12–.804, cy .84.
///
/// Motorcycle: the article gives no size; the photo is 1.08 wide, so the canvas
/// is 300×278. Caption y .104–.23, x .097–.924; serial y .325–.64 (cy .48),
/// `M` cx .16, `7` cx .39, `845` cx .745; year `76` y .73–.845, cx .54.
///
/// The reference faces are condensed and tall: the car serial is ink .48 of the
/// height, but at that height DejaVu-width digits would be ~215 wide against
/// the photo's ~146. The box is capped at [digitBox] so the advance stays near
/// the printed pitch, giving ink ~58% of the reference height. Captions are
/// sized by width for the same reason. Each is a deliberate shortfall.
abstract final class _Layout {
  static const double width = 300, carHeight = 152, motoHeight = 278;

  static const double digitBox = 80, dashWidth = 24, letterWidth = 56;
  static const double digitAdvance = 0.696 * 0.72 * digitBox;

  // Car.
  static const double carCy = 78, carLetterCx = 61.5, carSerialCx = 177;
  static const double carDashCx = 90.5;

  // Motorcycle.
  static const double motoCy = 134, motoLetterCx = 48, motoSeriesCx = 118;
  static const double motoSerialCx = 224, motoDash1Cx = 77, motoDash2Cx = 148;
}

/// El Salvador's 1976 plates: a class letter, dashes and digits, black on tan.
/// Pair [private] with [ElSalvadorThemes.private] and [motorcycle] with
/// [ElSalvadorThemes.motorcycle].
///
/// Groups: `letter`, then `serial` (car) or `letter`, `series`, `serial`
/// (motorcycle). Not implemented: the 2011 design, which the article describes
/// with the flag in the background but shows no photo of, and so none was
/// measured. The article names no Israel-specific value.
abstract final class ElSalvadorPlates {
  static final PlateSpec private = _spec(
    'sv.private',
    _Layout.carHeight,
    slots: <PlateSlot>[
      _field(
        ElSalvadorAlphabets.letters,
        _Layout.carLetterCx,
        _Layout.carCy,
        1,
      ),
      _field(ElSalvadorAlphabets.digits, _Layout.carSerialCx, _Layout.carCy, 4),
    ],
    groups: const <String>['letter', 'serial'],
    labels: <PlateLabel>[
      _label('EL SALVADOR', 82, 29, 215, 26),
      _dash(_Layout.carDashCx, _Layout.carCy),
      _label('CENTRO AMERICA', 138.5, 128, 230, 28),
    ],
  );

  static final PlateSpec motorcycle = _spec(
    'sv.motorcycle',
    _Layout.motoHeight,
    slots: <PlateSlot>[
      _field(
        ElSalvadorAlphabets.letters,
        _Layout.motoLetterCx,
        _Layout.motoCy,
        1,
      ),
      _field(
        ElSalvadorAlphabets.digits,
        _Layout.motoSeriesCx,
        _Layout.motoCy,
        1,
      ),
      _field(
        ElSalvadorAlphabets.digits,
        _Layout.motoSerialCx,
        _Layout.motoCy,
        3,
      ),
    ],
    groups: const <String>['letter', 'series', 'serial'],
    labels: <PlateLabel>[
      _label('EL SALVADOR', 162, 46, 270, 44),
      _dash(_Layout.motoDash1Cx, _Layout.motoCy),
      _dash(_Layout.motoDash2Cx, _Layout.motoCy),
      _label('76', 163, 219, 80, 56),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[private, motorcycle];

  static PlateSlot _field(
    PlateAlphabet alphabet,
    double cx,
    double cy,
    int length,
  ) {
    final double w = alphabet == ElSalvadorAlphabets.letters
        ? _Layout.letterWidth
        : length * _Layout.digitAdvance;
    return PlateSlot(
      alphabet: alphabet,
      box: PlateBox.centered(cx, cy, w, _Layout.digitBox),
      length: length,
      spacing: plateRunSpacing(_Layout.digitAdvance, _Layout.digitBox),
    );
  }

  static PlateLabel _dash(double cx, double cy) =>
      _label('-', cx, cy, _Layout.dashWidth, _Layout.digitBox);

  static PlateLabel _label(
    String text,
    double cx,
    double cy,
    double w,
    double glyph,
  ) => PlateLabel(
    text: text,
    box: PlateBox.centered(cx, cy, w, glyph),
    glyphHeight: glyph,
  );

  static PlateSpec _spec(
    String id,
    double height, {
    required List<PlateSlot> slots,
    required List<String> groups,
    required List<PlateLabel> labels,
  }) => PlateSpec(
    id: id,
    country: ElSalvadorCountry.el_salvador,
    canvasWidth: _Layout.width,
    canvasHeight: height,
    slots: slots,
    labels: labels,
    textGroups: PlateTextGroup.perSlot(groups),
  );
}
