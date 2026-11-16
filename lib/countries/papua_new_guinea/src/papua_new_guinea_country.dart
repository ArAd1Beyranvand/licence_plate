import 'package:license_plate/core/plate_core.dart';

import 'papua_new_guinea_colors.dart';

abstract final class PapuaNewGuineaCountry {
  static const PlateCountry papua_new_guinea = PlateCountry(
    code: 'pg',
    panelColor: PapuaNewGuineaColors.generalField,
    panelTextColor: PapuaNewGuineaColors.generalInk,
  );
}
