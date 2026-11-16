import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'belize_alphabets.dart';
import 'belize_country.dart';

/// Where the ink sits. The article documents 152×300 mm (6×12 in). The
/// references were flattened by `tools/platekit` to a plate 152 units wide and
/// measured there (`brief.md`, rows column); every figure below is in those
/// *flat* units and [_u] multiplies it by 300/152 into the 300×152 canvas.
///
/// **Glyph size.** `glyphStyle` sets the font at 0.72 of the slot and a bold
/// cap is ~0.75 of that, so ink ≈ 0.55 × the height written. Captions are set
/// at ink / 0.55.
///
/// **Under-height serials, accepted.** Every serial is ~35–45 flat units of
/// ink in the references, which would need a ~125 slot. The real faces are far
/// narrower than DejaVu Bold, and a run wider than its box is scaled down
/// whole, so each serial is as tall as its run fits —
/// [advance] × height × characters ≤ the measured run width — which leaves the
/// ink about 55–80% of the reference. `plate_core` is unchanged.
///
/// **Measured vs estimated.** Every caption and serial extent is from the
/// brief's rows. Estimated from `sheet_flat.png` because the rows merge or
/// omit them: the dealer's "AUTO DEALER" line and serial rows, the separators
/// (dot, dash), the stacked district codes, and the right-hand ends of the city
/// captions (the row's extent includes the red mounting tab). All are marked
/// `est.` below.
///
/// **Not modelled**, and why: the 1973–81 and 1980s series (history; only the
/// current 2000s design is built); the motorcycle plate (`M-1234`; its only
/// picture, `Blank_License_Plate_Shape`, is an empty outline with no ink to
/// measure); the twin-town plate's seal and small council line (a raster with
/// no vector); the mounting slots and screw holes; the stickers.
abstract final class _Layout {
  static const double width = 300, height = 152;

  /// Flat units → canvas units: 300 / 152.
  static const double scale = width / 152;

  /// Width of one DejaVu Bold digit/cap per unit of slot height: 0.72 × 0.696,
  /// rounded up a little so a run fits its box.
  static const double advance = 0.51;

  /// Ink height as a fraction of the box height written.
  static const double ink = 0.55;

  /// Thickness of a printed dash or dot, flat units (est. from the sheet).
  static const double mark = 4.5;
}

double _u(double flat) => flat * _Layout.scale;

/// A measured rectangle of ink, in flat units.
@immutable
class _Ink {
  const _Ink(this.x0, this.x1, this.y0, this.y1);

  final double x0, x1, y0, y1;

  double get cx => (x0 + x1) / 2;
  double get cy => (y0 + y1) / 2;
  double get w => x1 - x0;
  double get h => y1 - y0;
}

/// A printed line of lettering.
@immutable
class _Caption {
  const _Caption(this.text, this.ink);

  final String text;
  final _Ink ink;
}

/// A district code stacked one letter per line down a side (`B` over `Z`).
/// [charInk] is one letter's ink height.
@immutable
class _Stack {
  const _Stack(this.text, this.ink, this.charInk);

  final String text;
  final _Ink ink;
  final double charInk;
}

/// The printed separator between prefix and serial.
enum _Mark { none, dot, dash }

/// One plate design: captions, side codes, a prefix field, a separator and a
/// serial field. Colour is the theme's.
@immutable
class _Design {
  const _Design({
    required this.id,
    required this.row,
    required this.digits,
    required this.digitsMin,
    required this.digitsShown,
    required this.captions,
    this.prefix,
    this.prefixLength = 1,
    this.mark = _Mark.none,
    this.markX0 = 0,
    this.markX1 = 0,
    this.stacks = const <_Stack>[],
  });

  final String id;

  /// Serial row: x of the digits run as photographed, y of the row.
  final _Ink row;
  final int digits, digitsMin;

  /// How many digits the photograph shows; the run's measured width is for
  /// this many, so the glyph height is fitted to it.
  final int digitsShown;
  final List<_Caption> captions;

  /// Ink of the prefix field, or null (dealer plates have none).
  final _Ink? prefix;
  final int prefixLength;
  final _Mark mark;
  final double markX0, markX1;
  final List<_Stack> stacks;
}

