import 'package:flutter/widgets.dart' show EdgeInsets;
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'bulgaria_colors.dart';
import 'bulgaria_country.dart';
import 'bulgaria_missions.dart';

/// Where the ink sits, in plate units on the 520 × 110 mm the article gives.
///
/// The offline flats were drawn at 520 × 145 (the photos' aspect); every y
/// below is the flat's y × 110 / 145, every x is the flat's x.
///
/// Band: blue to x 50 under the frame. EU stars: ring 30 across, centred at
/// (27, 36.4), so the 46 × 70.4 asset is scaled to 40 × 61.2. `BG` ink spans y
/// 71–91. The military flag: y 23–41 (the three stripes), 30 across.
///
/// Ink is 72 tall on the registration plate (y 17–90); a box that tall would
/// need ~130 on a 110 plate, so every box is the full canvas height and the
/// ink lands near 60, about 84% of reference.
///
/// Fields (ink x-spans; pitch is the glyph centre-to-centre):
/// - registration `C 5096 MK`: region 84–135 (one letter; two letters fill
///   80–184, pitch 52), digits 186–379 (pitch 49.3), series 395–500 (pitch
///   52). A one-letter field is centred in its box, so a single letter sits
///   about 25 right of where the photo prints it.
/// - military `BA 509 096`: code 56–173 (pitch 58.5), 186–330 (48.5), 350–493
///   (48). Civil protection `CP 59 096`: code 54–167, `59` 225–319 (47).
/// - foreigner `XX 9043 19` and diplomatic `CC 7711 20`: letters 60–162 (pitch
///   58.8), digits 214–426 (56.9), the year in small digits 464–495 with a
///   dash above it at y 56–58 (year ink y 74–85).
abstract final class _Layout {
  static const double width = 520, height = 110, bandEnd = 50;

  static const double top = 0, box = 110;

  // The stars box keeps the asset's 46 : 70.4.
  static const double starsLeft = 7, starsTop = 6;
  static const double starsWidth = 40, starsHeight = 61.2;
  static const double flagLeft = 12, flagTop = 23;
  static const double flagWidth = 30, flagHeight = 18;
  static const double bgLeft = 7, bgTop = 66, bgWidth = 40;
  static const double bgHeight = 30, bgGlyph = 34;

  static const double yearTop = 68.4, yearHeight = 22;
  static const double dashLeft = 462, dashTop = 56, dashWidth = 34;
  static const double dashHeight = 2.5;
}

/// A field: [count] cells at [pitch], the first starting at [left].
class _Run {
  const _Run(this.key, this.left, this.pitch, this.count, {this.min});

  final String key;
  final double left, pitch;
  final int count;

  /// The fewest characters, when the field is variable.
  final int? min;

  static const _Run region = _Run('region', 80, 52, 2, min: 1);
  static const _Run electricRegion = _Run('region', 80, 52, 2);
  static const _Run number = _Run('number', 183, 49.3, 4);
  static const _Run series = _Run('series', 393, 52, 2, min: 1);

  static const _Run armyCode = _Run('code', 56, 58.5, 2);
  static const _Run armyFirst = _Run('first', 184.5, 48.5, 3);
  static const _Run armySecond = _Run('second', 349, 48, 3);
  static const _Run protectionCode = _Run('code', 54, 56, 2);
  static const _Run protectionFirst = _Run('first', 224, 47, 2);

  static const _Run stampedPrefix = _Run('region', 52, 58.8, 2, min: 1);
  static const _Run foreignPrefix = _Run('region', 52, 58.8, 2);
  static const _Run stampedNumber = _Run('number', 206.3, 56.9, 4);
  static const _Run mission = _Run('mission', 206.3, 56.9, 2);
  static const _Run missionNumber = _Run('number', 320.1, 56.9, 2);
  static const _Run year = _Run('year', 460, 15.5, 2);
}

/// The Bulgarian plates.
///
/// [private] is the registration `C 5096 MK` (a province code of one or two
/// letters, four digits, a series of one or two letters; the single-letter
/// series is the moped and old-car form), black on white behind the EU band.
/// [electric] is the same in green with `EA` (car) or `EM` (motorcycle) for
/// the province, and the repeater plate (red) is [private] under another theme. [military] is `BA 509 096`
/// and [civilProtection] `CP 59 096`, each behind a band carrying the national
/// flag. [foreigner] is white on light blue, `XX 9043 19`, and [diplomatic]
/// white on red, `CC 7711 20`, whose first two digits are the mission code
/// (so they are a register of their own, and `22` is refused); both end in a
/// small expiry year over a dash.
///
/// Not implemented: the temporary plates (`nnn X nnn`, with a red strip and
/// no usable photo), the pre-1986 black plates and the pre-1958 plates (not
/// current), and the trailer `E` series.
abstract final class BulgariaPlates {
  static final PlateSpec private = _spec(
    id: 'bg.private',
    country: BulgariaCountry.bulgaria,
    fields: <_Run, PlateAlphabet>{
      _Run.region: BulgariaAlphabets.region,
      _Run.number: BulgariaAlphabets.digits,
      _Run.series: BulgariaAlphabets.series,
    },
  );

