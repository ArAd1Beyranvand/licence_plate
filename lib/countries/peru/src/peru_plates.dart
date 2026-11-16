import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'peru_colors.dart';
import 'peru_country.dart';

/// Where the ink sits, in plate units.
///
/// The article gives 6 × 12 in (150 × 300 mm), so the canvas is 520 × 260,
/// the size the flattened photographs were normalised to. The fields come from
/// those photographs (trailer, small motorcycle, emergency, exhibition,
/// temporary: ink projected onto each axis); the header band, flag and sticker
/// from the clean artwork and the same photographs.
///
/// Serial row: ink y 111–200 (89 tall, cy 155.5). A box that tall would be
/// ~162, so the box is 150 and the ink lands near 83, about 93% of reference.
/// Roboto is also narrower than the plate's face, so a run keeps its measured
/// pitch through `spacing`, not through glyph width.
///
/// Regular: letters 20.8–265 (pitch 85), dash 279–311, digits 322–499
/// (pitch 59.5). Motorcycle: letters 21–186 (pitch 93.6), dash 200–231,
/// digits 242–496 (pitch 66). Special: `E` ink 24–68 × 141–201.5 (60 tall,
/// baseline with the serial), letters 106.5–270 (pitch 80), then the regular
/// dash and digits.
///
/// Header: PERU ink x 181–335, y 22–67 (45 tall, cy 44.5). Flag
/// x 18–112, y 20–69 (mean of three photographs). Sticker x 404–500,
/// y 20–67. Header band ends at y 78 (the artwork's colour change).
abstract final class _Layout {
  static const double width = 520, height = 260, headerEnd = 78;

  static const double serialTop = 80.5, serialBox = 150;

  static const double registerLeft = 20.8, registerWidth = 245;
  static const double registerPitch = 85, digitsLeft = 322, digitsWidth = 177;
  static const double digitsPitch = 59.5, dashLeft = 270, dashWidth = 50;

  static const double motoRegisterLeft = 21, motoRegisterWidth = 168;
  static const double motoRegisterPitch = 93.6;
  static const double motoDigitsLeft = 242, motoDigitsWidth = 255;
  static const double motoDigitsPitch = 66;
  static const double motoDashLeft = 187, motoDashWidth = 62;

  static const double specialRegisterLeft = 104, specialRegisterWidth = 168;
  static const double specialRegisterPitch = 80;

  static const PlateBox letterE = PlateBox(22, 141, 48, 60);
  static const double letterEGlyph = 109;

  static const PlateBox peru = PlateBox(181, 22, 154, 45);
  static const double peruGlyph = 82;

  static const PlateBox flag = PlateBox(18, 20, 94, 49);
  static const PlateBox sticker = PlateBox(404, 20, 96, 47);
  static const double stickerGlyph = 18;

  static const PlateBox microSerial = PlateBox(22, 229, 66, 14.5);
  static const double microSerialGlyph = 22;
}

/// The 2010 Peruvian plates, three layouts under a shared header: the word
/// PERU, the flag without the shield, a holographic label at the top right and
/// a laser-engraved serial at the bottom left. Every category is a layout
/// paired with a [PeruThemes] colourway; groups `register` and `serial`.
///
/// - [regular] `ABC-123` (also `AB1-234`, `A1B-234`): automobile, city bus
///   (A1B only, numbers 700–799), interprovincial bus (950–969), taxi
///   (600–699), truck, trailer.
/// - [motorcycle] `AB-1234`: small (numbers 0000–5999) and large (6000–9999).
/// - [special] `E UA-123`: the printed `E` then a two-letter series — diplomatic
///   (CC, CD, MI, TA), emergency (UA), exhibition (EX), government (GA), police
///   (PA), temporary (ZA), used imported (RM).
///
/// Not implemented: the 1963, 1966, 1994 and 1995–2009 series, and the 2018
/// papal-visit plates, for which only a one-off event plate was shown. The
/// article names no Israel-specific value.
abstract final class PeruPlates {
  static final PlateSpec regular = _spec(
    'pe.regular',
    register: _field(
      PeruAlphabets.alphanumeric,
      3,
      _Layout.registerLeft,
      _Layout.registerWidth,
      _Layout.registerPitch,
    ),
    serial: _field(
      PeruAlphabets.digits,
      3,
      _Layout.digitsLeft,
      _Layout.digitsWidth,
      _Layout.digitsPitch,
    ),
    dash: const PlateBox(
      _Layout.dashLeft,
      _Layout.serialTop,
      _Layout.dashWidth,
      _Layout.serialBox,
    ),
  );

