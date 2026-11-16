import 'dart:math' as math;

import 'package:license_plate/core/plate_core.dart';
import 'package:flutter/widgets.dart';

import 'uae_alphabets.dart';
import 'uae_colors.dart';
import 'uae_country.dart';

/// The private-vehicle plates of the seven emirates, in both sizes.
///
/// Every number below is a measured *ink* extent in plate millimetres, taken
/// off the reference artwork on Wikimedia Commons linked from Wikipedia's
/// "Vehicle registration plates of the United Arab Emirates", with each file's
/// plate rectangle normalised to the article's 520x110 or 335x155. The short
/// artwork is drawn at 1.84:1 against the documented 2.16:1, so its content is
/// stretched proportionally across the documented canvas.
///
/// [_ink] and [_cells] turn an ink extent into the box that reproduces it:
/// core paints ink at about 0.55 of a Latin glyph height and 0.65 of an Arabic
/// one (dots and descenders included). A cell whose box would leave the canvas
/// is shrunk about its centre, so the tallest serials come out short of
/// reference — the long serials at about 90%, Abu Dhabi's short at 80%.
///
/// The logo plates (Abu Dhabi, Ajman, Umm Al Quwain), Dubai's coloured plate
/// and the new double-framed Fujairah, Ras Al Khaimah and Umm Al Quwain plates
/// are measured off the same source; the new plates exist there only as
/// 235x50 and 150x76 thumbnails, so their numbers are good to about 2 mm.
///
/// Approximations, all forced by what a spec can say: the emirates'
/// calligraphic emblems and Abu Dhabi's shield are set as bold Arabic text
/// (the shield on a red rounded band); the condensed serial face of Dubai and
/// the new plates is the theme's bold face shrunk to fit its pitch, so those
/// serials come out narrower and shorter than reference.
abstract final class UaePlates {
  static const double _longW = 520, _longH = 110, _shortW = 335, _shortH = 155;

  static const double _latinInk = 0.55, _arabicInk = 0.65;
  static const double _latinAdvance = 0.5, _arabicAdvance = 0.39;

  /// Sharjah's frame: 7 mm on the long plate, 8 on the short.
  static const double _sharjahLongBorder = 7 / _longH;
  static const double _sharjahShortBorder = 8 / _shortH;

  /// A label reproducing ink spanning [x0]..[x1] by [y0]..[y1]. The plates'
  /// faces are condensed or calligraphic and the theme's bold is not, so the
  /// glyph is also capped to fit the width: a character advances about
  /// [_latinAdvance] or [_arabicAdvance] of the glyph height (measured off
  /// these goldens). A capped label comes out shorter than reference.
  static PlateLabel _ink(
    String text,
    double x0,
    double x1,
    double y0,
    double y1, {
    bool arabic = false,
    Color? color,
    double? glyphHeight,
  }) {
    final chars = text.replaceAll('\u200d', '').length;
    return PlateLabel(
      text: text,
      box: PlateBox.fromLTRB(x0, y0, x1, y1),
      glyphHeight:
          glyphHeight ??
          math.min(
            (y1 - y0) / (arabic ? _arabicInk : _latinInk),
            (x1 - x0) / (chars * (arabic ? _arabicAdvance : _latinAdvance)),
          ),
      color: color,
    );
  }

  /// The glyph height that fits [chars] Latin characters across [x0]..[x1]
  /// and their ink to [y0]..[y1]: one size for a word split into labels.
  static double _wordGlyph(
    int chars,
    double x0,
    double x1,
    double y0,
    double y1,
  ) => math.min((y1 - y0) / _latinInk, (x1 - x0) / (chars * _latinAdvance));

  /// One field of [count] cells centred from [firstCx] at [pitch], reproducing
  /// ink spanning [y0]..[y1] on a canvas [canvasH] tall. A [minLength] makes it
  /// variable.
  static PlateSlot _cells({
    required PlateAlphabet alphabet,
    required int count,
    required double firstCx,
    required double pitch,
    required double y0,
    required double y1,
    required double canvasH,
    double? width,
    int? minLength,
    Color? color,
  }) {
    final cy = (y0 + y1) / 2;
    final double height = math.min(
      (y1 - y0) / _latinInk,
      2 * math.min(cy, canvasH - cy),
    );
    final w = width ?? pitch * 0.96;
    return PlateSlot(
      alphabet: alphabet,
      box: PlateBox(
        firstCx - w / 2,
        cy - height / 2,
        w + (count - 1) * pitch,
        height,
      ),
      length: count,
      minLength: minLength,
      spacing: count == 1 || minLength != null
          ? 0
          : plateRunSpacing(pitch, height),
      color: color,
    );
  }

