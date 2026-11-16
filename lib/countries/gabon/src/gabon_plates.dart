import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'gabon_colors.dart';
import 'gabon_country.dart';

/// Measured on the reference photo flattened to 520×110.
///
/// The reference ink is ~76 tall; with the 0.55 ink ratio a 96-unit box gives
/// ~53, so the characters land near 70% of the reference. The plate is only
/// 110 tall, which caps the box. The footer is set smaller than measured so
/// "REPUBLIQUE GABONAISE" stays inside its 110-unit run (the reference face
/// is condensed). The barcode itself is not drawn, only its white sticker.
abstract final class _Layout {
  static const double width = 520, height = 110, box = 96, top = 1;

  static const double lettersPitch = 48.6, digitsPitch = 47.4;
  static const double firstCx = 84, numberCx = 212, lastCx = 386.6;

  static const double frameLineY = 96, frameLine = 2.4;

  static const PlateBox dash1 = PlateBox(162.5, 41.6, 19, 11.7);
  static const PlateBox dash2 = PlateBox(337, 41.6, 19, 11.7);

  static const PlateBox emblem = PlateBox(14, 12.5, 45, 44.5);

  /// The black ring (x 460–505) and the yellow disc inside it, 2 units in.
  static const PlateBox ring = PlateBox(460, 11, 45, 45);
  static const PlateBox disc = PlateBox(462, 13, 41, 41);

  /// The map has a 238:256 aspect: 34 tall, 31.6 wide.
  static const PlateBox map = PlateBox(466.7, 17, 31.6, 34);

  /// "RG" ink 24 tall.
  static const PlateBox rg = PlateBox(463, 60, 40, 28);
  static const double rgGlyph = 43;

  static const PlateBox footer = PlateBox(397, 98, 120, 11);
  static const double footerGlyph = 12;

  static const PlateBox sticker = PlateBox(11.5, 97, 100.5, 13);
}

/// The current regular plate, `AB-123-CD`: CEMAC emblem, the national map in a
/// ring, "RG" and "REPUBLIQUE GABONAISE" under the frame.
///
/// Not implemented: the superseded pre-2013 plate and the taxi, military and
/// diplomatic series, which have no reference picture.
abstract final class GabonPlates {
  static final PlateSpec private = _spec('ga.private');

  static List<PlateSpec> get all => <PlateSpec>[private];

  static const PlateDecal _emblem = PlateDecal(
    image: AssetImage('assets/countries/gabon/icons/cemac_emblem.png', package: 'license_plate'),
    box: _Layout.emblem,
  );

  static const PlateDecal _map = PlateDecal(
    image: AssetImage(
      'assets/countries/gabon/icons/gabon_flag_map.png',
      package: 'license_plate',
    ),
    box: _Layout.map,
  );

  static PlateSlot _group(
    PlateAlphabet alphabet,
    int count,
    double cx,
    double pitch,
  ) => plateRun(
    alphabet,
    count,
    left: cx - pitch / 2,
    top: _Layout.top,
    pitch: pitch,
    height: _Layout.box,
  );

  static PlateSpec _spec(String id) {
    return PlateSpec(
      id: id,
      country: GabonCountry.gabon,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      background: const PlateSection.rows(<PlatePart>[
        PlatePart(
          PlateSection.plain,
          end: _Layout.frameLineY,
          divider: _Layout.frameLine,
        ),
        PlatePart(PlateSection.plain),
      ]),
      slots: <PlateSlot>[
        _group(
          GabonAlphabets.letters,
          2,
          _Layout.firstCx,
          _Layout.lettersPitch,
        ),
        _group(GabonAlphabets.digits, 3, _Layout.numberCx, _Layout.digitsPitch),
        _group(GabonAlphabets.letters, 2, _Layout.lastCx, _Layout.lettersPitch),
      ],
      rules: const <PlateRule>[
        PlateRule(box: _Layout.dash1),
        PlateRule(box: _Layout.dash2),
      ],
      bands: const <PlateBand>[
        PlateBand(box: _Layout.sticker, color: GabonColors.sticker),
        PlateBand(
          box: _Layout.ring,
          color: GabonColors.black,
          topCornerRadius: 22.5,
          bottomCornerRadius: 22.5,
        ),
        PlateBand(
          box: _Layout.disc,
          color: GabonColors.yellow,
          topCornerRadius: 20.5,
          bottomCornerRadius: 20.5,
        ),
      ],
      labels: const <PlateLabel>[
        PlateLabel(text: 'RG', box: _Layout.rg, glyphHeight: _Layout.rgGlyph),
        PlateLabel(
          text: 'REPUBLIQUE GABONAISE',
          box: _Layout.footer,
          glyphHeight: _Layout.footerGlyph,
        ),
      ],
      decals: const <PlateDecal>[_emblem, _map],
      textGroups: PlateTextGroup.perSlot(<String>[
        'series',
        'number',
        'suffix',
      ]),
    );
  }
}
