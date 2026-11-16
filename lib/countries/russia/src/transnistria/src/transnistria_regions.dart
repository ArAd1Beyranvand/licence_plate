/// The first letter of a plate names the town or district of registration.
abstract final class TransnistriaRegions {
  static const Map<String, String> names = <String, String>{
    'A': 'Bender',
    'B': 'Grigoriopol',
    'E': 'Dubăsari',
    'K': 'Camenca',
    'P': 'Rîbnița',
    'C': 'Slobozia',
    'T': 'Tiraspol',
    'H': 'Tiraspol (mopeds only)',
  };

  static Set<String> get codes => names.keys.toSet();
}