  static PlateSlot _letter(
    double cx,
    double y0,
    double y1,
    double canvasH, {
    double width = 48,
  }) => _cells(
    alphabet: UaeAlphabets.letters,
    count: 1,
    firstCx: cx,
    pitch: width,
    y0: y0,
    y1: y1,
    canvasH: canvasH,
  );

  static PlateSlot _serial(
    double firstCx,
    double pitch,
    double y0,
    double y1,
    double canvasH,
  ) => _cells(
    alphabet: UaeAlphabets.digits,
    count: 5,
    minLength: 1,
    firstCx: firstCx,
    pitch: pitch,
    y0: y0,
    y1: y1,
    canvasH: canvasH,
  );

  static const PlatePanel _noPanel = PlatePanel(
    box: PlateBox(0, 0, 0, 0),
    padding: EdgeInsets.zero,
  );

  /// Every design is a code (one letter, or two digits) then a serial of one to
  /// five digits.
  static PlateSpec _spec({
    required String id,
    required bool long,
    required PlateSlot code,
    required PlateSlot serial,
    required List<PlateLabel> labels,
    PlateSection background = PlateSection.plain,
    List<PlateBand> bands = const <PlateBand>[],
    List<PlateDecal> decals = const <PlateDecal>[],
    double? borderWidthRatioOverride,
  }) {
    return PlateSpec(
      id: id,
      country: UaeCountry.uae,
      canvasWidth: long ? _longW : _shortW,
      canvasHeight: long ? _longH : _shortH,
      noPanel: true,
      panel: _noPanel,
      slots: <PlateSlot>[code, serial],
      labels: labels,
      bands: bands,
      decals: decals,
      background: background,
      borderWidthRatioOverride: borderWidthRatioOverride,
      textGroups: PlateTextGroup.perSlot(<String>['code', 'serial']),
    );
  }

  // -------------------------------------------------------------------------
  // Abu Dhabi
  // -------------------------------------------------------------------------

  /// Long: a red strip x 0..107.2 under the frame, its two-digit code in white
  /// (ink centres 33.2 and 72.7, y 26.7..82.8). Then "الامارات" over "أبوظبي"
  /// (x 124..230, y 14.7..61.8), "U.A.E A.D" (y 70.7..89), and the serial,
  /// centres 276.2 + 50.1k, y 21..88.5.
  static final PlateSpec abuDhabiLong = _spec(
    id: 'ae.abudhabi.long',
    long: true,
    background: const PlateSection.columns(<PlatePart>[
      PlatePart(
        PlateSection.fill(PlateFill.color(UaeColors.abuDhabiRed)),
        end: 107.2,
      ),
      PlatePart(PlateSection.plain),
    ]),
    code: _cells(
      alphabet: UaeAlphabets.digits,
      count: 2,
      firstCx: 33.2,
      pitch: 39.5,
      y0: 26.7,
      y1: 82.8,
      canvasH: _longH,
      color: UaeColors.field,
    ),
    serial: _serial(276.2, 50.1, 21, 88.5, _longH),
    labels: <PlateLabel>[
      _ink('الامارات', 124, 230, 14.7, 36, arabic: true),
      _ink('أبوظبي', 124, 230, 38.2, 61.8, arabic: true),
      _ink('U.A.E  A.D', 125, 234.5, 70.7, 89),
    ],
  );

  /// Short: a red band y 0..60.1 closed by a 2.8 black rule, carrying the
  /// white code (centres 146.75 and 185, y 9.5..56.2) between "أبوظبي / A.D"
  /// on the left and "الامارات / U.A.E" on the right. The serial below,
  /// centres 53.4 + 55.5k, y 73.6..139.8.
  static final PlateSpec abuDhabiShort = _spec(
    id: 'ae.abudhabi.short',
    long: false,
    background: const PlateSection.rows(<PlatePart>[
      PlatePart(
        PlateSection.fill(PlateFill.color(UaeColors.abuDhabiRed)),
        end: 61.5,
        divider: 2.8,
      ),
      PlatePart(PlateSection.plain),
    ]),
    code: _cells(
      alphabet: UaeAlphabets.digits,
      count: 2,
      firstCx: 146.75,
      pitch: 38.3,
      y0: 9.5,
      y1: 56.2,
      canvasH: _shortH,
      color: UaeColors.field,
    ),
    serial: _serial(53.4, 55.5, 73.6, 139.8, _shortH),
    labels: <PlateLabel>[
      _ink('أبوظبي', 12, 113, 8.4, 34.8, arabic: true, color: UaeColors.field),
      _ink('A.D', 39, 76.5, 37, 53, color: UaeColors.field),
      _ink('الامارات', 209, 322, 9, 33, arabic: true, color: UaeColors.field),
      _ink('U.A.E', 251, 309, 35, 51, color: UaeColors.field),
    ],
  );

