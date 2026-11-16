import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'australia_colors.dart';
import 'australia_country.dart';
import 'australia_formats.dart';

/// Where the ink sits on an Australian plate, in plate units.
///
/// The article gives 372×134 mm; the flattened photographs measure 2.85 (the
/// median fit, see `size_conflict.json`) against its 2.78, and the brief's
/// rows are in a 520-wide frame. **The canvas is 520×183** — the photographs'
/// frame, so the measured spans below are used as they are. Every x-span is a
/// field's ink extent from the brief's rows table, or, where the table merges
/// glyphs across a logo, read off `sheet_flat.png` (each tile is 540 px for
/// 520 units, so units = px × 0.963; good to about ±5): TAS, VIC, ACT, the
/// ADO and the diplomatic plate.
///
/// * Serial row ink is 114–121 tall on the references (y 24–138 on NSW) and
///   the caption row 24 tall (y 145.5–170).
/// * **Under-height serial, accepted.** 114 of ink would need a box ~207 tall
///   on a 183 plate (`glyphStyle` sets 0.72 of the box, a bold cap ~0.75 of
///   that). The box is 140, and DejaVu Bold is wider than the plates' face, so
///   a field that fills its span is scaled down as a whole; the real face has
///   room. `plate_core` is unchanged.
/// * Captions are sized from their ink height (÷ 0.55), capped so the text
///   fits its span at ~0.54 of the glyph height per character.
abstract final class _Layout {
  static const double width = 520, height = 183;

  /// Serial slot height, and the centre of the serial ink on the usual plate
  /// (NSW rows y 23.8–138.2).
  static const double serialHeight = 140, serialCentre = 81;

  /// Bottom legend: ink y 145.5–170 on NSW/SA/QLD, centre 158, 24 tall.
  static const double legendCentre = 158, legendInk = 24;

  /// Top legend of the army plate: ink y 12.8–32.5, centre 23, 19.7 tall.
  static const double topLegendCentre = 23, topLegendInk = 19.7;

  /// Legend glyph height over ink height, from the 0.72 × 0.75 chain.
  static const double inkToGlyph = 1 / 0.55;

  /// Width of a character of a bold face over the glyph height.
  static const double charPerGlyph = 0.54;

  /// The dot between fields, centred on the gap.
  static const double dotWidth = 20, dotGlyph = 30;
}

class _Legend {
  const _Legend(
    this.text,
    this.left,
    this.right, {
    this.centre = _Layout.legendCentre,
    this.ink = _Layout.legendInk,
    this.color,
  });

  final String text;
  final double left, right, centre, ink;
  final Color? color;
}

/// Australia's plate geometries: one spec per jurisdiction, sharing [_plate];
/// only the fields' spans, legend and background differ.
///
/// Every spec has one slot per field (a run printed and typed as a unit) with
/// text groups `f0`, `f1`, … — the validator, the generator and the gallery
/// read them. Lengths come from [AustraliaFormats].
///
/// Not implemented: the older series (the article lists many per state),
/// slimline "Premium", motorcycle, trailer and the other special-purpose
/// plates (club, rally, taxi, farm…), which differ in fields and legend only;
/// the alternative-fuel stickers; the 1970s–90s Commonwealth plates; the
/// Governor-General's crown plate, the Prime Minister's `C*1` and the Chief of
/// Army's plate, which are one-offs. The logos printed on some plates (the
/// Tasmanian thylacine, the Victorian V, the WA sun, the RAAF roundel) are
/// emblems and are left out.
abstract final class AustraliaPlates {
  static PlateSlot _slot(
    AustraliaField f,
    double left,
    double right,
    double centre,
  ) {
    const double h = _Layout.serialHeight;
    final double w = right - left;
    return PlateSlot(
      alphabet: f.alphabet,
      box: PlateBox(left, centre - h / 2, w, h),
      length: f.length,
      minLength: f.min,
      spacing: f.min == null ? plateRunSpacing(w / f.length, h) : 0,
    );
  }

  static PlateLabel _dot(double x, double centre) => PlateLabel(
    text: '•',
    box: PlateBox.centered(x, centre, _Layout.dotWidth, _Layout.dotGlyph),
    glyphHeight: _Layout.dotGlyph,
  );

  static PlateLabel _legend(_Legend l) {
    final double span = l.right - l.left;
    final double glyph = min(
      l.ink * _Layout.inkToGlyph,
      span / (l.text.length * _Layout.charPerGlyph),
    );
    return PlateLabel(
      text: l.text,
      box: PlateBox(l.left, l.centre - glyph / 2, span, glyph),
      glyphHeight: glyph,
      color: l.color,
    );
  }

