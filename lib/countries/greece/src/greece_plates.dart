import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'greece_country.dart';
import 'greece_regions.dart';

/// Plate-unit measurements projected from references flattened to 520×110.
/// The AFG plate follows its photo's 1.71:1 aspect (188 wide). The government
/// layout is eyeballed (CHECK): its dark ink merges with the frame.
///
/// Reference ink needs a ~130 slot on a 110 plate (`glyphStyle` sets 0.72 of
/// the slot, a bold cap ~0.73 of that); slots are 104 tall, ink ~76% of
/// reference. `spacing` brings the font's advance to the printed pitch.
abstract final class _Layout {
  static const double width = 520, height = 110, slotTop = 2, slotHeight = 104;

  static const double bandEnd = 53.75;

  /// Euro plate letters: cells of 58.5 starting clear of the band.
  static const double letterPitch = 58.5, lettersLeft = 52.3;
  static const double dashLeft = 230, dashTop = 50, dashWidth = 30;
  static const double dashHeight = 9, digitsRight = 490, euroDigitPitch = 55;
  static const double sealSize = 32, sealTop = 14.5, sealLeft = 229;

  static const double trailerLetterCentre = 106, trailerSealLeft = 156;

  // Government (CHECK): letters 24..214, dash and seal between, digits to 500.
  static const double govLettersLeft = 22, govLetterPitch = 63;
  static const double govDigitsLeft = 264, govDigitPitch = 59;
  static const double govDashLeft = 224, govDashWidth = 26, govSealLeft = 231;

  // Police.
  static const double policeTop = 6;
  static const double policeLettersLeft = 46, policeLetterPitch = 65;
  static const double policeDigitsLeft = 241.6, policeDigitPitch = 46.8;
  static const double policeSealLeft = 194, policeSealTop = 54;
  static const double policeSealSize = 36;
  static const List<double> policeDotCentres = <double>[111, 173.5];

  // AFG.
  static const double afgWidth = 188, afgTop = 22.25, afgHeight = 84;
  static const double afgLetterLeft = 17, afgLetterWidth = 40;
  static const double afgDigitsLeft = 67, afgDigitPitch = 31;
  static const double afgCaptionGlyph = 30;
}

/// * [private] — `ΑΒΓ-1234` with the euroband and the state seal above the dash.
/// * [trailer] — the euro plate with one letter and five digits, on grey.
/// * [government] — the same letters and digits on orange, no band.
/// * [police] — `Ε.Α. 12345`, blue on pale grey.
/// * [afg] — the Allied Forces in Greece motorcycle plate: one letter, a dash
///   and one to three digits under a small `AFG`.
///
/// Every spec has a `letters` group and a `number` group, one slot each. Not
/// implemented: plates no longer issued, the square motorcycle and diplomatic
/// plates (no usable reference), tax-free red letters and yellow truck letters.
abstract final class GreecePlates {
  static final List<PlateTextGroup> _groups = PlateTextGroup.perSlot(<String>[
    'letters',
    'number',
  ]);

  static const AssetImage _seal = AssetImage(
    'assets/countries/greece/gr_seal.png',
    package: 'license_plate',
  );

  static PlateSlot _field(
    PlateAlphabet alphabet,
    int length, {
    required double left,
    required double top,
    required double pitch,
    required double height,
    int? minLength,
  }) => PlateSlot(
    alphabet: alphabet,
    box: PlateBox(left, top, length * pitch, height),
    length: length,
    minLength: minLength,
    spacing: length == 1 ? 0 : plateRunSpacing(pitch, height),
  );

  static PlateSlot _row(
    PlateAlphabet alphabet,
    int count,
    double left,
    double pitch, {
    double top = _Layout.slotTop,
  }) => _field(
    alphabet,
    count,
    left: left,
    top: top,
    pitch: pitch,
    height: _Layout.slotHeight,
  );

  /// The euro plate: band, letters, dash, seal, digits flush right.
  static PlateSpec _euro(
    String id, {
    required int letters,
    required int digits,
    required double lettersLeft,
    required bool dash,
    required double sealLeft,
  }) => PlateSpec(
    id: id,
    country: GreeceCountry.greece,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    panel: const PlatePanel(
      box: PlateBox(0, 0, _Layout.bandEnd, _Layout.height),
      padding: GreeceCountry.panelPadding,
    ),
    background: PlateSection.columns(<PlatePart>[
      const PlatePart(PlateSection.fill(PlateFill.panel), end: _Layout.bandEnd),
      const PlatePart(PlateSection.plain),
    ]),
    slots: <PlateSlot>[
      _row(GreeceAlphabets.letters, letters, lettersLeft, _Layout.letterPitch),
      _row(
        GreeceAlphabets.digits,
        digits,
        _Layout.digitsRight - digits * _Layout.euroDigitPitch,
        _Layout.euroDigitPitch,
      ),
    ],
    rules: <PlateRule>[
      if (dash)
        const PlateRule(
          box: PlateBox(
            _Layout.dashLeft,
            _Layout.dashTop,
            _Layout.dashWidth,
            _Layout.dashHeight,
          ),
        ),
    ],
    decals: <PlateDecal>[
      PlateDecal(
        image: _seal,
        box: PlateBox(
          sealLeft,
          _Layout.sealTop,
          _Layout.sealSize,
          _Layout.sealSize,
        ),
      ),
    ],
    textGroups: _groups,
    resolveRegion: GreeceRegions.captionOf,
  );