  // -------------------------------------------------------------------------
  // Ajman
  // -------------------------------------------------------------------------

  /// Long: letter (cx 48.8, y 15.7..90.6), "الامارات / UAE.AJMAN / عجمان"
  /// stacked at x 100..194, then the serial spread across x 222..500, y
  /// 20..95. The reference's figures are proportional (its "1" is narrow), so
  /// the pitch is the mean, 55.6.
  static final PlateSpec ajmanLong = _spec(
    id: 'ae.ajman.long',
    long: true,
    code: _letter(48.8, 15.7, 90.6, _longH),
    serial: _serial(249.8, 55.6, 20, 95, _longH),
    labels: <PlateLabel>[
      _ink('الامارات', 100, 194, 18, 46, arabic: true),
      _ink('UAE.AJMAN', 100.8, 192, 50.8, 62.9),
      _ink('عجمان', 100, 194, 67, 95, arabic: true),
    ],
  );

  /// Short: serial on top (x 8..327, y 10..86.5); below it "عجمان / AJMAN",
  /// the letter (cx 164, y 99.4..147) and "الامارات / UAE".
  static final PlateSpec ajmanShort = _spec(
    id: 'ae.ajman.short',
    long: false,
    code: _letter(164, 99.4, 147, _shortH),
    serial: _serial(8 + 31.9, 63.8, 10, 86.5, _shortH),
    labels: <PlateLabel>[
      _ink('عجمان', 50, 118.7, 102, 125, arabic: true),
      _ink('AJMAN', 39, 107.5, 132.5, 145.5),
      _ink('الامارات', 214, 302, 102, 124, arabic: true),
      _ink('UAE', 237, 275.6, 132, 145),
    ],
  );

  // -------------------------------------------------------------------------
  // Dubai
  // -------------------------------------------------------------------------

  /// "DUBAI" one label per letter, so the coloured plate can tint each:
  /// measured on the long plate at D 40.9..58.4, U 61..79.5, B 80.5..98.7,
  /// A 101.9..118.9, I 122..127.3, shifted by [dx] (the short plate's is the
  /// same word 6.6 mm left).
  static List<PlateLabel> _dubaiWord(
    double dx,
    double y0,
    double y1, {
    required bool coloured,
  }) {
    const blue = UaeColors.dubaiBlue, pink = UaeColors.dubaiPink;
    return <PlateLabel>[
      for (final (text, x0, x1, tint) in const [
        ('D', 40.9, 58.4, blue),
        ('U', 61.0, 79.5, blue),
        ('B', 80.5, 98.7, pink),
        ('A', 101.9, 118.9, pink),
        ('I', 122.0, 127.3, blue),
      ])
        _ink(
          text,
          x0 + dx,
          x1 + dx,
          y0,
          y1,
          color: coloured ? tint : null,
          glyphHeight: _wordGlyph(5, 40.9, 127.3, y0, y1),
        ),
    ];
  }

  /// The code is one letter or a doubled one (AA to EE): a variable two-cell
  /// field centred where the reference prints its single letter.
  static PlateSlot _dubaiCode(
    double cx,
    double pitch,
    double y0,
    double y1,
    double canvasH,
  ) => _cells(
    alphabet: UaeAlphabets.letters,
    count: 2,
    minLength: 1,
    firstCx: cx - pitch / 2,
    pitch: pitch,
    y0: y0,
    y1: y1,
    canvasH: canvasH,
  );

  /// Long: "DUBAI" (x 40.9..127.3, y 12.6..45.6) over the code (cx 74.8,
  /// y 58..93), serial centres 201.6 + 52k, y 22.5..88.5.
  static PlateSpec _dubaiLong(String id, {required bool coloured}) => _spec(
    id: id,
    long: true,
    code: _dubaiCode(74.8, 34, 58, 93, _longH),
    serial: _serial(201.6, 52, 22.5, 88.5, _longH),
    labels: _dubaiWord(0, 12.6, 45.6, coloured: coloured),
  );