  /// A one-row-of-fields plate. [spans] are each field's (left, right);
  /// [dots] are the x of the dots between fields; [legends] the printed
  /// words.
  static PlateSpec _plate({
    required String id,
    required List<AustraliaField> fields,
    required List<(double, double)> spans,
    List<double> dots = const <double>[],
    List<_Legend> legends = const <_Legend>[],
    double centre = _Layout.serialCentre,
    PlateSection background = PlateSection.plain,
  }) {
    assert(fields.length == spans.length);
    return PlateSpec(
      id: id,
      country: AustraliaCountry.australia,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      noPanel: true,
      panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
      background: background,
      slots: <PlateSlot>[
        for (var i = 0; i < fields.length; i++)
          _slot(fields[i], spans[i].$1, spans[i].$2, centre),
      ],
      labels: <PlateLabel>[
        for (final double x in dots) _dot(x, centre),
        for (final _Legend l in legends) _legend(l),
      ],
      textGroups: <PlateTextGroup>[
        for (var i = 0; i < fields.length; i++)
          PlateTextGroup(<int>[i], key: australiaFieldKey(i)),
      ],
    );
  }

  /// A band of [color] over a part of the plate, edge to edge, in the
  /// background; [bottom] puts it under the field, else over it.
  static PlateSection _band(
    PlateFill color,
    double end, {
    bool bottom = false,
  }) {
    final PlatePart band = PlatePart(
      PlateSection.fill(color),
      end: bottom ? null : end,
    );
    return PlateSection.rows(<PlatePart>[
      if (bottom) PlatePart(PlateSection.plain, end: end),
      band,
      if (!bottom) const PlatePart(PlateSection.plain),
    ]);
  }

  /// NSW `DT·00·CC`, black on yellow. Fields x 23–140, 198–322, 370–497 and
  /// legend ink x 83.5–438 (the brief's rows).
  static final PlateSpec nsw = _plate(
    id: 'au.nsw',
    fields: AustraliaFormats.nsw,
    spans: _threeFields,
    dots: _threeDots,
    legends: const <_Legend>[_Legend('NEW SOUTH WALES', 83.5, 438.2)],
  );

  /// NT `CG·72·AA`: the same layout as NSW, legend "N.T. OUTBACK AUSTRALIA"
  /// on x 30.8–475 of the photograph.
  static final PlateSpec nt = _plate(
    id: 'au.nt',
    fields: AustraliaFormats.nt,
    spans: _threeFields,
    dots: _threeDots,
    legends: const <_Legend>[_Legend('N.T.  OUTBACK  AUSTRALIA', 30.8, 475)],
  );

  /// Federal Interstate `VV·59·JO` (1987–2018), green on yellow: the same
  /// layout as NSW. Spans from its own photo: 30–152, 183–284 (letters and
  /// digits), 311–499.
  static final PlateSpec federalInterstate = _plate(
    id: 'au.federalInterstate',
    fields: AustraliaFormats.federalInterstate,
    spans: const <(double, double)>[(30, 152), (183, 284), (310, 499)],
    dots: const <double>[168, 297],
    legends: const <_Legend>[_Legend('FEDERAL  INTERSTATE', 62.8, 466.5)],
  );

  static const List<(double, double)> _threeFields = <(double, double)>[
    (23.2, 139.5),
    (198.2, 322),
    (370, 497),
  ];
  static const List<double> _threeDots = <double>[169, 346];

  /// ACT `YRU·00A`, blue on white. Fields x 43–250 and 308–491 read off the
  /// sheet; legend ink x 36–491 ("CANBERRA – THE NATION'S CAPITAL").
  static final PlateSpec act = _plate(
    id: 'au.act',
    fields: AustraliaFormats.act,
    spans: const <(double, double)>[(43, 250), (308, 491)],
    dots: const <double>[279],
    legends: const <_Legend>[
      _Legend("CANBERRA - THE NATION'S CAPITAL", 36, 491.2),
    ],
  );

  /// QLD `000·RQ3`, maroon on white; fields x 23.5–216 and 272–492.
  static final PlateSpec qld = _plate(
    id: 'au.qld',
    fields: AustraliaFormats.qld,
    spans: const <(double, double)>[(23.5, 216), (272.2, 491.8)],
    dots: const <double>[244],
    legends: const <_Legend>[
      _Legend('QUEENSLAND - SUNSHINE STATE', 30.2, 489.5),
    ],
  );

  /// SA `S000·DOB`, black on white; fields x 26–255.5 and 304–490.
  static final PlateSpec sa = _plate(
    id: 'au.sa',
    fields: AustraliaFormats.sa,
    spans: const <(double, double)>[(26.2, 255.5), (304.2, 490)],
    dots: const <double>[280],
    legends: const <_Legend>[_Legend('SOUTH AUSTRALIA', 110.8, 412)],
  );

  /// TAS `N 00 NH`, blue on white. Fields read off the sheet: x 24–96,
  /// 197–318, 366–496; the thylacine logo sits between the first two and is
  /// not drawn. Legend "Tasmania - Explore the possibilities" at x 40–490.
  static final PlateSpec tas = _plate(
    id: 'au.tas',
    fields: AustraliaFormats.tas,
    spans: const <(double, double)>[(24, 96), (197, 318), (366, 496)],
    legends: const <_Legend>[
      _Legend('Tasmania - Explore the possibilities', 40, 490),
    ],
  );