  static final PlateSpec motorcycle = _spec(
    'pe.motorcycle',
    register: _field(
      PeruAlphabets.alphanumeric,
      2,
      _Layout.motoRegisterLeft,
      _Layout.motoRegisterWidth,
      _Layout.motoRegisterPitch,
    ),
    serial: _field(
      PeruAlphabets.digits,
      4,
      _Layout.motoDigitsLeft,
      _Layout.motoDigitsWidth,
      _Layout.motoDigitsPitch,
    ),
    dash: const PlateBox(
      _Layout.motoDashLeft,
      _Layout.serialTop,
      _Layout.motoDashWidth,
      _Layout.serialBox,
    ),
  );

  static final PlateSpec special = _spec(
    'pe.special',
    register: _field(
      PeruAlphabets.letters,
      2,
      _Layout.specialRegisterLeft,
      _Layout.specialRegisterWidth,
      _Layout.specialRegisterPitch,
    ),
    serial: _field(
      PeruAlphabets.digits,
      3,
      _Layout.digitsLeft,
      _Layout.digitsWidth,
      _Layout.digitsPitch,
    ),
    dash: const PlateBox(
      _Layout.dashLeft,
      _Layout.serialTop,
      _Layout.dashWidth,
      _Layout.serialBox,
    ),
    special: true,
  );

  static List<PlateSpec> get all => <PlateSpec>[regular, motorcycle, special];

  /// One field: a run printed and typed as a unit, one slot.
  static PlateSlot _field(
    PlateAlphabet alphabet,
    int length,
    double left,
    double width,
    double pitch,
  ) => PlateSlot(
    alphabet: alphabet,
    box: PlateBox(left, _Layout.serialTop, width, _Layout.serialBox),
    length: length,
    spacing: plateRunSpacing(pitch, _Layout.serialBox),
  );

  static PlateSpec _spec(
    String id, {
    required PlateSlot register,
    required PlateSlot serial,
    required PlateBox dash,
    bool special = false,
  }) => PlateSpec(
    id: id,
    country: PeruCountry.peru,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    // Header band above y 78 in the theme's divider colour, body below.
    background: const PlateSection.rows(<PlatePart>[
      PlatePart(PlateSection.fill(PlateFill.divider), end: _Layout.headerEnd),
      PlatePart(PlateSection.plain),
    ]),
    bands: const <PlateBand>[
      PlateBand(box: _Layout.sticker, color: PeruColors.sticker),
    ],
    slots: <PlateSlot>[register, serial],
    labels: <PlateLabel>[
      const PlateLabel(
        text: 'PERU',
        box: _Layout.peru,
        glyphHeight: _Layout.peruGlyph,
      ),
      PlateLabel(text: '-', box: dash, glyphHeight: _Layout.serialBox),
      // The holographic label repeats the plate number in miniature.
      const PlateLabel(
        text: 'ABC-123',
        box: _Layout.sticker,
        glyphHeight: _Layout.stickerGlyph,
        color: PeruColors.stickerInk,
        resolve: _stickerText,
      ),
      // The laser-engraved security serial.
      const PlateLabel(
        text: '1234567',
        box: _Layout.microSerial,
        glyphHeight: _Layout.microSerialGlyph,
      ),
      if (special)
        const PlateLabel(
          text: 'E',
          box: _Layout.letterE,
          glyphHeight: _Layout.letterEGlyph,
        ),
    ],
    decals: const <PlateDecal>[PlateDecal(drawing: _flag, box: _Layout.flag)],
    textGroups: PlateTextGroup.perSlot(<String>['register', 'serial']),
  );

  /// The flag as printed in the header: stripes 29 / 36 / 29 of 94, wider than
  /// the national 1:1:1 as the artwork draws it.
  static const PlateDrawing _flag = PlateDrawing(94, 49, <PlateShape>[
    PlateRectShape(0, 0, 29, 49, PeruColors.flagRed),
    PlateRectShape(29, 0, 36, 49, PeruColors.flagWhite),
    PlateRectShape(65, 0, 29, 49, PeruColors.flagRed),
  ]);

  static String? _stickerText(String Function(String key) group) {
    final String register = group('register'), serial = group('serial');
    if (register.isEmpty && serial.isEmpty) return null;
    return '$register-$serial';
  }
}
