import 'package:flutter/widgets.dart';

/// The colours a Palauan plate is printed in. Field and ink are the modal
/// colours of the flattened, colour-balanced reference photos (`.plateref`),
/// one per livery; the photos are of worn plates, so values marked
/// `// CALIBRATE` rest on a single or poor sample.
abstract final class PalauColors {
  // Field | ink, per livery.
  static const Color airaiField = Color(0xFF3E77C5);
  static const Color airaiInk = Color(0xFFAE966F); // CALIBRATE: faded photo
  static const Color angaurField = Color(0xFFECEFF3);
  static const Color angaurInk = Color(0xFF594E87);
  static const Color kayangelField = Color(0xFFD2DBEB);
  static const Color kayangelInk = Color(0xFF016463);
  static const Color kororField = Color(0xFFDCDAD6);
  static const Color kororInk = Color(0xFF072863);
  static const Color kororBlackField = Color(0xFFF4F2EE);
  static const Color kororBlackInk = Color(0xFF030303);
  static const Color melekeokField = Color(0xFFC7CCCD); // CALIBRATE
  static const Color melekeokInk = Color(0xFF013181); // CALIBRATE
  static const Color ngaraardField = Color(0xFFF3F2F3);
  static const Color ngaraardInk = Color(0xFFC5101C);
  static const Color ngarchelongField = Color(0xFFD3DAD7);
  static const Color ngarchelongInk = Color(0xFF0C1646);
  static const Color ngardmauField = Color(0xFFBF9500);
  static const Color ngardmauInk = Color(0xFFB50505);
  static const Color ngardmauGovernmentField = Color(0xFFFFBE42);
  static const Color ngardmauGovernmentInk = Color(0xFFB73918);
  static const Color ngatpangField = Color(0xFFF2F1F2);
  static const Color ngatpangInk = Color(0xFF028663);
  static const Color ngeremlenguiField = Color(0xFF0046B6);
  static const Color ngeremlenguiInk = Color(0xFFDDBD0B);
  static const Color ngiwalField = Color(0xFF4E2126); // CALIBRATE
  static const Color ngiwalInk = Color(0xFFEEF6F7); // CALIBRATE
  static const Color peleliuField = Color(0xFF3ED4EF);
  static const Color peleliuInk = Color(0xFF182D43);
  static const Color aimeliikField = Color(0xFFE3E9ED);
  static const Color aimeliikInk = Color(0xFF0E120E);
  static const Color governmentField = Color(0xFFFFB600);
  static const Color governmentInk = Color(0xFFD8ECFB);
  static const Color diplomaticField = Color(0xFF00A2DA);
  static const Color diplomaticInk = Color(0xFFC8B252);
  static const Color museumField = Color(0xFFE9ECEC);
  static const Color museumInk = Color(0xFF13181D);

  /// Judiciary: sampled by hand from the one worn photo, whose silver field
  /// and light-blue ink barely differ. Not measured by the offline stage.
  static const Color judiciaryField = Color(0xFFAEAE9F); // CALIBRATE
  static const Color judiciaryInk = Color(0xFF8FB4C8); // CALIBRATE

  /// Flag of Palau, `Flag_of_Palau.svg`.
  static const Color flagBlue = Color(0xFF0099FF);
  static const Color flagYellow = Color(0xFFFFFF00);

  static const Color inactiveOnLight = Color(0xFFB0B0B0);
  static const Color inactiveOnDark = Color(0xFF5A5A5A);
}
