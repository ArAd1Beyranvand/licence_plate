import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'nigeria_colors.dart';
import 'nigeria_country.dart';

/// Where the ink sits, in plate coordinates (300×152 mm, the article's size).
///
/// Measured off the clean Lagos artwork `____2012`, flattened to 152×76 units
/// and scaled by 300/152 = 1.974 on both axes (the artwork is 2.00, the
/// documented plate 1.97):
///
/// * Ink row y 24.0..56.5 units (64 mm), centre 40.25.
/// * Glyph runs, units: `GGE` 6.0..53.2 (pitch 16.8), dash 62.2..66.5,
///   `123` centred 71.8..110.8 (pitch 16.4 from the `2` and `3`; the `1` is
///   narrow), `ZY` 113.8..143.5 (pitch 16.1).
/// * Flag sticker x 6.5..28, y 4.5..18.5 (the two green strips' extent).
///
/// The state name and slogan rows and the "FEDERAL REPUBLIC OF NIGERIA" line
/// are estimated off the contact sheet, **not measured**. The green skyline
/// and the pale map of Nigeria behind the number are not drawn: no shape the
/// spec can draw, and an emblem decal would need an asset.
///
/// Ink is ~55% of the glyph box, so 64 mm of ink asks for a 117 mm box.
abstract final class _Layout {
  static const double scale = 300 / 152, width = 300, height = 152;

  static const double cy = 40.25 * scale, box = 117, top = cy - box / 2;

  static const double areaLeft = (12.75 - 16.8 / 2) * scale;
  static const double areaPitch = 16.8 * scale;
  static const double serialLeft = (87.65 - 1.5 * 16.4) * scale;
  static const double serialPitch = 16.4 * scale;
  static const double suffixLeft = (120.65 - 16.1 / 2) * scale;
  static const double suffixPitch = 16.1 * scale;

  static const double dashCx = 64.35 * scale, dashWidth = 12;

  static const PlateBox flag = PlateBox(
    6.5 * scale,
    4.5 * scale,
    21.5 * scale,
    14 * scale,
  );

  static const double captionCx = 74.5 * scale, captionWidth = 90 * scale;
  static const double nameCy = 8 * scale, nameGlyph = 22;
  static const double sloganCy = 15.3 * scale, sloganGlyph = 14;
  static const double footerCy = 67.5 * scale, footerGlyph = 13;
}

/// The 2011 plate: three letters (area), three digits, two letters, under a
/// flag sticker and the state's name and slogan. Groups `area`, `serial`,
/// `suffix`. One design for every state; colour is the theme's — pair with
/// [NigeriaThemes.private] or [NigeriaThemes.commercial].
///
/// Only the state caption differs, so each state is one [_state] call. The
/// 36 states and the Federal Capital Territory share the design; those below
/// are the ones with a reference photograph. Not implemented: the 1992
/// series, and the Kogi and Niger plates that mix letters and digits in the
/// first field. The article names nothing Israel-specific.
abstract final class NigeriaPlates {
  static final PlateSpec lagos = _state(
    'lagos',
    'LAGOS',
    'CENTRE OF EXCELLENCE',
  );
  static final PlateSpec federalCapital = _state(
    'fct',
    'ABUJA',
    'CENTRE OF UNITY',
  );
  static final PlateSpec adamawa = _state(
    'adamawa',
    'ADAMAWA',
    'LAND OF BEAUTY',
  );
  static final PlateSpec benue = _state(
    'benue',
    'BENUE',
    'FOOD BASKET OF THE NATION',
  );
  static final PlateSpec sokoto = _state(
    'sokoto',
    'SOKOTO',
    'SEAT OF THE CALIPHATE',
  );

  static List<PlateSpec> get all => <PlateSpec>[
    lagos,
    federalCapital,
    adamawa,
    benue,
    sokoto,
  ];

  static PlateSlot _field(
    PlateAlphabet alphabet,
    int count,
    double left,
    double pitch,
  ) => plateRun(
    alphabet,
    count,
    left: left,
    top: _Layout.top,
    pitch: pitch,
    height: _Layout.box,
  );

  static PlateLabel _caption(
    String text,
    double cy,
    double glyph, {
    double width = _Layout.captionWidth,
  }) => PlateLabel(
    text: text,
    box: PlateBox.centered(_Layout.captionCx, cy, width, glyph),
    glyphHeight: glyph,
    color: NigeriaColors.caption,
  );

  static PlateSpec _state(String id, String name, String slogan) => PlateSpec(
    id: 'ng.$id',
    country: NigeriaCountry.nigeria,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    slots: <PlateSlot>[
      _field(NigeriaAlphabets.letters, 3, _Layout.areaLeft, _Layout.areaPitch),
      _field(
        NigeriaAlphabets.digits,
        3,
        _Layout.serialLeft,
        _Layout.serialPitch,
      ),
      _field(
        NigeriaAlphabets.letters,
        2,
        _Layout.suffixLeft,
        _Layout.suffixPitch,
      ),
    ],
    labels: <PlateLabel>[
      _caption(name, _Layout.nameCy, _Layout.nameGlyph),
      _caption(slogan, _Layout.sloganCy, _Layout.sloganGlyph),
      _caption(
        'FEDERAL REPUBLIC OF NIGERIA',
        _Layout.footerCy,
        _Layout.footerGlyph,
      ),
      PlateLabel(
        text: '-',
        box: PlateBox(
          _Layout.dashCx - _Layout.dashWidth / 2,
          _Layout.top,
          _Layout.dashWidth,
          _Layout.box,
        ),
        glyphHeight: _Layout.box,
      ),
    ],
    decals: const <PlateDecal>[
      PlateDecal(drawing: _flagSticker, box: _Layout.flag),
    ],
    textGroups: PlateTextGroup.perSlot(<String>['area', 'serial', 'suffix']),
  );

  static const PlateDrawing _flagSticker = NigeriaCountry.flag;
}
