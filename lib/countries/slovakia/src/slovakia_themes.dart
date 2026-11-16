import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'slovakia_colors.dart';

/// One ink on one field with a thin frame in the ink's colour. Frame width and
/// corner arc are read off the flats, not measured closely.
abstract final class SlovakiaThemes {
  /// Black on white: the 2023 plate, the district plate and the military one.
  static final PlateTheme private = _theme(
    SlovakiaColors.white,
    SlovakiaColors.black,
  );

  /// The pre-2004 plate: black on a grey-white field.
  static final PlateTheme legacy = _theme(
    SlovakiaColors.legacyField,
    SlovakiaColors.black,
  );

  /// Officials: dark grey on a pale grey-pink field, the photo's own cast.
  static final PlateTheme officials = _theme(
    SlovakiaColors.officialsField,
    SlovakiaColors.officialsInk,
  );

  /// Diplomatic: yellow on blue inside a yellow frame.
  static final PlateTheme diplomatic = _theme(
    SlovakiaColors.diplomaticBlue,
    SlovakiaColors.diplomaticYellow,
    0.03,
  );

  /// Electric and personalised: dark on teal.
  static final PlateTheme electric = _theme(
    SlovakiaColors.electricField,
    SlovakiaColors.electricInk,
  );

  /// Export/temporary: dark on yellow.
  static final PlateTheme temporary = _theme(
    SlovakiaColors.exportField,
    SlovakiaColors.exportInk,
  );

  /// Dealer: red on white.
  static final PlateTheme dealer = _theme(
    SlovakiaColors.white,
    SlovakiaColors.dealerInk,
  );

  /// Import: green on white.
  static final PlateTheme imported = _theme(
    SlovakiaColors.importField,
    SlovakiaColors.importInk,
  );
}

PlateTheme _theme(Color field, Color ink, [double border = 0.02]) =>
    PlateTheme.monochrome(
      field: field,
      ink: ink,
      borderWidthRatio: border,
      plateRadiusRatio: 0.05,
    );
