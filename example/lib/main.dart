import 'package:flutter/material.dart';
import 'package:license_plate/license_plate.dart';

import 'all_specs.dart';

void main() => runApp(const PlateGallery());

/// Every public spec of every country in `license_plate`, one import.
class PlateGallery extends StatelessWidget {
  const PlateGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'license_plate',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const GalleryPage(),
    );
  }
}

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  /// Typical plate aspect, used only to size the cells.
  static const double _aspect = 3.4;
  static const double _gap = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B2733),
      body: LayoutBuilder(
        builder: (context, box) {
          // The most columns-per-row that still lets every plate fit on one
          // screen: pick the widest cell whose rows fit the height.
          final n = allSpecs.length;
          var cols = 1;
          for (var c = 1; c <= n; c++) {
            final w = box.maxWidth / c;
            final rows = (n / c).ceil();
            if (rows * (w / _aspect) <= box.maxHeight) {
              cols = c;
              break;
            }
          }
          final rows = (n / cols).ceil();
          final cellW = box.maxWidth / cols;
          final cellH = box.maxHeight / rows;
          return Wrap(
            children: [
              for (final (country, _, spec, theme) in allSpecs)
                SizedBox(
                  width: cellW,
                  height: cellH,
                  child: Padding(
                    padding: const EdgeInsets.all(_gap / 2),
                    child: PlateTile(
                      label: country.replaceAll('_', ' '),
                      spec: spec(),
                      theme: theme(),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

/// One plate, centred, with a hint on every slot and the first half filled in.
class PlateTile extends StatefulWidget {
  const PlateTile({
    super.key,
    required this.label,
    required this.spec,
    this.theme,
  });

  final String label;
  final PlateSpec spec;
  final PlateTheme? theme;

  @override
  State<PlateTile> createState() => _PlateTileState();
}

class _PlateTileState extends State<PlateTile> {
  late final PlateController _controller;

  @override
  void initState() {
    super.initState();
    final spec = widget.spec;
    // A sample value per slot, drawn faintly where nothing is typed.
    final samples = <String?>[
      for (var i = 0; i < spec.slotCount; i++) _sample(spec.slots[i], i),
    ];
    _controller = PlateController(spec: spec);
    _controller.hints.value = samples;
    // Type the first half; the rest stays hinted.
    for (var i = 0; i < spec.slotCount ~/ 2; i++) {
      _controller.setAt(i, samples[i]);
    }
  }

  static String? _sample(PlateSlot slot, int i) {
    final chars = slot.alphabet.characters;
    if (chars.isEmpty) return null;
    return List.generate(
      slot.length,
      (k) => chars[(i * 7 + k * 3 + 1) % chars.length],
    ).join();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.label,
      child: Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: 310,
            child: PlateCanvas(
              spec: widget.spec,
              theme: widget.theme,
              controller: _controller,
              onChooseCharacter: noCharacterChooser,
            ),
          ),
        ),
      ),
    );
  }
}
