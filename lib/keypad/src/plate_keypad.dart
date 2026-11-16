import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:license_plate/core/plate_core.dart';

/// Backspace's key label; not a character any alphabet accepts.
const String kPlateBackspaceKey = 'BACKSPACE';

/// Letters alphabet of a numeric-only [PlateKeypad]; never shown.
const PlateAlphabet _noLetters = PlateAlphabet(
  id: 'keypad.noLetters',
  characters: <String>[],
  input: AlphabetInput.chosen,
);

/// Duration of a digits/letters switch: keys stagger out, the pad resizes,
/// then the new keys stagger in. Public so a typist can sync to it.
const Duration kPlateKeypadSlide = Duration(milliseconds: 560);

/// Colours of a [PlateKeypad] and its keys. Keys are keycaps: a [keyFace]
/// standing on a [keyEdge] skirt, sinking into it when pressed. Disabled keys
/// lie flat, so only what can be typed stands up.
@immutable
class PlateKeypadTheme {
  const PlateKeypadTheme({
    this.surface = const Color(0xFF0B0E14),
    this.keyFace = const Color(0xFF232A36),
    this.keyEdge = const Color(0xFF07090D),
    this.keyBorder = const Color(0x2EFFFFFF),
    this.ink = Colors.white,
    this.disabledInk = const Color(0x40FFFFFF),
    this.hover = const Color(0xFF2FD4CF),
    this.highlight = const Color(0xFFE8A33D),
    this.highlightInk = const Color(0xFF05080B),
  });

  /// Background of the pad and the letters layer.
  final Color surface;

  /// Top and skirt of a standing key.
  final Color keyFace, keyEdge;

  /// Rim around a standing key.
  final Color keyBorder, ink, disabledInk;

  /// Tint of the rim under a hovering pointer.
  final Color hover;

  /// Fill of a pressed or flashed key.
  final Color highlight, highlightInk;
}

/// A soft keyboard drawn in the layout, below the plate. Taps report through
/// [onKey]; a key flashes when its label is [highlightedKey].
class PlateKeypad extends StatefulWidget {
  const PlateKeypad({
    super.key,
    required this.highlightedKey,
    this.highlightedKeyListenable,
    this.compact = false,
    this.showLetters = false,
    this.onKey,
    required this.digitAlphabet,
    required this.letterAlphabet,
    this.activeAlphabet,
    this.theme = const PlateKeypadTheme(),
    this.entrance,
  });

  /// A digits-only keypad in the script of [digits] (such as
  /// `PlateAlphabetDigits.iranian`). It has no letters grid and reports each
  /// key in the script it shows; core folds that back to canonical storage.
  const PlateKeypad.numeric({
    super.key,
    required PlateAlphabet digits,
    this.highlightedKey,
    this.highlightedKeyListenable,
    this.compact = false,
    this.onKey,
    this.theme = const PlateKeypadTheme(),
    this.entrance,
  }) : digitAlphabet = digits,
       letterAlphabet = _noLetters,
       activeAlphabet = digits,
       showLetters = false;

  /// Label of the key to flash; ignored when [highlightedKeyListenable] is set.
  final String? highlightedKey;

  /// The key to flash, watched by the individual keys. Prefer it to
  /// [highlightedKey] for rapid flashing (an auto-typist, echoed hardware
  /// presses): a plain field rebuilds the whole pad per flash, whereas here
  /// only the keys re-evaluate.
  final ValueListenable<String?>? highlightedKeyListenable;

  /// true on mobile (shorter keys), false on tablet.
  final bool compact;

  /// When true, the pad shows letters instead of digits. Toggling it staggers
  /// the keys out, resizes the pad, then staggers the new keys in.
  final bool showLetters;

  /// Fires with the tapped letter from the letters pad.
  final ValueChanged<String>? onKey;

  /// Alphabet used to render the digit grid's labels.
  final PlateAlphabet digitAlphabet;

  /// Alphabet used to render the letters pad's labels.
  final PlateAlphabet letterAlphabet;

