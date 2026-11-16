import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'papua_new_guinea_colors.dart';

/// One ink on one field, frame in the ink.
abstract final class PapuaNewGuineaThemes {
  static final PlateTheme general = _ink(
    PapuaNewGuineaColors.generalField,
    PapuaNewGuineaColors.generalInk,
  );
  static final PlateTheme taxi = _ink(
    PapuaNewGuineaColors.taxiField,
    PapuaNewGuineaColors.taxiInk,
  );
  static final PlateTheme hire = _ink(
    PapuaNewGuineaColors.hireField,
    PapuaNewGuineaColors.hireInk,
  );
  static final PlateTheme trailer = _ink(
    PapuaNewGuineaColors.trailerField,
    PapuaNewGuineaColors.trailerInk,
  );
  static final PlateTheme pmvBlue = _ink(
    PapuaNewGuineaColors.pmvBlueField,
    PapuaNewGuineaColors.pmvBlueInk,
  );
  static final PlateTheme pmvOrange = _ink(
    PapuaNewGuineaColors.pmvOrangeField,
    PapuaNewGuineaColors.pmvOrangeInk,
  );
  static final PlateTheme diplomatic = _ink(
    PapuaNewGuineaColors.diplomaticField,
    PapuaNewGuineaColors.diplomaticInk,
  );
  static final PlateTheme consular = _ink(
    PapuaNewGuineaColors.consularField,
    PapuaNewGuineaColors.consularInk,
  );
  static final PlateTheme trade = _ink(
    PapuaNewGuineaColors.tradeField,
    PapuaNewGuineaColors.tradeInk,
  );
  static final PlateTheme government = _ink(
    PapuaNewGuineaColors.governmentField,
    PapuaNewGuineaColors.governmentInk,
  );
  static final PlateTheme provincial = _ink(
    PapuaNewGuineaColors.provincialField,
    PapuaNewGuineaColors.provincialInk,
  );
}

PlateTheme _ink(Color field, Color ink) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: 0.03,
  plateRadiusRatio: 0.05,
);