  /// Short: "DUBAI" top left (y 12.9..41), the code top right (cx 287,
  /// y 9..38.8), serial along the bottom at pitch 59.3, y 75.8..141; the
  /// coloured plate's serial starts at 28.5 (measured 28.1, held inside the canvas) rather than 33.
  static PlateSpec _dubaiShort(
    String id, {
    required bool coloured,
    required double firstCx,
  }) => _spec(
    id: id,
    long: false,
    code: _dubaiCode(287, 26, 9, 38.8, _shortH),
    serial: _serial(firstCx, 59.3, 75.8, 141, _shortH),
    labels: _dubaiWord(-6.6, 12.9, 41, coloured: coloured),
  );

  static final PlateSpec dubaiLong = _dubaiLong(
    'ae.dubai.long',
    coloured: false,
  );
  static final PlateSpec dubaiShort = _dubaiShort(
    'ae.dubai.short',
    coloured: false,
    firstCx: 33,
  );
  static final PlateSpec dubaiColouredLong = _dubaiLong(
    'ae.dubai.coloured.long',
    coloured: true,
  );
  static final PlateSpec dubaiColouredShort = _dubaiShort(
    'ae.dubai.coloured.short',
    coloured: true,
    firstCx: 28.5,
  );

  // -------------------------------------------------------------------------
  // Fujairah and Umm Al Quwain share the long layout: letter, "U.A.E" over
  // the emirate's Arabic name, serial.
  // -------------------------------------------------------------------------

  /// Letter cx 48.3, y 15.7..85; "U.A.E" x 101..214, y 18.3..48.2; serial
  /// centres 257 + 47.6k, y 16..87. [name] is the Arabic line under "U.A.E".
  static PlateSpec _letterUaeNameLong(String id, PlateLabel name) => _spec(
    id: id,
    long: true,
    code: _letter(48.3, 15.7, 85, _longH),
    serial: _serial(257, 47.6, 16, 87, _longH),
    labels: <PlateLabel>[_ink('U.A.E', 101, 214, 18.3, 48.2), name],
  );

  static final PlateSpec fujairahLong = _letterUaeNameLong(
    'ae.fujairah.long',
    _ink('الفجيرة', 105.6, 216.5, 56, 96, arabic: true),
  );

  /// Short: serial on top (centres 31.9 + 59.1k, y 10.7..87); "U.A.E", the
  /// letter (cx 155, y 97..145) and "الفجيرة" below.
  static final PlateSpec fujairahShort = _spec(
    id: 'ae.fujairah.short',
    long: false,
    code: _letter(155, 97, 145, _shortH, width: 40),
    serial: _serial(31.9, 59.1, 10.7, 87, _shortH),
    labels: <PlateLabel>[
      _ink('U.A.E', 22, 116, 106, 136),
      _ink('الفجيرة', 195, 307, 105, 140, arabic: true),
    ],
  );

  static final PlateSpec ummAlQuwainLong = _letterUaeNameLong(
    'ae.ummalquwain.long',
    _ink('ام القوين', 102, 217.6, 57.6, 91, arabic: true),
  );

  /// Short: the letter (cx 34.6, y 16..85.4) and serial (centres 97.7 + 47k,
  /// y 15.7..86) on top; "UAE" and "ام القوين" below.
  static final PlateSpec ummAlQuwainShort = _spec(
    id: 'ae.ummalquwain.short',
    long: false,
    code: _letter(34.6, 16, 85.4, _shortH, width: 44),
    serial: _serial(97.7, 47, 15.7, 86, _shortH),
    labels: <PlateLabel>[
      _ink('UAE', 39.6, 113.4, 118.5, 139.3),
      _ink('ام القوين', 166, 310, 109, 145, arabic: true),
    ],
  );

  // -------------------------------------------------------------------------
  // Ras Al Khaimah
  // -------------------------------------------------------------------------

  /// Long: Ajman's letter, "الامارات / رأس الخيمة / UAE.RAK" at x 107..213,
  /// and Abu Dhabi's serial positions.
  static final PlateSpec rasAlKhaimahLong = _spec(
    id: 'ae.rasalkhaimah.long',
    long: true,
    code: _letter(48.8, 15.7, 90.6, _longH),
    serial: _serial(276.2, 50.1, 21, 88.5, _longH),
    labels: <PlateLabel>[
      _ink('الامارات', 108, 207.5, 17, 37, arabic: true),
      _ink('رأس الخيمة', 107, 213, 41.4, 63.9, arabic: true),
      _ink('UAE.RAK', 108, 207.5, 71.8, 90),
    ],
  );