  /// The focused slot's alphabet, possibly a subset of [digitAlphabet] or
  /// [letterAlphabet]. Keys outside it render disabled; null disables none.
  final PlateAlphabet? activeAlphabet;

  /// Colours used to paint the pad and its keys.
  final PlateKeypadTheme theme;

  /// The whole pad coming in: at 0 no key shows, at 1 all do, the keys
  /// staggering in order between. Run it forward to bring the pad in and in
  /// reverse to take it out. Null keeps the pad in.
  final Animation<double>? entrance;

  @override
  State<PlateKeypad> createState() => _PlateKeypadState();
}

class _PlateKeypadState extends State<PlateKeypad>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: kPlateKeypadSlide,
  );

  // Phases of a switch, as fractions of [kPlateKeypadSlide]. They overlap a
  // little so the motion reads as one gesture; the grids swap at the midpoint,
  // when no key is visible.
  static const double _outEnd = 0.4, _resizeStart = 0.3, _resizeEnd = 0.7;
  static const double _inStart = 0.6, _swapAt = 0.5;

  static const List<List<String>> _rows = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
    ['', '0', '⌫'],
  ];

  static final List<String> _digitLabels = _rows
      .expand((List<String> row) => row)
      .toList(growable: false);

  /// The letters grid for the alphabet it was computed from; the pad rebuilds
  /// on every focus move, so it is padded once per alphabet.
  _Grid? _letterGrid;

  /// The grid leaving during a switch, and the one arriving (or shown).
  late bool _fromLetters = widget.showLetters;
  late bool _toLetters = widget.showLetters;

  /// Pad height when the current switch started; a reversal mid-resize
  /// continues from here instead of jumping.
  double? _fromHeight;

  @override
  void initState() {
    super.initState();
    _controller.value = 1.0;
  }

  @override
  void didUpdateWidget(covariant PlateKeypad oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showLetters == _toLetters) return;
    final double t = _controller.value;
    if (_controller.isAnimating && t < _swapAt) {
      // The old grid is still leaving: bring it back.
      final bool back = _fromLetters;
      _fromLetters = _toLetters;
      _toLetters = back;
      _fromHeight = null;
      _controller.value = 1.0 - t;
      _controller.forward();
      return;
    }
    _fromHeight = _controller.isAnimating ? _heightAt(t) : null;
    _fromLetters = _toLetters;
    _toLetters = widget.showLetters;
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double get _keyHeight => widget.compact ? 44 : 56;

  double _gridHeight(bool letters) {
    final int rows = letters
        ? _gridFor(widget.letterAlphabet).rows
        : _rows.length;
    return rows * _keyHeight + (rows - 1) * 6;
  }

  double _heightAt(double t) {
    final double from = _fromHeight ?? _gridHeight(_fromLetters);
    final double to = _gridHeight(_toLetters);
    final double p = Curves.easeInOutCubic.transform(
      ((t - _resizeStart) / (_resizeEnd - _resizeStart)).clamp(0.0, 1.0),
    );
    return from + (to - from) * p;
  }

  /// How present key [index] of [count] is at [t]: 1 at rest, falling to 0
  /// in order while the old grid leaves, rising in order as the new arrives.
  static double _reveal(double t, int index, int count) {
    if (t >= 1.0) return 1.0;
    final bool leaving = t < _swapAt;
    final double a = leaving ? 0.0 : _inStart, b = leaving ? _outEnd : 1.0;
    // Each key moves over half the phase; starts spread across the other half.
    final double start = count <= 1 ? 0.0 : index / (count - 1) * 0.5;
    final double p = (((t - a) / (b - a) - start) / 0.5).clamp(0.0, 1.0);
    return leaving
        ? 1.0 - Curves.easeInCubic.transform(p)
        : Curves.easeOutCubic.transform(p);
  }

  /// How present key [index] of [count] is at [entrance] value [v].
  static double _entered(double v, int index, int count) {
    final double start = count <= 1 ? 0.0 : index / (count - 1) * 0.5;
    return Curves.easeOutCubic.transform(((v - start) / 0.5).clamp(0.0, 1.0));
  }

  Animation<double> get _drive => widget.entrance == null
      ? _controller
      : AnimationMin<double>(_controller, widget.entrance!);

  double _presence(double _, int index, int count) =>
      _reveal(_controller.value, index, count) *
      (widget.entrance == null
          ? 1.0
          : _entered(widget.entrance!.value, index, count));

  @override
  Widget build(BuildContext context) {
    // Without this region, a TextField's default `onTapOutside` unfocuses on
    // desktop as a key goes down, so the tap lands on a plate with no active
    // slot.
    final Widget pad = Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: widget.theme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final double t = _controller.value;
          final bool letters = t < _swapAt ? _fromLetters : _toLetters;
          return SizedBox(
            height: _heightAt(t),
            // The grid keeps its natural height while the pad resizes
            // around it; at the swap it is invisible, so clipping is safe.
            child: ClipRect(
              child: OverflowBox(
                alignment: Alignment.topCenter,
                minHeight: 0,
                maxHeight: double.infinity,
                child: IgnorePointer(
                  ignoring: _controller.isAnimating,
                  child: letters ? _lettersGrid() : _digitsGrid(),
                ),
              ),
            ),
          );
        },
      ),
    );
    final Animation<double>? entrance = widget.entrance;
    return TextFieldTapRegion(
      // The pad's surface fades with its keys, so nothing is left behind once they are out.
      child: entrance == null
          ? pad
          : FadeTransition(opacity: entrance, child: pad),
    );
  }

  Widget _digitsGrid() => _KeyGrid(
    key: const ValueKey('digits'),
    labels: _digitLabels,
    columns: _rows[0].length,
    rowHeight: _keyHeight,
    textDirection: TextDirection.ltr,
    alphabet: widget.digitAlphabet,
    theme: widget.theme,
    highlightedKey: widget.highlightedKey,
    highlightedKeyListenable: widget.highlightedKeyListenable,
    onKey: widget.onKey,
    keyEnabled: (key) => _keyEnabled(key, widget.digitAlphabet),
    reveal: _drive,
    revealAt: _presence,
  );

  Widget _lettersGrid() {
    final grid = _gridFor(widget.letterAlphabet);
    final direction = widget.letterAlphabet.direction;
    return Directionality(
      key: const ValueKey('letters'),
      textDirection: direction,
      child: _KeyGrid(
        labels: grid.cells,
        columns: grid.columns,
        rowHeight: _keyHeight,
        textDirection: direction,
        alphabet: null,
        displayAlphabet: widget.letterAlphabet,
        theme: widget.theme,
        highlightedKey: widget.highlightedKey,
        highlightedKeyListenable: widget.highlightedKeyListenable,
        onKey: widget.onKey,
        keyEnabled: (key) => _keyEnabled(key, widget.letterAlphabet),
        reveal: _drive,
        revealAt: _presence,
      ),
    );
  }

  /// Whether [key] accepts taps: backspace always, otherwise only keys of the
  /// focused slot's alphabet (else the pad's own), which `submit()` would
  /// otherwise reject. A fact about the alphabet, not a validation policy.
  bool _keyEnabled(String key, PlateAlphabet ownAlphabet) {
    if (key.isEmpty) return false;
    if (key == kPlateBackspaceKey) return true;
    return (widget.activeAlphabet ?? ownAlphabet).accepts(key);
  }

  /// A roughly square grid sized from the letter count, ending in backspace, so 16 and 26 letters
  /// both lay out sensibly. Derived from `letterAlphabet` alone: narrowing it
  /// by [PlateKeypad.activeAlphabet] would reflow the pad on focus moves.
  _Grid _gridFor(PlateAlphabet alphabet) {
    final cached = _letterGrid;
    if (cached != null && cached.alphabet == alphabet) return cached;
    final letters = alphabet.characters;
    final columns = math.max(1, math.sqrt(letters.length).ceil());
    final rows = ((letters.length + 1) / columns).ceil();
    return _letterGrid = (
      alphabet: alphabet,
      // Blank spacers pad the row so backspace takes the last cell.
      cells: [
        ...letters,
        for (var i = letters.length + 1; i < rows * columns; i++) '',
        '⌫',
      ],
      columns: columns,
      rows: rows,
    );
  }
}

