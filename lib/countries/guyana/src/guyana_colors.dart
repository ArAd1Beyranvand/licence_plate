import 'package:flutter/widgets.dart';

/// The colours a Guyanese plate is printed in, sampled from the flattened
/// references (`platekit`'s measured field and ink columns).
abstract final class GuyanaColors {
  /// Field of the standard plates. `____1` and the Private Car photo.
  static const Color black = Color(0xFF000000);

  /// Characters and rim of the standard plates.
  static const Color white = Color(0xFFFFFFFF);

  /// Field of the Presidential and Prime Minister's plates: a warm black, not
  /// the standard plates' pure black.
  static const Color stateField = Color(0xFF100F0D);

  /// The Presidential crown, sampled (modal colour) off its plate.
  static const Color crownGold = Color(0xFFEFBB10);

  /// The Prime Minister's coat of arms, sampled off its plate. A different
  /// photograph, hence a slightly different gold.
  static const Color arms = Color(0xFFF0C10B);

  /// Flag colours, from `Flag_of_Guyana.svg`. The flag is not printed on any
  /// plate; it only fills [GuyanaCountry.guyana] for hosts that list countries.
  static const Color flagGreen = Color(0xFF009E49);
  static const Color flagYellow = Color(0xFFFCD116);
  static const Color flagRed = Color(0xFFCE1126);

  static const Color inactiveOnDark = Color(0xFF5A5A5A);
}