  /// Short: serial on top (centres 70.9 + 49.4k, y 12.4..68); "رأس الخيمة /
  /// RAK", the letter (cx 176, y 86.5..142) and "الامارات / UAE" below.
  static final PlateSpec rasAlKhaimahShort = _spec(
    id: 'ae.rasalkhaimah.short',
    long: false,
    code: _letter(176, 86.5, 142, _shortH),
    serial: _serial(70.9, 49.4, 12.4, 68, _shortH),
    labels: <PlateLabel>[
      _ink('رأس الخيمة', 10.6, 132.5, 83.7, 108, arabic: true),
      _ink('RAK', 37.6, 97.6, 114.6, 133.7),
      _ink('الامارات', 213, 322.5, 90, 112, arabic: true),
      _ink('UAE', 237, 296, 118.5, 138),
    ],
  );

  // -------------------------------------------------------------------------
  // Sharjah: a heavier frame, and a one-digit code (1 to 4) a plate may omit.
  // -------------------------------------------------------------------------

  /// Long: code (cx 48.4, y 23.7..76.7); "الشارقة" over "U.A.E  إ.ع.م" over
  /// "SHARJAH" at x 85..235; serial centres 262.8 + 51.3k, y 23.7..90.8.
  static final PlateSpec sharjahLong = _spec(
    id: 'ae.sharjah.long',
    long: true,
    borderWidthRatioOverride: _sharjahLongBorder,
    code: _cells(
      alphabet: UaeAlphabets.digits,
      count: 1,
      firstCx: 48.4,
      pitch: 40,
      y0: 23.7,
      y1: 76.7,
      canvasH: _longH,
    ),
    serial: _serial(262.8, 51.3, 23.7, 90.8, _longH),
    labels: <PlateLabel>[
      _ink('الشارقة', 85, 235, 16, 50, arabic: true),
      _ink('U.A.E', 103.5, 148.7, 55, 69),
      _ink('إ.ع.م', 168, 206, 55.5, 71, arabic: true),
      _ink('SHARJAH', 111, 201, 79, 93),
    ],
  );

  /// Short: "SHARJAH", the code (cx 155, y 12.9..43.6) and "الشارقة" across
  /// the top; serial centres 55.1 + 51.5k, y 52.2..118.9; "U.A.E" and "إ.ع.م"
  /// at the bottom corners.
  static final PlateSpec sharjahShort = _spec(
    id: 'ae.sharjah.short',
    long: false,
    borderWidthRatioOverride: _sharjahShortBorder,
    code: _cells(
      alphabet: UaeAlphabets.digits,
      count: 1,
      firstCx: 155,
      pitch: 28,
      y0: 12.9,
      y1: 43.6,
      canvasH: _shortH,
    ),
    serial: _serial(55.1, 51.5, 52.2, 118.9, _shortH),
    labels: <PlateLabel>[
      _ink('SHARJAH', 19, 130, 14, 29),
      _ink('الشارقة', 186.8, 314, 12.9, 38, arabic: true),
      _ink('U.A.E', 27, 83, 127, 142),
      _ink('إ.ع.م', 259, 307, 128.6, 145.3, arabic: true),
    ],
  );

  // -------------------------------------------------------------------------
  // Logo plates
  // -------------------------------------------------------------------------

  static PlateDecal _flag(double x0, double x1, double y0, double y1) =>
      PlateDecal(
        drawing: UaeCountry.flag,
        box: PlateBox.fromLTRB(x0, y0, x1, y1),
      );

  /// Abu Dhabi's shield: a red band, square on top and rounded below, with
  /// "أبوظبي" in white. The shield's art is approximated by the band.
  static List<PlateLabel> _shieldName(
    double x0,
    double x1,
    double y0,
    double y1,
  ) {
    // Sized by the shield's width: the bold face sets the word at about 2.6
    // times its ink height, wider than the reference's calligraphy.
    final ink = (x1 - x0 - 8) / 2.6;
    final cy = y0 + (y1 - y0) * 0.45;
    return <PlateLabel>[
      _ink(
        'أبوظبي',
        x0,
        x1,
        cy - ink / 2,
        cy + ink / 2,
        arabic: true,
        color: UaeColors.field,
      ),
    ];
  }

  static PlateBand _shield(double x0, double x1, double y0, double y1) =>
      PlateBand(
        box: PlateBox.fromLTRB(x0, y0, x1, y1),
        color: UaeColors.abuDhabiRed,
        topCornerRadius: 2,
        bottomCornerRadius: (x1 - x0) / 3,
      );