typedef _Grid = ({
  PlateAlphabet alphabet,
  List<String> cells,
  int columns,
  int rows,
});

class _KeyGrid extends StatelessWidget {
  const _KeyGrid({
    super.key,
    required this.labels,
    required this.columns,
    required this.rowHeight,
    required this.textDirection,
    required this.alphabet,
    this.displayAlphabet,
    required this.theme,
    required this.highlightedKey,
    required this.highlightedKeyListenable,
    required this.onKey,
    required this.keyEnabled,
    required this.reveal,
    required this.revealAt,
  });

  final List<String> labels;
  final int columns;
  final double rowHeight;
  final TextDirection textDirection;
  final PlateAlphabet? alphabet;

  /// Renders labels only; the reported key stays the raw label, so a letter
  /// shown as an icon still submits its character.
  final PlateAlphabet? displayAlphabet;
  final PlateKeypadTheme theme;
  final String? highlightedKey;
  final ValueListenable<String?>? highlightedKeyListenable;
  final ValueChanged<String>? onKey;
  final bool Function(String) keyEnabled;

  /// Drives each key's stagger; [revealAt] maps its value and the key's
  /// position to how present the key is.
  final Animation<double> reveal;
  final double Function(double t, int index, int count) revealAt;

  @override
  Widget build(BuildContext context) {
    final int rowCount = (labels.length / columns).ceil();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var r = 0; r < rowCount; r++) ...[
          if (r > 0) const SizedBox(height: 6),
          SizedBox(
            height: rowHeight,
            child: Row(
              children: [
                for (var c = 0; c < columns; c++) ...[
                  if (c > 0) const SizedBox(width: 6),
                  Expanded(
                    child: _Staggered(
                      reveal: reveal,
                      revealAt: revealAt,
                      index: r * columns + c,
                      count: labels.length,
                      child: _Key(
                        label: labels[r * columns + c],
                        index: r * columns + c,
                        count: labels.length,
                        highlightedKey: highlightedKey,
                        highlightListenable: highlightedKeyListenable,
                        keyEnabled: keyEnabled,
                        onKey: onKey,
                        theme: theme,
                        digitAlphabet: alphabet,
                        displayAlphabet: displayAlphabet ?? alphabet,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}

/// Fades and scales one key with the switch stagger.
class _Staggered extends StatelessWidget {
  const _Staggered({
    required this.reveal,
    required this.revealAt,
    required this.index,
    required this.count,
    required this.child,
  });

  final Animation<double> reveal;
  final double Function(double t, int index, int count) revealAt;
  final int index, count;
  final Widget child;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: reveal,
    child: child,
    builder: (context, child) {
      final double v = revealAt(reveal.value, index, count);
      if (v >= 1.0) return child!;
      return Opacity(
        opacity: v,
        child: Transform.scale(scale: 0.6 + 0.4 * v, child: child),
      );
    },
  );
}

class _Key extends StatefulWidget {
  const _Key({
    required this.label,
    required this.index,
    required this.count,
    required this.highlightedKey,
    required this.highlightListenable,
    required this.keyEnabled,
    required this.onKey,
    required this.theme,
    this.digitAlphabet,
    this.displayAlphabet,
  });

  final String label;

  /// Position and grid size; they order the stagger as keys disable or return.
  final int index, count;

  /// The pad's highlight as a value; ignored if [highlightListenable] is set.
  final String? highlightedKey;
  final ValueListenable<String?>? highlightListenable;

  /// Whether this key is in the active alphabet. A disabled key keeps its
  /// place and is never highlighted.
  final bool Function(String) keyEnabled;

  /// Fires with the reported label when an enabled key is tapped.
  final ValueChanged<String>? onKey;
  final PlateKeypadTheme theme;

  /// Renders [label] into the reported key (digit grid); null reports it
  /// verbatim (letters, backspace).
  final PlateAlphabet? digitAlphabet;

  /// Renders [label] on the key face; null shows it verbatim.
  final PlateAlphabet? displayAlphabet;

  @override
  State<_Key> createState() => _KeyState();
}

class _KeyState extends State<_Key> {
  /// What this key reports: its label as the alphabet displays it (a Persian
  /// pad emits `'۵'`; core folds it back via `PlateAlphabet.canonical`), or
  /// the label verbatim without a `digitAlphabet`. Backspace is its own key.
  String get _key => widget.label == '⌫'
      ? kPlateBackspaceKey
      : widget.digitAlphabet == null
      ? widget.label
      : widget.digitAlphabet!.render(widget.label);

  /// Gap between neighbouring keys' turns when the enabled set changes.
  static const Duration _stagger = Duration(milliseconds: 18);

  /// The enabled state the face shows; trails the real one by the stagger.
  late bool _shown = widget.label.isNotEmpty && widget.keyEnabled(_key);
  Timer? _turn;

  /// A finger or button is down on the key, or the pointer is over it.
  bool _down = false, _hover = false;

  @override
  void didUpdateWidget(_Key old) {
    super.didUpdateWidget(old);
    if (widget.label.isEmpty) return;
    final bool enabled = widget.keyEnabled(_key);
    if (enabled == _shown) {
      _turn?.cancel();
      return;
    }
    if (_turn?.isActive ?? false) return;
    // Keys going grey leave last-to-first; returning ones enter first-to-last.
    final int slot = enabled
        ? widget.count + widget.index
        : widget.count - 1 - widget.index;
    _turn = Timer(_stagger * slot, () {
      if (mounted) setState(() => _shown = widget.keyEnabled(_key));
    });
  }

  @override
  void dispose() {
    _turn?.cancel();
    super.dispose();
  }

  void _setDown(bool down) {
    if (_down != down) setState(() => _down = down);
  }

  @override
  Widget build(BuildContext context) {
    // A blank spacer: checked before subscribing, so it listens to nothing.
    if (widget.label.isEmpty) return const SizedBox.shrink();

    final key = _key;
    final listenable = widget.highlightListenable;
    final bool enabled = widget.keyEnabled(key);
    Widget face(String? held) => _KeyFace(
      text: _text,
      pressed: _isHighlight(held) || (_down && enabled),
      flashed: _isHighlight(held),
      hovered: _hover && enabled,
      enabled: _shown,
      backspace: widget.label == '⌫',
      theme: widget.theme,
    );
    // Taps stay on the pointer path: with semantics on, mobile web routes a
    // touch through the semantics DOM, which misplaces keys in an RTL grid
    // (tapping ق typed م).
    return Semantics(
      button: true,
      enabled: enabled,
      label: _text,
      excludeSemantics: true,
      child: MouseRegion(
        cursor: enabled ? SystemMouseCursors.click : MouseCursor.defer,
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: GestureDetector(
          excludeFromSemantics: true,
          onTapDown: enabled ? (_) => _setDown(true) : null,
          onTapCancel: () => _setDown(false),
          onTapUp: (_) => _setDown(false),
          onTap: enabled ? () => widget.onKey?.call(key) : null,
          child: listenable == null
              ? face(widget.highlightedKey)
              : ValueListenableBuilder<String?>(
                  valueListenable: listenable,
                  builder: (context, held, _) => face(held),
                ),
        ),
      ),
    );
  }

  String get _text => widget.label == '⌫' || widget.displayAlphabet == null
      ? widget.label
      : widget.displayAlphabet!.render(widget.label);

  /// Whether [candidate] names this key in either script: both sides are
  /// folded to canonical form, so a host highlighting with `'5'` still lights
  /// the `'۵'` key.
  bool _isHighlight(String? candidate) {
    if (candidate == null) return false;
    final key = _key;
    if (candidate == key) return true;
    final alphabet = widget.digitAlphabet;
    if (alphabet == null) return false;
    return alphabet.canonical(candidate) == alphabet.canonical(key);
  }
}

/// A keycap: the face stands [_depth] above its skirt and sinks onto it when
/// pressed. A disabled key lies flat and fades into the pad.
class _KeyFace extends StatelessWidget {
  const _KeyFace({
    required this.text,
    required this.pressed,
    required this.flashed,
    required this.hovered,
    required this.enabled,
    required this.backspace,
    required this.theme,
  });

  final String text;
  final bool pressed, flashed, hovered, enabled, backspace;
  final PlateKeypadTheme theme;

  static const double _depth = 4;
  // Down is quick so a tap feels mechanical; the release springs back slower.
  static const Duration _down = Duration(milliseconds: 60);
  static const Duration _up = Duration(milliseconds: 220);
  static const Duration _greyOut = Duration(milliseconds: 180);
  static final BorderRadius _radius = BorderRadius.circular(10);

  @override
  Widget build(BuildContext context) {
    // lift: 1 standing, 0 sunk; glow: 1 lit by a press or flash.
    final double lift = !enabled ? 0 : (pressed ? 0.15 : 1);
    final Duration duration = pressed ? _down : (enabled ? _up : _greyOut);
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(end: lift),
      duration: duration,
      curve: pressed ? Curves.easeOut : Curves.easeOutBack,
      builder: (context, l, _) => TweenAnimationBuilder<double>(
        tween: Tween<double>(
          end: flashed || pressed ? 1 : (hovered ? 0.35 : 0),
        ),
        duration: pressed ? _down : _up,
        curve: Curves.easeOut,
        builder: (context, g, _) => _paint(l.clamp(0.0, 1.2), g),
      ),
    );
  }

  Widget _paint(double lift, double glow) {
    final double standing = lift.clamp(0.0, 1.0);
    // A disabled key is a faint recess; an enabled one a solid cap.
    final Color base = Color.lerp(theme.surface, theme.keyFace, standing)!;
    final Color pressedFill = flashed
        ? theme.highlight
        : Color.lerp(theme.keyFace, theme.hover, 0.28)!;
    final Color face = Color.lerp(
      base,
      pressedFill,
      // Hover holds glow at 0.35, which lights only the rim.
      hovered ? ((glow - 0.35) / 0.65).clamp(0.0, 1.0) : glow,
    )!;
    final Color rim = Color.lerp(
      theme.keyBorder.withValues(alpha: theme.keyBorder.a * standing),
      theme.hover,
      hovered ? (glow / 0.35).clamp(0.0, 1.0) : 0,
    )!;
    final Color ink = flashed
        ? Color.lerp(theme.ink, theme.highlightInk, glow)!
        : Color.lerp(theme.disabledInk, theme.ink, standing)!;
    final double top = _depth * (1 - lift);
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        // The skirt: only visible below a standing face.
        Positioned.fill(
          top: _depth,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Color.lerp(theme.surface, theme.keyEdge, standing),
              borderRadius: _radius,
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: top,
          bottom: _depth - top,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: _radius,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const <double>[0, 0.45, 1],
                colors: <Color>[
                  Color.lerp(face, Colors.white, 0.09 * standing)!,
                  face,
                  face,
                ],
              ),
              border: Border.all(color: rim),
            ),
            child: Center(child: _label(ink)),
          ),
        ),
      ],
    );
  }

  Widget _label(Color ink) {
    // The glyph falls back to a colour emoji font; the icon is plain ink.
    if (text.contains('♿')) {
      return Icon(Icons.accessible, color: ink, size: 22);
    }
    if (backspace) return Icon(Icons.backspace_outlined, color: ink, size: 20);
    // A word key (a province name) shrinks to one line.
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          maxLines: 1,
          softWrap: false,
          style: TextStyle(
            color: ink,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
