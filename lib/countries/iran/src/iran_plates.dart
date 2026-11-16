import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'iran_country.dart';
import 'iran_regions.dart';
import 'iran_themes.dart';
import 'iran_usage.dart';
import 'persian_alphabets.dart';

/// Iranian plate designs. The civil, military and diplomatic classes are one
/// spec, [civil]: the series letter picks the livery ([IranThemes.civil])
/// and the wording ([_squareCaption], the TAXI label); `گ` turns it into
/// [temporary]. The other blanks are written in full.
abstract final class IranPlates {
  /// The province square's caption: the class's own for the diplomatic
  /// letters, else the region the code and letter locate, else "ایران".
  static String? _squareCaption(String Function(String key) group) =>
      switch (group('letter')) {
        'D' => 'سیاسی',
        'S' => 'سرویس',
        _ => IranRegions.captionOf(group),
      };

  static String? _taxiCaption(String Function(String key) group) =>
      group('letter') == 'ت' ? 'TAXI' : '';

  // Extra space after each digit of a run, so two digits sit at the printed
  // 55-unit pitch (province: 38) instead of the font's own advance.
  static const double _civilSpacing = 22, _provinceSpacing = 16;

  static PlateSpec? _civilOrTemporary(String Function(String key) group) =>
      group('letter') == 'گ' ? temporary : civil;

  /// The district, letter and serial every full-size civil plate shares.
  static const List<PlateSlot> _civilSerial = [
    PlateSlot(
      alphabet: PersianAlphabets.digits,
      box: PlateBox(65, 17, 102, 76),
      length: 2,
      spacing: _civilSpacing,
    ),
    PlateSlot(
      alphabet: PersianAlphabets.civilLetters,
      box: PlateBox(172, 17, 61, 76),
    ),
    PlateSlot(
      alphabet: PersianAlphabets.digits,
      box: PlateBox(238, 17, 157, 76),
      length: 3,
      spacing: _civilSpacing,
    ),
  ];

  // The panel strip, the serial, then the province square behind a divider
  // at x 404..409 from frame to frame.
  static const PlateSection _civilBackground = PlateSection.columns([
    PlatePart(PlateSection.fill(PlateFill.panel), end: 56.4),
    PlatePart(PlateSection.plain, end: 406.5, divider: 5),
    PlatePart(PlateSection.plain),
  ]);

  /// Every civil, military and diplomatic plate: digit pair, letter, serial
  /// triple, province pair on a 520x110 blank.
  static final PlateSpec civil = PlateSpec(
    id: 'ir.civil',
    country: IranCountry.iran,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: const PlatePanel(box: PlateBox(0, 0, 56.4, 110)),
    textDirection: TextDirection.rtl,
    resolveTheme: IranThemes.civil,
    slots: const [
      ..._civilSerial,
      PlateSlot(
        alphabet: PersianAlphabets.digits,
        box: PlateBox(428, 40, 70, 52),
        length: 2,
        spacing: _provinceSpacing,
      ),
    ],
    background: _civilBackground,
    labels: const [
      PlateLabel(
        text: 'ایران',
        box: PlateBox(412, 13, 103, 25.6),
        glyphHeight: 25.6,
        resolve: _squareCaption,
      ),
      // Printed above the letter on a taxi plate only; fades in with `ت`.
      PlateLabel(
        text: '',
        box: PlateBox(175, 12, 55, 14),
        glyphHeight: 12,
        resolve: _taxiCaption,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'district'),
      PlateTextGroup([1], key: 'letter'),
      PlateTextGroup([2], key: 'serial'),
      PlateTextGroup([3], prefix: 'IR ', key: 'province'),
    ],
    resolveSpec: _civilOrTemporary,
  );