/// Belize's plate series.
///
/// Every series is one design: caption lines, optional side codes, a prefix
/// field (one letter, or three on the defence plate), a printed dot or dash,
/// and one digit field — all data in a [_Design]; colour is the theme's.
///
/// Slots: `prefix` (a letter run) when present, then `serial` (3–5 digits,
/// fixed 5 on the dealer plate). Text groups index slots, one each.
///
/// Flat-unit measurements (`brief.md`), serial row / digits run:
/// * [standard] — clean artwork, `BZ` stacked at x 8..18.8, caption
///   `BELIZE C.A.` y 5.2..14.8 x 34.8..117.5, row y 23.8..58.5, `C` x
///   35.5..52.8, digits x 69.5..141 (4 shown, pitch 17.8).
/// * [city] — c.2000, caption y 5.8..14.2 x 37.5..118, row y 22.2..56.5, `C`
///   x 9.5..27, dash, digits x 54..143.2 (5 shown), `BELIZE CITY` y 62.2..70.5.
/// * [twin] — 2009, caption y 11.5..17.8 x 46.8..111.2, row y 22.5..53.5, `C`
///   x 15.5..31.8, digits x 45.8..139 (5 shown), `SI` / `SE` side codes.
/// * [dealer] — orange, `BELIZE, C.A.` y 5.2..15.2, `AUTO DEALER` (est.), five
///   digits x 28.2..125.2.
/// * [truck] — black, `BELIZE, C.A.` y 5.2..14.8, `A` x 9..43, dash, three
///   digits x 63..140 (tracked wide), row y 15.8..60, `BELIZE CITY` y
///   62.5..70.5 x 39.2..108.5.
/// * [defence] — brown, `DFS` x 9.8..69, dash, three digits x 88..137, row y
///   19.8..54, `BELIZE C.A.` (est. y 58..67); no top caption.
/// * [taxi] — green, `D` x 25..48, four digits x 52..134, row y 16.2..57.5,
///   `BELIZE C.A.` y 5.2..14.2 x 47.5..111.8, `BELIZE CITY` y 60..69.5 x
///   43.2..112.5; no separator.
///
/// The article's formats are `A-1234`/`A-12345` (letter, dash, four or five
/// digits), `12345`, `ABC-123`. Where a picture shows another length the
/// picture wins (`A-816`; the taxi has no dash): the digit field's `length`
/// is the article's maximum and `digitsMin` the picture's or the article's
/// minimum, whichever is lower.
abstract final class BelizePlates {
  static const PlateAlphabet _letters = BelizeAlphabets.letters;
  static const PlateAlphabet _digits = BelizeAlphabets.digits;

  static const List<PlateTextGroup> _serialOnly = <PlateTextGroup>[
    PlateTextGroup(<int>[0], key: 'serial'),
  ];
  static const List<PlateTextGroup> _prefixed = <PlateTextGroup>[
    PlateTextGroup(<int>[0], key: 'prefix'),
    PlateTextGroup(<int>[1], key: 'serial'),
  ];

  /// A box of [width] × [height] centred on ([cx], [cy]), kept on the canvas.
  static PlateBox _centred(double cx, double cy, double width, double height) {
    final double w = width.clamp(0, _Layout.width).toDouble();
    final double left = (cx - w / 2).clamp(0, _Layout.width - w).toDouble();
    return PlateBox(left, cy - height / 2, w, height);
  }

  static PlateLabel _label(String text, _Ink ink, double inkHeight) {
    final double glyph = _u(inkHeight) / _Layout.ink;
    return PlateLabel(
      text: text,
      box: _centred(_u(ink.cx), _u(ink.cy), _u(ink.w) * 1.2, glyph),
      glyphHeight: glyph,
    );
  }

  static PlateSpec _plate(_Design d) {
    final double digitsWidth = _u(d.row.w);
    final double h = (_u(d.row.h) / _Layout.ink)
        .clamp(0, digitsWidth / (_Layout.advance * d.digitsShown))
        .toDouble();
    final double top = _u(d.row.cy) - h / 2;
    final _Ink? p = d.prefix;
    final double prefixWidth = p == null
        ? 0
        : (_u(p.w) > _Layout.advance * h * d.prefixLength
              ? _u(p.w)
              : _Layout.advance * h * d.prefixLength);
    return PlateSpec(
      id: d.id,
      country: BelizeCountry.belize,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      noPanel: true,
      panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
      slots: <PlateSlot>[
        if (p != null)
          PlateSlot(
            alphabet: _letters,
            box: _centred(_u(p.cx), _u(d.row.cy), prefixWidth, h),
            length: d.prefixLength,
          ),
        PlateSlot(
          alphabet: _digits,
          box: PlateBox(_u(d.row.x0), top, digitsWidth, h),
          length: d.digits,
          minLength: d.digitsMin,
        ),
      ],
      rules: <PlateRule>[
        if (d.mark != _Mark.none)
          PlateRule(
            box: _centred(
              _u((d.markX0 + d.markX1) / 2),
              _u(d.row.cy),
              _u(d.mark == _Mark.dot ? _Layout.mark : d.markX1 - d.markX0),
              _u(_Layout.mark),
            ),
          ),
      ],
      labels: <PlateLabel>[
        for (final _Caption c in d.captions) _label(c.text, c.ink, c.ink.h),
        for (final _Stack s in d.stacks)
          for (int i = 0; i < s.text.length; i++)
            _label(
              s.text[i],
              _Ink(
                s.ink.x0,
                s.ink.x1,
                s.ink.y0 +
                    (s.ink.h - s.charInk) *
                        (s.text.length == 1 ? 0 : i / (s.text.length - 1)),
                s.ink.y0 +
                    (s.ink.h - s.charInk) *
                        (s.text.length == 1 ? 0 : i / (s.text.length - 1)) +
                    s.charInk,
              ),
              s.charInk,
            ),
      ],
      textGroups: p == null ? _serialOnly : _prefixed,
    );
  }

