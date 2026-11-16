import 'dart:math';

import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

/// One field of a plate, written in the article's own notation.
///
/// [shape] has one character per position: `a` any letter, `n` any digit,
/// `z` a digit 1–9 (the series that skip 0), `x` a letter other than I and O
/// (NSW's suffix), `m` a letter or a digit; any other character is that
/// literal. [min] is the fewest characters when the field is variable.
class AustraliaField {
  const AustraliaField(this.shape, {this.min});

  final String shape;
  final int? min;

  int get length => shape.length;
  int get minLength => min ?? shape.length;

  static const String _letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  static const String _digits = '0123456789';

  static bool _isDigitKind(String s) => s == 'n' || s == 'z';

  PlateAlphabet get alphabet {
    final List<String> kinds = shape.split('');
    final bool digits = kinds.any(_isDigitKind);
    final bool letters = kinds.any((s) => !_isDigitKind(s));
    if (kinds.contains('m') || (digits && letters)) {
      return AustraliaAlphabets.alphanumeric;
    }
    return digits ? AustraliaAlphabets.digits : AustraliaAlphabets.letters;
  }

  static bool _matches(String s, String c) => switch (s) {
    'a' => _letters.contains(c),
    'x' => _letters.contains(c) && c != 'I' && c != 'O',
    'n' => _digits.contains(c),
    'z' => _digits.contains(c) && c != '0',
    'm' => _letters.contains(c) || _digits.contains(c),
    _ => c == s,
  };

  /// Whether [value] is a whole, legal field.
  bool accepts(String value) {
    if (value.length < minLength || value.length > length) return false;
    for (var i = 0; i < value.length; i++) {
      if (!_matches(shape[i], value[i])) return false;
    }
    return true;
  }

  /// A random legal value of a random length in [minLength]..[length].
  String random(Random rnd) {
    final int n = minLength + rnd.nextInt(length - minLength + 1);
    final StringBuffer out = StringBuffer();
    for (var i = 0; i < n; i++) {
      final String s = shape[i];
      out.write(switch (s) {
        'a' => _letters[rnd.nextInt(26)],
        'x' => 'ABCDEFGHJKLMNPQRSTUVWXYZ'[rnd.nextInt(24)],
        'n' => _digits[rnd.nextInt(10)],
        'z' => _digits[1 + rnd.nextInt(9)],
        'm' => (_letters + _digits)[rnd.nextInt(36)],
        _ => s,
      });
    }
    return '$out';
  }
}

/// The fields of each design, in print order: the one place the format lives.
/// The plates read lengths from it, the validator and the generator read the
/// shapes.
///
/// Current series only, from the article's table (the format column) and the
/// photographs; where they disagree the photograph wins and a comment says so.
abstract final class AustraliaFormats {
  /// `DT·00·CC`. The suffix skips `IA`–`IZ` and `OA`–`OZ`.
  static const List<AustraliaField> nsw = <AustraliaField>[
    AustraliaField('aa'),
    AustraliaField('nn'),
    AustraliaField('xa'),
  ];

  /// `CG·72·AA`: began as a C prefix.
  static const List<AustraliaField> nt = <AustraliaField>[
    AustraliaField('Ca'),
    AustraliaField('nn'),
    AustraliaField('aa'),
  ];

  /// `VV·59·JO`: the first letter is the issuing state.
  static const List<AustraliaField> federalInterstate = <AustraliaField>[
    AustraliaField('aa'),
    AustraliaField('nn'),
    AustraliaField('aa'),
  ];

  /// `YRU·00A`: the first letter is always Y.
  static const List<AustraliaField> act = <AustraliaField>[
    AustraliaField('Yaa'),
    AustraliaField('nna'),
  ];

  /// `725·GX4` on the photo, `000·RQ3` in the article's table and `000·A9E` in
  /// the newest series: the second field is three of letters and digits.
  static const List<AustraliaField> qld = <AustraliaField>[
    AustraliaField('nnn'),
    AustraliaField('mmm'),
  ];

  /// `S647·BZS`: the S is the state standard prefix.
  static const List<AustraliaField> sa = <AustraliaField>[
    AustraliaField('Snnn'),
    AustraliaField('aaa'),
  ];

  /// `H 92 ZR`; the article's `N 00 NH` agrees.
  static const List<AustraliaField> tas = <AustraliaField>[
    AustraliaField('a'),
    AustraliaField('nn'),
    AustraliaField('aa'),
  ];

  /// `1NC·1QD`: no 0 in the first or fourth position.
  static const List<AustraliaField> vic = <AustraliaField>[
    AustraliaField('zaa'),
    AustraliaField('zaa'),
  ];

  /// `1GOR·024`: no 0 in the first position.
  static const List<AustraliaField> wa = <AustraliaField>[
    AustraliaField('zaaa'),
    AustraliaField('nnn'),
  ];

  /// `XS·99AA`; XQ is a truck and YQ a trailer.
  static const List<AustraliaField> nationalHeavyVehicle = <AustraliaField>[
    AustraliaField('aa'),
    AustraliaField('nnaa'),
  ];

  /// `92·0982`. The 1972 plate printed three digits after the dot and the
  /// 1989–2002 one four, so the second field is 3 to 4.
  static const List<AustraliaField> army = <AustraliaField>[
    AustraliaField('nn'),
    AustraliaField('nnnn', min: 3),
  ];

  /// `235358`: six digits, no separator.
  static const List<AustraliaField> airForce = <AustraliaField>[
    AustraliaField('nnnnnn'),
  ];

  /// `F 16L01`: a prefix letter (F is a forklift) and five of letters and
  /// digits.
  static const List<AustraliaField> defence = <AustraliaField>[
    AustraliaField('a'),
    AustraliaField('mmmmm'),
  ];

  /// `DC 7901`: `DC` or `DX`, then four or five digits whose first two or
  /// three are the home country's code.
  static const List<AustraliaField> diplomatic = <AustraliaField>[
    AustraliaField('Da'),
    AustraliaField('nnnnn', min: 4),
  ];

  /// By spec id, for the validator and the generator.
  static const Map<String, List<AustraliaField>> bySpecId =
      <String, List<AustraliaField>>{
        'au.nsw': nsw,
        'au.nt': nt,
        'au.federalInterstate': federalInterstate,
        'au.act': act,
        'au.qld': qld,
        'au.sa': sa,
        'au.tas': tas,
        'au.vic': vic,
        'au.wa': wa,
        'au.nationalHeavyVehicle': nationalHeavyVehicle,
        'au.army': army,
        'au.airForce': airForce,
        'au.defence': defence,
        'au.diplomatic': diplomatic,
      };
}

/// Text-group key of field [i]: `f0`, `f1`, …
String australiaFieldKey(int i) => 'f$i';