  /// Long: black code (centres 40.3, 76.1, y 15.7..65), the shield (x
  /// 123..164.5, y 16.8..66) over grey "AbuDhabi" (x 95..166, y 69..88.5),
  /// "الامارات / U.A.E" at x 188..233, and Ras Al Khaimah's serial.
  static final PlateSpec abuDhabiLogoLong = _spec(
    id: 'ae.abudhabi.logo.long',
    long: true,
    code: _cells(
      alphabet: UaeAlphabets.digits,
      count: 2,
      firstCx: 40.3,
      pitch: 35.8,
      y0: 15.7,
      y1: 65,
      canvasH: _longH,
    ),
    serial: _serial(276.2, 50.1, 21, 88.5, _longH),
    bands: <PlateBand>[_shield(123, 164.5, 16.8, 66)],
    labels: <PlateLabel>[
      ..._shieldName(123, 164.5, 16.8, 66),
      _ink('AbuDhabi', 95, 166, 74, 87, color: UaeColors.abuDhabiGrey),
      _ink('الامارات', 188.4, 232.9, 48.7, 61.8, arabic: true),
      _ink('U.A.E', 188.9, 231.9, 70.2, 82.8),
    ],
  );

  /// Short: black code top left (x 15.2..65.9, y 10.1..43.8), grey
  /// "AbuDhabi" (x 152..273, y 33.7..52.2) beside the shield (x 275..324,
  /// y 8.4..59); serial centres 55.1 + 55.5k, y 67.4..133.7; "أبوظبي" and
  /// "الامارات" small in the bottom corners.
  static final PlateSpec abuDhabiLogoShort = _spec(
    id: 'ae.abudhabi.logo.short',
    long: false,
    code: _cells(
      alphabet: UaeAlphabets.digits,
      count: 2,
      firstCx: 28,
      pitch: 25.3,
      y0: 10.1,
      y1: 43.8,
      canvasH: _shortH,
    ),
    serial: _serial(55.1, 55.5, 67.4, 133.7, _shortH),
    bands: <PlateBand>[_shield(275, 323.8, 8.4, 59)],
    labels: <PlateLabel>[
      ..._shieldName(275, 323.8, 8.4, 59),
      _ink('AbuDhabi', 152.3, 273, 37, 52.2, color: UaeColors.abuDhabiGrey),
      _ink('أبوظبي', 8.6, 39.6, 135.9, 148.3, arabic: true),
      _ink('الامارات', 290, 326.4, 136.5, 146, arabic: true),
    ],
  );

  /// "AJMAN" one colour per letter; [xs] are the letters' ink extents.
  static List<PlateLabel> _ajmanWord(
    List<(double, double)> xs,
    double y0,
    double y1,
  ) => <PlateLabel>[
    for (final (i, (x0, x1)) in xs.indexed)
      _ink(
        'AJMAN'[i],
        x0,
        x1,
        y0,
        y1,
        color: UaeColors.ajmanWord[i],
        glyphHeight: _wordGlyph(5, xs.first.$1, xs.last.$2, y0, y1),
      ),
  ];

  /// Long: letter and serial in one row (letter x 24.4..73.2, digit centres
  /// 104.5 + 55.1k, y 15.7..90.6), the flag (x 406..460, y 16.2..43) over
  /// "AJMAN" (y 57..84).
  static final PlateSpec ajmanLogoLong = _spec(
    id: 'ae.ajman.logo.long',
    long: true,
    code: _letter(48.8, 15.7, 90.6, _longH),
    serial: _serial(104.5, 55.1, 15.7, 90.6, _longH),
    decals: <PlateDecal>[_flag(405.9, 460, 16.2, 43)],
    labels: _ajmanWord(
      const [
        (367.7, 403),
        (404.3, 416),
        (417, 450),
        (451.6, 476.5),
        (478, 506),
      ],
      57,
      84,
    ),
  );

  /// Short: letter (x 13.8..59.4) and serial (x 67.9..316.5) in one row,
  /// y 19.7..79.7; the flag (x 28.4..82.4, y 104.5..128) beside "AJMAN"
  /// (x 135..307, y 108..137).
  static final PlateSpec ajmanLogoShort = _spec(
    id: 'ae.ajman.logo.short',
    long: false,
    code: _letter(36.6, 19.7, 79.7, _shortH, width: 44),
    serial: _serial(88.2, 52, 19.7, 79.7, _shortH),
    decals: <PlateDecal>[_flag(28.4, 82.4, 104.5, 128)],
    labels: _ajmanWord(
      const [
        (135.2, 180),
        (180.7, 195.2),
        (196.5, 237.4),
        (239.4, 270.4),
        (272.4, 307.3),
      ],
      108,
      137,
    ),
  );