  /// Temporary passage (گذر موقت): [civil] with `گ` for its letter, the
  /// province square squeezed over the plate's expiry date, year over month.
  /// Typing `گ` on [civil] turns the plate into this one; any other letter
  /// turns it back.
  static final PlateSpec temporary = PlateSpec(
    id: 'ir.temporary',
    country: IranCountry.iran,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: const PlatePanel(box: PlateBox(0, 0, 56.4, 110)),
    textDirection: TextDirection.rtl,
    resolveTheme: IranThemes.civil,
    resolveSpec: _civilOrTemporary,
    slots: const [
      ..._civilSerial,
      PlateSlot(
        alphabet: PersianAlphabets.digits,
        box: PlateBox(441, 27, 44, 34),
        length: 2,
        spacing: 10,
      ),
      PlateSlot(
        alphabet: PersianAlphabets.digits,
        box: PlateBox(421, 71, 40, 32),
        length: 2,
        spacing: 8,
      ),
      PlateSlot(
        alphabet: PersianAlphabets.digits,
        box: PlateBox(473, 71, 34, 32),
        length: 2,
        minLength: 1,
        spacing: 8,
      ),
    ],
    background: _civilBackground,
    rules: const [PlateRule(box: PlateBox(418, 64, 88, 2.5))],
    labels: const [
      PlateLabel(
        text: 'ایران',
        box: PlateBox(412, 5, 103, 20),
        glyphHeight: 20,
        resolve: _squareCaption,
      ),
      PlateLabel(text: '/', box: PlateBox(461, 71, 12, 32), glyphHeight: 32),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'district'),
      PlateTextGroup([1], key: 'letter'),
      PlateTextGroup([2], key: 'serial'),
      PlateTextGroup([3], prefix: 'IR ', key: 'province'),
      PlateTextGroup([4], key: 'year'),
      PlateTextGroup([5], prefix: '/', key: 'month'),
    ],
  );

  // --- The plates that are not the standard blank ---------------------------

  /// Protocol vehicles: white on red, `تشریفات` over its English translation
  /// beside a bare serial. No series letter, no divider and no province square
  /// — the one full-size Iranian plate that is not a registration in the usual
  /// format.
  ///
  /// Five digits, not four: the article's text says four, but its image reads
  /// `۱۳۹۰۱` and five cells measure evenly; the picture wins.
  static final PlateSpec protocol = PlateSpec(
    id: 'ir.protocol',
    country: IranCountry.iran,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: const PlatePanel(box: PlateBox(0, 0, 56.4, 110)),
    background: const PlateSection.columns([
      PlatePart(PlateSection.fill(PlateFill.panel), end: 56.4),
      PlatePart(PlateSection.plain),
    ]),
    textDirection: TextDirection.rtl,
    slots: const [
      PlateSlot(
        alphabet: PersianAlphabets.digits,
        box: PlateBox(294, 16, 203, 76),
        length: 5,
        spacing: 8,
      ),
    ],
    labels: const [
      PlateLabel(
        text: 'تشریفات',
        box: PlateBox(63, 4, 221, 52),
        glyphHeight: 48,
      ),
      PlateLabel(
        text: 'PROTOCOL',
        box: PlateBox(63, 56, 221, 42),
        glyphHeight: 42,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'serial'),
    ],
  );

  /// Historic vehicles: white on brown, a blue panel left and two rows right —
  /// `تاریخی` over a five-digit serial, split by a horizontal rule. American-
  /// standard blank (300x150), measured from the article's own artwork.
  ///
  /// The panel holds the flag, `I.R. IRAN` and, below them, a framed picture
  /// of Bagh-e Melli. The picture is a photograph, which no box or text can
  /// draw, so it is the one decal here; the frame is part of the image.
  static final PlateSpec historic = PlateSpec(
    id: 'ir.historic',
    country: IranCountry.iran,
    canvasWidth: 300,
    canvasHeight: 150,
    panel: const PlatePanel(
      box: PlateBox(0, 0, 109.6, 68.8),
      flagScale: 1.0,
      captionScale: 0.45,
      padding: EdgeInsets.fromLTRB(7.8, 12, 67.8, 25.8),
    ),
    // The panel, then the two rows behind a vertical rule at x 108.3..110.9;
    // the rows are split by one at y 72.4..75.
    background: const PlateSection.columns([
      PlatePart(PlateSection.fill(PlateFill.panel), end: 109.6, divider: 2.6),
      PlatePart(
        PlateSection.rows([
          PlatePart(PlateSection.plain, end: 73.7, divider: 2.6),
          PlatePart(PlateSection.plain),
        ]),
      ),
    ]),
    textDirection: TextDirection.rtl,
    borderWidthRatioOverride: 0.02,
    slots: const [
      PlateSlot(
        alphabet: PersianAlphabets.digits,
        box: PlateBox(116.8, 84.5, 168.5, 48),
        length: 5,
        spacing: 13,
      ),
    ],
    labels: const [
      PlateLabel(
        text: 'تاریخی',
        box: PlateBox(114, 18.4, 168, 46),
        glyphHeight: 46,
      ),
    ],
    decals: const [
      PlateDecal(
        image: AssetImage(
          'assets/countries/iran/historic_bagh_e_melli.png',
          package: 'license_plate',
        ),
        box: PlateBox(9.4, 68.8, 92.7, 70.3),
      ),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'serial'),
    ],
  );

  /// Motorcycles: a three-digit code over a five-digit serial, on a blue panel
  /// in the top-left corner. No letter. No zeros: after 499 comes 511.
  static final PlateSpec motorcycle = PlateSpec(
    id: 'ir.motorcycle',
    country: IranCountry.iran,
    canvasWidth: 175,
    canvasHeight: 110,
    panel: const PlatePanel(
      box: PlateBox(0, 0, 36.7, 58.4),
      flagScale: 1.0,
      captionScale: 0.5,
      padding: EdgeInsets.fromLTRB(5.5, 5.4, 2.7, 3.4),
    ),
    // The panel is the top-left corner: a column of the top row.
    background: const PlateSection.rows([
      PlatePart(
        PlateSection.columns([
          PlatePart(PlateSection.fill(PlateFill.panel), end: 36.7),
          PlatePart(PlateSection.plain),
        ]),
        end: 58.4,
      ),
      PlatePart(PlateSection.plain),
    ]),
    textDirection: TextDirection.rtl,
    borderWidthRatioOverride: 0.05,
    slots: const [
      PlateSlot(
        alphabet: PersianAlphabets.digits,
        box: PlateBox(63.1, 9.3, 79.8, 40),
        length: 3,
        spacing: 9.4,
      ),
      PlateSlot(
        alphabet: PersianAlphabets.digits,
        box: PlateBox(8.5, 63.3, 151.5, 40),
        length: 5,
        spacing: 13,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'province'),
      PlateTextGroup([1], key: 'serial'),
    ],
  );

  /// Temporary passage within a free zone (گذر موقت مناطق آزاد): the small
  /// blank, a one-digit zone over a two-digit year on the left, the wording
  /// over a four-digit serial on the right.
  static final PlateSpec freeZoneTransit = PlateSpec(
    id: 'ir.freeZoneTransit',
    country: IranCountry.iran,
    canvasWidth: 260,
    canvasHeight: 130,
    background: const PlateSection.columns([
      PlatePart(
        PlateSection.rows([
          PlatePart(PlateSection.plain, end: 65, divider: 3),
          PlatePart(PlateSection.plain),
        ]),
        end: 62,
        divider: 3,
      ),
      PlatePart(PlateSection.plain),
    ]),
    textDirection: TextDirection.rtl,
    slots: const [
      PlateSlot(
        alphabet: PersianAlphabets.digits,
        box: PlateBox(16, 12, 30, 44),
      ),
      PlateSlot(
        alphabet: PersianAlphabets.digits,
        box: PlateBox(8, 74, 46, 44),
        length: 2,
        spacing: 4,
      ),
      PlateSlot(
        alphabet: PersianAlphabets.digits,
        box: PlateBox(76, 56, 170, 62),
        length: 4,
        spacing: 10,
      ),
    ],
    labels: const [
      PlateLabel(
        text: 'گذر موقت',
        box: PlateBox(78, 10, 166, 36),
        glyphHeight: 28,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'zone'),
      PlateTextGroup([1], key: 'year'),
      PlateTextGroup([2], key: 'serial'),
    ],
  );

  /// Electric buses: five digits on a plain yellow field.
  static final PlateSpec electricBus = PlateSpec(
    id: 'ir.electricBus',
    country: IranCountry.iran,
    canvasWidth: 360,
    canvasHeight: 110,
    textDirection: TextDirection.rtl,
    slots: const [
      PlateSlot(
        alphabet: PersianAlphabets.digits,
        box: PlateBox(49, 17, 262, 76),
        length: 5,
        spacing: _civilSpacing,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'serial'),
    ],
  );

  /// Every civil class shares [civil], whose colour follows its letter.
  static PlateSpec forUsage(IranUsage usage) => switch (usage) {
    IranUsage.temporary => temporary,
    IranUsage.freeZoneTransit => freeZoneTransit,
    IranUsage.electricBus => electricBus,
    IranUsage.protocol => protocol,
    IranUsage.historic => historic,
    IranUsage.motorcycle => motorcycle,
    _ => civil,
  };

  /// Every plate this package ships, in [IranUsage] order.
  static List<PlateSpec> get all => <PlateSpec>[
    civil,
    temporary,
    protocol,
    historic,
    motorcycle,
    freeZoneTransit,
    electricBus,
  ];
}