  static final PlateSpec electric = _spec(
    id: 'bg.electric',
    country: BulgariaCountry.bulgaria,
    fields: <_Run, PlateAlphabet>{
      _Run.electricRegion: BulgariaAlphabets.electric,
      _Run.number: BulgariaAlphabets.digits,
      _Run.series: BulgariaAlphabets.series,
    },
  );

  static final PlateSpec military = _spec(
    id: 'bg.military',
    country: BulgariaCountry.bulgariaFlag,
    fields: <_Run, PlateAlphabet>{
      _Run.armyCode: BulgariaAlphabets.service,
      _Run.armyFirst: BulgariaAlphabets.digits,
      _Run.armySecond: BulgariaAlphabets.digits,
    },
  );

  static final PlateSpec civilProtection = _spec(
    id: 'bg.civil_protection',
    country: BulgariaCountry.bulgariaFlag,
    fields: <_Run, PlateAlphabet>{
      _Run.protectionCode: BulgariaAlphabets.service,
      _Run.protectionFirst: BulgariaAlphabets.digits,
      _Run.armySecond: BulgariaAlphabets.digits,
    },
  );

  static final PlateSpec foreigner = _spec(
    id: 'bg.foreigner',
    country: BulgariaCountry.bulgaria,
    stamped: true,
    fields: <_Run, PlateAlphabet>{
      _Run.foreignPrefix: BulgariaAlphabets.foreign,
      _Run.stampedNumber: BulgariaAlphabets.digits,
      _Run.year: BulgariaAlphabets.digits,
    },
  );

  static final PlateSpec diplomatic = _spec(
    id: 'bg.diplomatic',
    country: BulgariaCountry.bulgaria,
    stamped: true,
    restrictions: const <PlateRestriction>[BulgariaMissions.restriction],
    fields: <_Run, PlateAlphabet>{
      _Run.stampedPrefix: BulgariaAlphabets.diplomatic,
      _Run.mission: BulgariaAlphabets.digits,
      _Run.missionNumber: BulgariaAlphabets.digits,
      _Run.year: BulgariaAlphabets.digits,
    },
  );

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    electric,
    military,
    civilProtection,
    foreigner,
    diplomatic,
  ];

  /// The field as one slot: its box spans the cells at their pitch.
  static PlateSlot _slot(_Run run, PlateAlphabet alphabet) {
    final bool small = run.key == 'year';
    final double height = small ? _Layout.yearHeight : _Layout.box;
    return plateRun(
      alphabet,
      run.count,
      left: run.left,
      top: small ? _Layout.yearTop : _Layout.top,
      pitch: run.pitch,
      height: height,
      minLength: run.min,
    );
  }

  static PlateSpec _spec({
    required String id,
    required PlateCountry country,
    required Map<_Run, PlateAlphabet> fields,
    bool stamped = false,
    List<PlateRestriction> restrictions = const <PlateRestriction>[],
  }) {
    final bool flag = identical(country, BulgariaCountry.bulgariaFlag);
    return PlateSpec(
      id: id,
      country: country,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      panel: PlatePanel(
        box: flag
            ? const PlateBox(
                _Layout.flagLeft,
                _Layout.flagTop,
                _Layout.flagWidth,
                _Layout.flagHeight,
              )
            : const PlateBox(
                _Layout.starsLeft,
                _Layout.starsTop,
                _Layout.starsWidth,
                _Layout.starsHeight,
              ),
        padding: EdgeInsets.zero,
      ),
      background: const PlateSection.columns(<PlatePart>[
        PlatePart(PlateSection.fill(PlateFill.panel), end: _Layout.bandEnd),
        PlatePart(PlateSection.plain),
      ]),
      slots: <PlateSlot>[
        for (final MapEntry<_Run, PlateAlphabet> f in fields.entries)
          _slot(f.key, f.value),
      ],
      labels: const <PlateLabel>[
        PlateLabel(
          text: 'BG',
          box: PlateBox(
            _Layout.bgLeft,
            _Layout.bgTop,
            _Layout.bgWidth,
            _Layout.bgHeight,
          ),
          glyphHeight: _Layout.bgGlyph,
          color: BulgariaColors.white,
        ),
      ],
      rules: <PlateRule>[
        if (stamped)
          const PlateRule(
            box: PlateBox(
              _Layout.dashLeft,
              _Layout.dashTop,
              _Layout.dashWidth,
              _Layout.dashHeight,
            ),
          ),
      ],
      textGroups: <PlateTextGroup>[
        for (int i = 0; i < fields.length; i++)
          PlateTextGroup(<int>[i], key: fields.keys.elementAt(i).key),
      ],
      restrictions: restrictions,
    );
  }
}