  /// "أم القيوين", black "أم ال" then red "قيوين", one word across two labels:
  /// the zero-width joiners keep the lam joined to the qaf across the cut.
  /// The reference stacks the black half in calligraphy; set in one bold
  /// line, the word spans the measured [x0]..[x1] at one size, each half
  /// taking its share by character count, red on the left.
  static List<PlateLabel> _ummAlQuwainName(
    double x0,
    double x1,
    double y0,
    double y1,
  ) {
    final glyph = math.min(
      (y1 - y0) / _arabicInk,
      (x1 - x0) / (10 * _arabicAdvance),
    );
    final cut = (x0 + x1) / 2;
    return <PlateLabel>[
      _ink('أم ال\u200d', cut, x1, y0, y1, glyphHeight: glyph),
      _ink(
        '\u200dقيوين',
        x0,
        cut,
        y0,
        y1,
        color: UaeColors.flagRed,
        glyphHeight: glyph,
      ),
    ];
  }

  /// Long: the standard plate's letter and serial; the flag (x 125..179.3,
  /// y 18.9..45.6) over the name, black x 189.4..222.3, red x 96..186.8.
  static final PlateSpec ummAlQuwainLogoLong = _spec(
    id: 'ae.ummalquwain.logo.long',
    long: true,
    code: _letter(48.3, 15.7, 85, _longH),
    serial: _serial(257, 47.6, 16, 87, _longH),
    decals: <PlateDecal>[_flag(125, 179.3, 18.9, 45.6)],
    labels: _ummAlQuwainName(96, 222.3, 55, 90.6),
  );

  /// Short: the standard plate's letter and serial; the flag (x 42..109.5,
  /// y 112.3..141) then the name, red x 155..267.7, black x 271..312.
  static final PlateSpec ummAlQuwainLogoShort = _spec(
    id: 'ae.ummalquwain.logo.short',
    long: false,
    code: _letter(34.6, 16, 85.4, _shortH, width: 44),
    serial: _serial(97.7, 47, 15.7, 86, _shortH),
    decals: <PlateDecal>[_flag(42.2, 109.5, 112.3, 141)],
    labels: _ummAlQuwainName(155, 311.9, 103, 141.5),
  );

  // -------------------------------------------------------------------------
  // New plates: a double frame (a 2.2 mm line, white to 6.6, a 4.4 mm line
  // to 11, the same on both sizes), a condensed serial and the emirate's
  // calligraphic emblem. The emblem prints in the theme's ink, black or the
  // emirate's red ([UaeThemes.redEmblem]); everything else is pinned black.
  // -------------------------------------------------------------------------

  /// The inner line of the double frame: black from 6.6 mm in, white again
  /// from 11.
  static List<PlateBand> _innerFrame(double w, double h) => <PlateBand>[
    for (final (inset, color) in const [
      (6.6, UaeColors.ink),
      (11.0, UaeColors.field),
    ])
      PlateBand(
        box: PlateBox.fromLTRB(inset, inset, w - inset, h - inset),
        color: color,
        topCornerRadius: 17.6 - inset,
        bottomCornerRadius: 17.6 - inset,
      ),
  ];

  static PlateSpec _framed({
    required String id,
    required bool long,
    required PlateSlot code,
    required PlateSlot serial,
    required List<PlateLabel> labels,
  }) {
    final h = long ? _longH : _shortH;
    return _spec(
      id: id,
      long: long,
      code: _black(code),
      serial: _black(serial),
      labels: labels,
      bands: _innerFrame(long ? _longW : _shortW, h),
      borderWidthRatioOverride: 2.2 / h,
    );
  }

  /// [slot] pinned to black: on these plates the theme's ink is the emblem's.
  static PlateSlot _black(PlateSlot slot) => PlateSlot(
    alphabet: slot.alphabet,
    box: slot.box,
    length: slot.length,
    minLength: slot.minLength,
    spacing: slot.spacing,
    color: UaeColors.ink,
  );

  static const _newLongTop = 19.8, _newLongBottom = 90.2;
  static const _newShortTop = 71.4, _newShortBottom = 136.6;

  /// Long: letter cx 69.7; "الفجيرة" (x 137..199, y 26..66) over a small
  /// "الامارات / U.A.E" (x 155..183, y 72..87); serial 272.2 + 41.5k.
  static final PlateSpec fujairahNewLong = _framed(
    id: 'ae.fujairah.new.long',
    long: true,
    code: _letter(69.7, _newLongTop, _newLongBottom, _longH, width: 40),
    serial: _serial(272.2, 41.5, _newLongTop, _newLongBottom, _longH),
    labels: <PlateLabel>[
      _ink('الفجيرة', 137, 199, 26, 66, arabic: true),
      _ink('الامارات', 158, 180, 72, 77, arabic: true, color: UaeColors.ink),
      _ink('U.A.E', 155, 183, 81, 87, color: UaeColors.ink),
    ],
  );

