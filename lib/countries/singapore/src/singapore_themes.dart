import 'package:license_plate/core/plate_core.dart';
import 'package:flutter/widgets.dart';

import 'singapore_colors.dart';

/// The Singaporean liveries: one ink on one field. The rim is the ink on the
/// light plates and the field on the dark ones, where the references show no
/// separate frame.
///
/// Rim and corner are **estimated** (2% and 7% of the canvas height), not
/// measured: the references are tilted photographs and two illustrations
/// with differently drawn frames.
abstract final class SingaporeThemes {
  static PlateTheme _field({
    required Color field,
    required Color ink,
    required Color rim,
    required Color inactive,
  }) => PlateTheme(
    plateBackground: field,
    plateBorder: rim,
    ink: ink,
    dividerColor: ink,
    borderWidthRatio: 0.02,
    plateRadiusRatio: 0.07,
    activeColor: ink,
    inactiveColor: inactive,
    alertColor: const Color(0xFFD32F2F),
  );

  /// White on black: the standard plate, front and rear.
  static final PlateTheme private = _field(
    field: SingaporeColors.black,
    ink: SingaporeColors.white,
    rim: SingaporeColors.black,
    inactive: SingaporeColors.inactiveOnDark,
  );

  /// Black on white: the euro-style front.
  static final PlateTheme front = _field(
    field: SingaporeColors.frontField,
    ink: SingaporeColors.frontInk,
    rim: SingaporeColors.frontInk,
    inactive: SingaporeColors.inactiveOnLight,
  );

  /// Black on yellow: the euro-style rear.
  static final PlateTheme rear = _field(
    field: SingaporeColors.yellow,
    ink: SingaporeColors.yellowInk,
    rim: SingaporeColors.yellowInk,
    inactive: SingaporeColors.inactiveOnLight,
  );

  /// White on red: off-peak cars.
  static final PlateTheme offPeak = _field(
    field: SingaporeColors.offPeak,
    ink: SingaporeColors.frontField,
    rim: SingaporeColors.frontInk,
    inactive: SingaporeColors.inactiveOnDark,
  );

  /// Black on orange: hazardous cargo vehicles, since 2005.
  static final PlateTheme hazardous = _field(
    field: SingaporeColors.hazardousOrange,
    ink: SingaporeColors.hazardousInk,
    rim: SingaporeColors.hazardousInk,
    inactive: SingaporeColors.inactiveOnLight,
  );

  /// Gold on green: Pulau Ubin vehicles.
  static final PlateTheme pulauUbin = _field(
    field: SingaporeColors.pulauUbin,
    ink: SingaporeColors.pulauUbinInk,
    rim: SingaporeColors.pulauUbin,
    inactive: SingaporeColors.inactiveOnDark,
  );

  /// Gold on a red and yellow field: classic and vintage vehicles. The halves
  /// are the spec's background; the field here is the upper one.
  static final PlateTheme classic = _field(
    field: SingaporeColors.classicRed,
    ink: SingaporeColors.classicGold,
    rim: SingaporeColors.classicGold,
    inactive: SingaporeColors.inactiveOnDark,
  );

  /// White on a red and green diagonal: restricted-use vehicles. The halves
  /// are the spec's background.
  static final PlateTheme restricted = _field(
    field: SingaporeColors.restrictedRed,
    ink: SingaporeColors.frontField,
    rim: SingaporeColors.frontInk,
    inactive: SingaporeColors.inactiveOnDark,
  );
}