  /// VIC `1NC·1QD`, blue on white. Fields read off the sheet: x 34–222 and
  /// 325–496; the V logo between them is not drawn. Legend ink x 33.8–485.5.
  static final PlateSpec vic = _plate(
    id: 'au.vic',
    fields: AustraliaFormats.vic,
    spans: const <(double, double)>[(34, 222), (325, 496)],
    centre: 80,
    legends: const <_Legend>[
      _Legend('VICTORIA - THE EDUCATION STATE', 33.8, 485.5),
    ],
  );

  /// WA `1JDO·000`, blue on white with a blue band across the top carrying
  /// "WESTERN AUSTRALIA" in white. Serial ink y 61.8–162.5 (centre 112),
  /// fields x 35–275 and 327–488; the band's lower edge, y ~52, is read off
  /// the sheet. The sun motif is not drawn.
  static final PlateSpec wa = _plate(
    id: 'au.wa',
    fields: AustraliaFormats.wa,
    spans: const <(double, double)>[(35, 275), (327.2, 488.2)],
    dots: const <double>[301],
    centre: 112,
    background: _band(PlateFill.divider, 52),
    legends: const <_Legend>[
      _Legend(
        'WESTERN  AUSTRALIA',
        20.8,
        499,
        centre: 29,
        ink: 32,
        color: AustraliaColors.white,
      ),
    ],
  );

  /// National Heavy Vehicle `XS·99AA`, black on white with a blue band across
  /// the bottom (y 144 to the edge, `2E40AD`) carrying the legend in white.
  /// Fields x 25.5–170 and 214–495.
  static final PlateSpec nationalHeavyVehicle = _plate(
    id: 'au.nationalHeavyVehicle',
    fields: AustraliaFormats.nationalHeavyVehicle,
    spans: const <(double, double)>[(25.5, 169.8), (214, 495.2)],
    dots: const <double>[192],
    background: _band(
      const PlateFill.color(AustraliaColors.heavyBand),
      144,
      bottom: true,
    ),
    legends: const <_Legend>[
      _Legend(
        'NATIONAL HEAVY VEHICLE',
        108,
        412,
        centre: 156,
        color: AustraliaColors.white,
      ),
    ],
  );

  /// Army `92·0982`, green on grey-white (1989–2002, with the three-digit
  /// 1972 form as `minLength`). "ARMY" ink x 218–312, y 12.8–32; serial ink
  /// y 43–165 (centre 104); fields x 47.5–170 and 226.5–483.
  static final PlateSpec army = _plate(
    id: 'au.army',
    fields: AustraliaFormats.army,
    spans: const <(double, double)>[(47.5, 169.2), (226.5, 482.8)],
    dots: const <double>[198],
    centre: 104,
    legends: const <_Legend>[
      _Legend(
        'ARMY',
        218,
        311.8,
        centre: _Layout.topLegendCentre,
        ink: _Layout.topLegendInk,
      ),
    ],
  );

  /// RAAF `235358` (from about 2000), navy on cream, "AIR FORCE" above and
  /// "AIRPOWER FOR AUSTRALIA'S SECURITY" below in red. Digits x 100–495,
  /// ink y 36.8–147 (centre 92); the roundel left of them is not drawn.
  static final PlateSpec airForce = _plate(
    id: 'au.airForce',
    fields: AustraliaFormats.airForce,
    spans: const <(double, double)>[(100, 495)],
    centre: 92,
    legends: const <_Legend>[
      _Legend(
        'AIR FORCE',
        115,
        412.5,
        centre: 23,
        ink: 20.7,
        color: AustraliaColors.airForceRed,
      ),
      _Legend(
        "AIRPOWER FOR AUSTRALIA'S SECURITY",
        60,
        463.5,
        centre: 162,
        ink: 16,
        color: AustraliaColors.airForceRed,
      ),
    ],
  );

  /// Australian Defence Organisation `F16L01`, blue on white, legend
  /// "AUSTRALIAN DEFENCE ORGANISATION" at y 145.8–162.5. Fields read off the
  /// sheet: x 48–108 and 130–445; serial ink y 22–133 (centre 78).
  static final PlateSpec defence = _plate(
    id: 'au.defence',
    fields: AustraliaFormats.defence,
    spans: const <(double, double)>[(48, 108), (130, 445)],
    centre: 78,
    legends: const <_Legend>[
      _Legend(
        'AUSTRALIAN DEFENCE ORGANISATION',
        48.8,
        471.2,
        centre: 154,
        ink: 16.7,
      ),
    ],
  );

  /// Diplomatic Corps `DC 7901`, black on powder blue, no legend; serial ink
  /// y 34–160 (centre 97). Fields read off the sheet: x 30–226 for the `DC`
  /// (printed `D.C.`, the dots are not modelled) and 250–481.
  static final PlateSpec diplomatic = _plate(
    id: 'au.diplomatic',
    fields: AustraliaFormats.diplomatic,
    spans: const <(double, double)>[(30, 226), (250, 481)],
    dots: const <double>[238],
    centre: 97,
  );
}