  /// Passenger plate, current artwork: `BZ` stacked at the left, `C·4198`.
  /// Dot at x 59..63 and the stacked letters' split are est. from the sheet.
  static final PlateSpec standard = _plate(
    const _Design(
      id: 'bz.standard',
      row: _Ink(69.5, 141, 23.8, 58.5),
      digits: 5,
      digitsMin: 4,
      digitsShown: 4,
      prefix: _Ink(35.5, 52.8, 23.8, 58.5),
      mark: _Mark.dot,
      markX0: 59,
      markX1: 63,
      captions: <_Caption>[
        _Caption('BELIZE C.A.', _Ink(34.8, 117.5, 5.2, 14.8)),
      ],
      stacks: <_Stack>[_Stack('BZ', _Ink(8, 18.8, 23.8, 58.5), 12.5)],
    ),
  );

  /// c.2000 reflective plate with the city named below (`BELIZE CITY`).
  static final PlateSpec city = _plate(
    const _Design(
      id: 'bz.city',
      row: _Ink(54, 143.2, 22.2, 56.5),
      digits: 5,
      digitsMin: 4,
      digitsShown: 5,
      prefix: _Ink(9.5, 27, 22.2, 56.5),
      mark: _Mark.dash,
      markX0: 34,
      markX1: 45,
      captions: <_Caption>[
        _Caption('BELIZE C.A.', _Ink(37.5, 118, 5.8, 14.2)),
        _Caption('BELIZE CITY', _Ink(38.2, 116, 62.2, 70.5)),
      ],
    ),
  );

  /// 2009 plate: rimmed, with the district codes of the twin towns
  /// (`SI` San Ignacio / `SE` Santa Elena) stacked at both sides (est. x/y
  /// from the sheet; the seal and council line are not drawn).
  static final PlateSpec twin = _plate(
    const _Design(
      id: 'bz.twin',
      row: _Ink(45.8, 139, 22.5, 53.5),
      digits: 5,
      digitsMin: 4,
      digitsShown: 5,
      prefix: _Ink(15.5, 31.8, 22.5, 53.5),
      mark: _Mark.dash,
      markX0: 34,
      markX1: 43,
      captions: <_Caption>[
        _Caption('BELIZE C.A.', _Ink(46.8, 111.2, 11.5, 17.8)),
      ],
      stacks: <_Stack>[
        _Stack('SI', _Ink(4, 11.5, 24, 49), 8),
        _Stack('SE', _Ink(140, 148, 24, 49), 8),
      ],
    ),
  );

  /// Auto dealers: five digits, no prefix, two caption lines.
  static final PlateSpec dealer = _plate(
    const _Design(
      id: 'bz.dealer',
      row: _Ink(28.2, 125.2, 28.4, 66.7),
      digits: 5,
      digitsMin: 5,
      digitsShown: 5,
      captions: <_Caption>[
        _Caption('BELIZE, C.A.', _Ink(29.5, 136.8, 5.2, 15.2)),
        _Caption('AUTO DEALER', _Ink(34, 123, 17, 25.6)),
      ],
    ),
  );

  /// Agricultural and commercial trucks: `A-816`, the picture's three digits
  /// against the article's `A-12345`.
  static final PlateSpec truck = _plate(
    const _Design(
      id: 'bz.truck',
      row: _Ink(63, 140, 15.8, 60),
      digits: 5,
      digitsMin: 3,
      digitsShown: 3,
      prefix: _Ink(9, 43, 15.8, 60),
      mark: _Mark.dash,
      markX0: 47.5,
      markX1: 61.5,
      captions: <_Caption>[
        _Caption('BELIZE, C.A.', _Ink(23.5, 129.2, 5.2, 14.8)),
        _Caption('BELIZE CITY', _Ink(39.2, 108.5, 62.5, 70.5)),
      ],
    ),
  );

  /// Defence Ministry: `DFS-041`; only a bottom caption.
  static final PlateSpec defence = _plate(
    const _Design(
      id: 'bz.defence',
      row: _Ink(88, 137, 19.8, 54),
      digits: 3,
      digitsMin: 3,
      digitsShown: 3,
      prefix: _Ink(9.8, 69, 19.8, 54),
      prefixLength: 3,
      mark: _Mark.dash,
      markX0: 72,
      markX1: 86,
      captions: <_Caption>[_Caption('BELIZE C.A.', _Ink(36, 110, 58, 67))],
    ),
  );

  /// Taxis and public service: `D3217` with no separator, picture over the
  /// article's `A-12345`.
  static final PlateSpec taxi = _plate(
    const _Design(
      id: 'bz.taxi',
      row: _Ink(52, 134, 16.2, 57.5),
      digits: 5,
      digitsMin: 4,
      digitsShown: 4,
      prefix: _Ink(25, 48, 16.2, 57.5),
      captions: <_Caption>[
        _Caption('BELIZE C.A.', _Ink(47.5, 111.8, 5.2, 14.2)),
        _Caption('BELIZE CITY', _Ink(43.2, 112.5, 60, 69.5)),
      ],
    ),
  );
}