  static final PlateSpec private = _euro(
    'gr.private',
    letters: 3,
    digits: 4,
    lettersLeft: _Layout.lettersLeft,
    dash: true,
    sealLeft: _Layout.sealLeft,
  );

  static final PlateSpec trailer = _euro(
    'gr.trailer',
    letters: 1,
    digits: 5,
    lettersLeft: _Layout.trailerLetterCentre - _Layout.letterPitch / 2,
    dash: false,
    sealLeft: _Layout.trailerSealLeft,
  );

  static final PlateSpec government = PlateSpec(
    id: 'gr.government',
    country: GreeceCountry.greece,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
    slots: <PlateSlot>[
      _row(
        GreeceAlphabets.letters,
        3,
        _Layout.govLettersLeft,
        _Layout.govLetterPitch,
      ),
      _row(
        GreeceAlphabets.digits,
        4,
        _Layout.govDigitsLeft,
        _Layout.govDigitPitch,
      ),
    ],
    rules: const <PlateRule>[
      PlateRule(
        box: PlateBox(
          _Layout.govDashLeft,
          _Layout.dashTop,
          _Layout.govDashWidth,
          _Layout.dashHeight,
        ),
      ),
    ],
    decals: <PlateDecal>[
      PlateDecal(
        image: _seal,
        box: PlateBox(
          _Layout.govSealLeft,
          _Layout.sealTop,
          _Layout.sealSize,
          _Layout.sealSize,
        ),
      ),
    ],
    textGroups: _groups,
    resolveRegion: GreeceRegions.captionOf,
  );

  static final PlateSpec police = PlateSpec(
    id: 'gr.police',
    country: GreeceCountry.greece,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
    slots: <PlateSlot>[
      _row(
        GreeceAlphabets.letters,
        2,
        _Layout.policeLettersLeft,
        _Layout.policeLetterPitch,
        top: _Layout.policeTop,
      ),
      _row(
        GreeceAlphabets.digits,
        5,
        _Layout.policeDigitsLeft,
        _Layout.policeDigitPitch,
        top: _Layout.policeTop,
      ),
    ],
    labels: <PlateLabel>[
      for (final double c in _Layout.policeDotCentres)
        PlateLabel(
          text: '.',
          box: PlateBox(c - 7, _Layout.policeTop, 14, _Layout.slotHeight),
          glyphHeight: _Layout.slotHeight,
        ),
    ],
    decals: <PlateDecal>[
      PlateDecal(
        image: _seal,
        box: PlateBox(
          _Layout.policeSealLeft,
          _Layout.policeSealTop,
          _Layout.policeSealSize,
          _Layout.policeSealSize,
        ),
      ),
    ],
    textGroups: _groups,
  );

  static final PlateSpec afg = PlateSpec(
    id: 'gr.afg',
    country: GreeceCountry.greece,
    canvasWidth: _Layout.afgWidth,
    canvasHeight: _Layout.height,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
    slots: <PlateSlot>[
      PlateSlot(
        alphabet: GreeceAlphabets.letters,
        box: const PlateBox(
          _Layout.afgLetterLeft,
          _Layout.afgTop,
          _Layout.afgLetterWidth,
          _Layout.afgHeight,
        ),
      ),
      _field(
        GreeceAlphabets.digits,
        3,
        left: _Layout.afgDigitsLeft,
        top: _Layout.afgTop,
        pitch: _Layout.afgDigitPitch,
        height: _Layout.afgHeight,
        minLength: 1,
      ),
    ],
    rules: const <PlateRule>[PlateRule(box: PlateBox(55.5, 61, 7, 7))],
    labels: const <PlateLabel>[
      PlateLabel(
        text: 'AFG',
        box: PlateBox(64, 8, 60, 30),
        glyphHeight: _Layout.afgCaptionGlyph,
      ),
    ],
    textGroups: _groups,
  );

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    trailer,
    government,
    police,
    afg,
  ];
}
