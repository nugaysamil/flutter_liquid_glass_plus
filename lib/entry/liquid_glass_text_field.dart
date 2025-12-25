import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_liquid_glass/enum/liquid_glass_quality.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';


/// A beautiful glass morphism text field inspired by Apple's input design.
///
/// [LiquidGlassTextField] provides a text input field with elegant liquid glass effects,
/// matching iOS design patterns. Supports both grouped mode (sharing glass settings
/// with other elements) and standalone mode (with its own independent glass layer).
/// Includes support for prefix/suffix icons, multiline input, and full customization
/// of styling and behavior.
class LiquidGlassTextField extends StatefulWidget {
  /// Creates a glass text field.
  const LiquidGlassTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.placeholder,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.onChanged,
    this.onSubmitted,
    this.inputFormatters,
    this.textStyle,
    this.placeholderStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.iconSpacing = 12.0,
    this.shape = const LiquidRoundedSuperellipse(borderRadius: 10),
    this.settings,
    this.useOwnLayer = false,
    this.quality = LiquidGlassQuality.standard,
  });

  // ===========================================================================
  // Text Field Properties
  // ===========================================================================

  /// Controls the text being edited.
  ///
  /// If null, a controller will be created internally.
  final TextEditingController? controller;

  /// Controls the focus state of the text field.
  ///
  /// If null, a focus node will be created internally.
  final FocusNode? focusNode;

  /// Placeholder text shown when the field is empty.
  final String? placeholder;

  /// Widget displayed at the start of the field.
  final Widget? prefixIcon;

  /// Widget displayed at the end of the field.
  final Widget? suffixIcon;

  /// Callback when suffix icon is tapped.
  final VoidCallback? onSuffixTap;

  /// Whether to obscure the text (for passwords).
  final bool obscureText;

  /// The type of keyboard to display.
  final TextInputType? keyboardType;

  /// The action button on the keyboard.
  final TextInputAction? textInputAction;

  /// Maximum number of lines for the text field.
  ///
  /// Defaults to 1 for single-line input.
  final int maxLines;

  /// Minimum number of lines for the text field.
  final int? minLines;

  /// Maximum number of characters allowed.
  final int? maxLength;

  /// Whether the text field is enabled.
  final bool enabled;

  /// Whether the text field is read-only.
  final bool readOnly;

  /// Whether the text field should auto-focus.
  final bool autofocus;

  /// Called when the text changes.
  final ValueChanged<String>? onChanged;

  /// Called when the user submits the text.
  final ValueChanged<String>? onSubmitted;

  /// Input formatters for the text field.
  final List<TextInputFormatter>? inputFormatters;

  // ===========================================================================
  // Style Properties
  // ===========================================================================

  /// The style of the text being edited.
  final TextStyle? textStyle;

  /// The style of the placeholder text.
  final TextStyle? placeholderStyle;

  /// Padding inside the text field.
  ///
  /// Defaults to 16px horizontal, 12px vertical.
  final EdgeInsetsGeometry padding;

  /// Spacing between the icons and the text field.
  ///
  /// Defaults to 12.
  final double iconSpacing;

  /// Shape of the text field.
  ///
  /// Defaults to [LiquidRoundedSuperellipse] with 10px border radius.
  final LiquidShape shape;

  // ===========================================================================
  // Glass Effect Properties
  // ===========================================================================

  /// Glass effect settings (only used when [useOwnLayer] is true).
  ///
  /// Controls the visual appearance of the glass effect. If null when [useOwnLayer]
  /// is true, uses default settings. Ignored when [useOwnLayer] is false.
  final LiquidGlassSettings? settings;

  /// Whether to create its own layer or use grouped glass within an existing layer.
  ///
  /// - `false` (default): Uses [LiquidGlass.grouped], must be inside a [LiquidGlassLayer].
  ///   More performant when multiple glass elements share the same rendering context.
  /// - `true`: Uses [LiquidGlass.withOwnLayer], can be used anywhere.
  ///   Creates an independent glass rendering context for this text field.
  ///
  /// Defaults to false.
  final bool useOwnLayer;

  /// Rendering quality for the glass effect.
  ///
  /// Defaults to [LiquidGlassQuality.standard], which uses backdrop filter rendering.
  /// Works reliably in all contexts, including scrollable lists. Use
  /// [LiquidGlassQuality.premium] for shader-based glass in static layouts only.
  final LiquidGlassQuality quality;

  @override
  State<LiquidGlassTextField> createState() => _LiquidGlassTextFieldState();
}

class _LiquidGlassTextFieldState extends State<LiquidGlassTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  static const _defaultSettings = LiquidGlassSettings(blur: 8);

  static const _defaultTextStyle = TextStyle(
    color: Color.fromRGBO(255, 255, 255, 0.9),
    fontSize: 16,
  );

  static const _defaultPlaceholderStyle = TextStyle(
    color: Color.fromRGBO(255, 255, 255, 0.5),
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    const defaultTextStyle = _defaultTextStyle;
    const defaultPlaceholderStyle = _defaultPlaceholderStyle;

    final textFieldContent = Padding(
      padding: widget.padding,
      child: Row(
        children: [
          if (widget.prefixIcon != null) ...[
            widget.prefixIcon!,
            SizedBox(width: widget.iconSpacing),
          ],
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              obscureText: widget.obscureText,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              maxLength: widget.maxLength,
              enabled: widget.enabled,
              readOnly: widget.readOnly,
              autofocus: widget.autofocus,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              inputFormatters: widget.inputFormatters,
              style: widget.textStyle ?? defaultTextStyle,
              decoration: InputDecoration(
                hintText: widget.placeholder,
                hintStyle: widget.placeholderStyle ?? defaultPlaceholderStyle,
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                counterText: '',
              ),
            ),
          ),
          if (widget.suffixIcon != null) ...[
            const SizedBox(width: 12),
            GestureDetector(
              onTap: widget.onSuffixTap,
              child: widget.suffixIcon,
            ),
          ],
        ],
      ),
    );

    final glassWidget = widget.useOwnLayer
        ? LiquidGlass.withOwnLayer(
            shape: widget.shape,
            settings: widget.settings ?? _defaultSettings,
            fake: widget.quality.usesBackdropFilter,
            child: textFieldContent,
          )
        : LiquidGlass.grouped(
            shape: widget.shape,
            child: textFieldContent,
          );

    return Opacity(
      opacity: widget.enabled ? 1.0 : 0.5,
      child: glassWidget,
    );
  }
}
