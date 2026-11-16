import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'trinidad_and_tobago_country.dart';

/// Where the ink sits, in plate units. The rectangular plates are the 520×110
/// the references were flattened to (aspect 4.4–4.7 across the photographs;
/// the article gives no size). The square plate is 520×358, the 1.42 of its
/// photograph.
///
/// Measured off `License_Plate_Trinidad___Tobago` (private: letters ink
/// x 20.8–222.5, digits x 261–499, y 12.8–97.8), the commercial photograph
/// (letters x 42.8–173.2, digits x 208.2–476.2, y 9.2–93.5, caption
/// x 61.8–283.5 y 94.8–100.5) and the square photograph (rows y 27–162 and
/// 193–334, letters x 97.5–422.5, digits x 81–395; photo plate rectangle
/// scaled ×1.083).
///
/// **Under-height ink, accepted.** A 110 box gives ink of ~60, against 85 in
/// the references: ink is ~0.55 of the box and the box cannot leave the
/// canvas. The square plate's 170 boxes likewise give ~94 against 135.
abstract final class _Layout {
  static const double width = 520, height = 110;

  static const double rowCenterY = 55, rowHeight = 110;

  static const double privateLettersLeft = 20.8, privateLettersWidth = 201.7;
  static const double privateDigitsLeft = 261, privateDigitsWidth = 238;

  static const double commercialRowCenterY = 51.35, commercialRowHeight = 102.7;
  static const double commercialLettersLeft = 42.8;
  static const double commercialLettersWidth = 130.4;
  static const double commercialDigitsLeft = 208.2, commercialDigitsWidth = 268;

  /// Printed caption, ink 5.7 tall (≈ 10 / 0.55 as a glyph height).
  static const double captionLeft = 61.8, captionWidth = 221.7;
  static const double captionCenterY = 97.65, captionHeight = 10;

  static const double squareWidth = 520, squareHeight = 358;
  static const double squareRowHeight = 170, squareLettersTop = 9.5;
  static const double squareLettersLeft = 97.5, squareLettersWidth = 325;
  static const double squareDigitsTop = 178.5, squareDigitsLeft = 81;
  static const double squareDigitsWidth = 314;
}

/// Trinidad and Tobago's plates. The law allows white on black or black on
/// white, the owner choosing; the references show white on black (private),
/// silver on black (commercial) and black on white (square).
///
/// Text groups: `letters` (series, one to three: `TC` on the old commercial
/// plate, `PBJ` now — the first letter is the vehicle class) and `serial`
/// (one to four digits). The article writes `P CB 762`; the pictures print the
/// class and series as one run, so it is one field.
///
/// The A–D series passenger photographs share the private design and differ
/// only in typeface, so they are not separate categories. Rental, hired,
/// dealer, visitor, plant and military plates have no image and are not
/// modelled.
abstract final class TrinidadAndTobagoPlates {
  static PlateSpec _row({
    required String id,
    required double top,
    required double height,
    required double lettersLeft,
    required double lettersWidth,
    required double digitsLeft,
    required double digitsWidth,
    List<PlateLabel> labels = const <PlateLabel>[],
  }) => PlateSpec(
    id: id,
    country: TrinidadAndTobagoCountry.trinidad_and_tobago,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
    slots: <PlateSlot>[
      PlateSlot(
        alphabet: TrinidadAndTobagoAlphabets.letters,
        box: PlateBox(lettersLeft, top, lettersWidth, height),
        length: 3,
        minLength: 1,
        group: 'letters',
      ),
      PlateSlot(
        alphabet: TrinidadAndTobagoAlphabets.digits,
        box: PlateBox(digitsLeft, top, digitsWidth, height),
        length: 4,
        minLength: 1,
        group: 'serial',
      ),
    ],
    labels: labels,
  );

  static final PlateSpec private = _row(
    id: 'tt.private',
    top: _Layout.rowCenterY - _Layout.rowHeight / 2,
    height: _Layout.rowHeight,
    lettersLeft: _Layout.privateLettersLeft,
    lettersWidth: _Layout.privateLettersWidth,
    digitsLeft: _Layout.privateDigitsLeft,
    digitsWidth: _Layout.privateDigitsWidth,
  );

  /// The old commercial plate: narrower margins and the country name printed
  /// small under the digits' left.
  static final PlateSpec commercial = _row(
    id: 'tt.commercial',
    top: _Layout.commercialRowCenterY - _Layout.commercialRowHeight / 2,
    height: _Layout.commercialRowHeight,
    lettersLeft: _Layout.commercialLettersLeft,
    lettersWidth: _Layout.commercialLettersWidth,
    digitsLeft: _Layout.commercialDigitsLeft,
    digitsWidth: _Layout.commercialDigitsWidth,
    labels: const <PlateLabel>[
      PlateLabel(
        text: 'TRINIDAD AND TOBAGO',
        box: PlateBox(
          _Layout.captionLeft,
          _Layout.captionCenterY - _Layout.captionHeight / 2,
          _Layout.captionWidth,
          _Layout.captionHeight,
        ),
        glyphHeight: _Layout.captionHeight,
      ),
    ],
  );

  /// The square plate: series letters over the digits.
  static final PlateSpec square = PlateSpec(
    id: 'tt.square',
    country: TrinidadAndTobagoCountry.trinidad_and_tobago,
    canvasWidth: _Layout.squareWidth,
    canvasHeight: _Layout.squareHeight,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.squareHeight)),
    slots: <PlateSlot>[
      PlateSlot(
        alphabet: TrinidadAndTobagoAlphabets.letters,
        box: PlateBox(
          _Layout.squareLettersLeft,
          _Layout.squareLettersTop,
          _Layout.squareLettersWidth,
          _Layout.squareRowHeight,
        ),
        length: 3,
        minLength: 1,
        group: 'letters',
      ),
      PlateSlot(
        alphabet: TrinidadAndTobagoAlphabets.digits,
        box: PlateBox(
          _Layout.squareDigitsLeft,
          _Layout.squareDigitsTop,
          _Layout.squareDigitsWidth,
          _Layout.squareRowHeight,
        ),
        length: 4,
        minLength: 1,
        group: 'serial',
      ),
    ],
  );
}