  /// Short: the emblem top left (x 29..92, y 22..59), "U.A.E" (x 144..184,
  /// y 36..46), the letter top right (cx 280.3, y 18.4..55.1); serial
  /// 87.1 + 41.9k below.
  static final PlateSpec fujairahNewShort = _framed(
    id: 'ae.fujairah.new.short',
    long: false,
    code: _letter(280.3, 18.4, 55.1, _shortH, width: 34),
    serial: _serial(87.1, 41.9, _newShortTop, _newShortBottom, _shortH),
    labels: <PlateLabel>[
      _ink('الفجيرة', 29, 92, 22, 59, arabic: true),
      _ink('U.A.E', 144, 184, 36, 46, color: UaeColors.ink),
    ],
  );

  /// Long: the emblem "رأس / الخيمة" left (x 37.6..106, y 19.8..90), the
  /// letter cx 162.6, serial 261.1 + 41.5k.
  static final PlateSpec rasAlKhaimahNewLong = _framed(
    id: 'ae.rasalkhaimah.new.long',
    long: true,
    code: _letter(162.6, _newLongTop, _newLongBottom, _longH, width: 40),
    serial: _serial(261.1, 41.5, _newLongTop, _newLongBottom, _longH),
    labels: <PlateLabel>[
      _ink('رأس', 50, 94, 19.8, 52, arabic: true),
      _ink('الخيمة', 37.6, 106, 56, 90, arabic: true),
    ],
  );

  /// Short: a small emblem top left (x 33..62, y 32..53), the letter top
  /// right; the Fujairah short serial.
  static final PlateSpec rasAlKhaimahNewShort = _framed(
    id: 'ae.rasalkhaimah.new.short',
    long: false,
    code: _letter(280.3, 18.4, 55.1, _shortH, width: 34),
    serial: _serial(87.1, 41.9, _newShortTop, _newShortBottom, _shortH),
    labels: <PlateLabel>[_ink('رأس الخيمة', 30, 65, 32, 53, arabic: true)],
  );

  /// Long: letter cx 63.1; the emblem "أم / القيوين" (x 121.7..174.8,
  /// y 22..79) over "UMM AL QUWAIN" (x 119..166, y 86..91); serial
  /// 241.2 + 50.9k.
  static final PlateSpec ummAlQuwainNewLong = _framed(
    id: 'ae.ummalquwain.new.long',
    long: true,
    code: _letter(63.1, _newLongTop, _newLongBottom, _longH, width: 40),
    serial: _serial(241.2, 50.9, _newLongTop, _newLongBottom, _longH),
    labels: <PlateLabel>[
      _ink('أم', 135, 160, 22, 48, arabic: true),
      _ink('القيوين', 121.7, 174.8, 51, 79, arabic: true),
      _ink('UMM AL QUWAIN', 119, 166, 86, 91, color: UaeColors.ink),
    ],
  );

  /// Short: the letter top left (cx 46.7, y 20.4..57.1), the emblem top
  /// right (x 266..304, y 22..57) over its caption; serial 81.4 + 44.85k.
  static final PlateSpec ummAlQuwainNewShort = _framed(
    id: 'ae.ummalquwain.new.short',
    long: false,
    code: _letter(46.7, 20.4, 57.1, _shortH, width: 34),
    serial: _serial(81.4, 44.85, _newShortTop, _newShortBottom, _shortH),
    labels: <PlateLabel>[
      _ink('أم القيوين', 264, 306, 24, 52, arabic: true),
      _ink('UMM AL QUWAIN', 266, 304, 56, 59.5, color: UaeColors.ink),
    ],
  );

  /// Every spec, for galleries and tests.
  static final List<PlateSpec> all = <PlateSpec>[
    abuDhabiLong,
    abuDhabiShort,
    abuDhabiLogoLong,
    abuDhabiLogoShort,
    ajmanLong,
    ajmanShort,
    ajmanLogoLong,
    ajmanLogoShort,
    dubaiLong,
    dubaiShort,
    dubaiColouredLong,
    dubaiColouredShort,
    fujairahLong,
    fujairahShort,
    fujairahNewLong,
    fujairahNewShort,
    rasAlKhaimahLong,
    rasAlKhaimahShort,
    rasAlKhaimahNewLong,
    rasAlKhaimahNewShort,
    sharjahLong,
    sharjahShort,
    ummAlQuwainLong,
    ummAlQuwainShort,
    ummAlQuwainLogoLong,
    ummAlQuwainLogoShort,
    ummAlQuwainNewLong,
    ummAlQuwainNewShort,
  ];
}
