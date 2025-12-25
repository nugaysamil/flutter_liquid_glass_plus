import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass/enum/liquid_button_style.dart';
import 'package:flutter_liquid_glass/enum/liquid_glass_quality.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';


/// A beautiful glass morphism button with organic animations and touch effects.
///
/// [LiquidGlassButton] brings your UI to life with liquid glass visuals,
/// satisfying squash and stretch animations, and responsive glow effects that
/// react to touch. The button can work in grouped mode (sharing glass settings
/// with other elements) or standalone mode (with its own independent glass layer).
/// Supports both icon buttons and custom content through the [LiquidGlassButton.custom]
/// constructor.
class LiquidGlassButton extends StatelessWidget {
  /// Creates a glass button with an icon.
  const LiquidGlassButton({
    required this.icon,
    required this.onTap,
    super.key,
    this.label = '',
    this.width = 56,
    this.height = 56,
    this.iconSize = 24.0,
    this.iconColor = Colors.white,
    this.shape = const LiquidOval(),
    this.settings,
    this.useOwnLayer = false,
    this.quality = LiquidGlassQuality.standard,
    this.interactionScale = 1.05,
    this.stretch = 0.5,
    this.resistance = 0.08,
    this.stretchHitTestBehavior = HitTestBehavior.opaque,
    this.glowColor = Colors.white24,
    this.glowRadius = 1.0,
    this.glowHitTestBehavior = HitTestBehavior.opaque,
    this.enabled = true,
    this.style = LiquidButtonStyle.filled,
  }) : child = null;

  /// Creates a glass button with custom content.
  ///
  /// Allows you to use any widget as the button's content instead of just an icon.
  /// Useful for text buttons, composite content, or custom designs.
  const LiquidGlassButton.custom({
    required this.child,
    required this.onTap,
    super.key,
    this.label = '',
    this.width = 56,
    this.height = 56,
    this.shape = const LiquidOval(),
    this.settings,
    this.useOwnLayer = false,
    this.quality = LiquidGlassQuality.standard,
    this.interactionScale = 1.05,
    this.stretch = 0.5,
    this.resistance = 0.08,
    this.stretchHitTestBehavior = HitTestBehavior.opaque,
    this.glowColor = Colors.white24,
    this.glowRadius = 1.0,
    this.glowHitTestBehavior = HitTestBehavior.opaque,
    this.enabled = true,
    this.style = LiquidButtonStyle.filled,
  })  : icon = null,
        iconSize = 24.0,
        iconColor = Colors.white;

  // ===========================================================================
  // Content Properties
  // ===========================================================================

  /// The icon to display in the button.
  ///
  /// Mutually exclusive with [child]. Use the default constructor for icon buttons.
  final IconData? icon;

  /// Custom widget to display in the button.
  ///
  /// Mutually exclusive with [icon]. Use [LiquidGlassButton.custom] constructor.
  final Widget? child;

  /// Size of the icon (only used when [icon] is provided).
  ///
  /// Defaults to 24.0.
  final double iconSize;

  /// Color of the icon (only used when [icon] is provided).
  ///
  /// Defaults to [Colors.white].
  final Color iconColor;

  // ===========================================================================
  // Button Properties
  // ===========================================================================

  /// Callback when the button is tapped.
  ///
  /// If [enabled] is false, this callback will not be invoked.
  final VoidCallback onTap;

  /// Whether the button is enabled.
  ///
  /// When false, the button is visually disabled and [onTap] is not invoked.
  /// Renders with reduced opacity.
  ///
  /// Defaults to true.
  final bool enabled;

  /// Semantic label for accessibility.
  ///
  /// This label is announced by screen readers to describe the button's
  /// purpose. If empty, the button's visual content is used instead.
  ///
  /// Defaults to an empty string.
  final String label;

  /// Width of the button in logical pixels.
  ///
  /// Defaults to 56.0.
  final double width;

  /// Height of the button in logical pixels.
  ///
  /// Defaults to 56.0.
  final double height;

  // ===========================================================================
  // Glass Effect Properties
  // ===========================================================================

  /// Shape of the glass button.
  ///
  /// Can be [LiquidOval], [LiquidRoundedRectangle], or
  /// [LiquidRoundedSuperellipse].
  ///
  /// Defaults to [LiquidOval].
  final LiquidShape shape;

  /// Glass effect settings (only used when [useOwnLayer] is true).
  ///
  /// Controls the visual appearance of the glass effect including thickness,
  /// blur radius, color tint, lighting, and more. If null when [useOwnLayer]
  /// is true, uses [LiquidGlassSettings] defaults. Ignored when [useOwnLayer]
  /// is false (inherits from parent layer).
  final LiquidGlassSettings? settings;

  /// Whether to create its own layer or use grouped glass within an existing layer.
  ///
  /// - `false` (default): Uses [LiquidGlass.grouped], must be inside a [LiquidGlassLayer].
  ///   More performant when multiple glass elements share the same rendering context.
  /// - `true`: Uses [LiquidGlass.withOwnLayer], can be used anywhere.
  ///   Creates an independent glass rendering context for this button.
  ///
  /// Defaults to false.
  final bool useOwnLayer;

  /// Rendering quality for the glass effect.
  ///
  /// Defaults to [LiquidGlassQuality.standard], which uses backdrop filter rendering.
  /// Works reliably in all contexts, including scrollable lists. Use
  /// [LiquidGlassQuality.premium] for shader-based glass in static layouts only.
  final LiquidGlassQuality quality;

  /// The visual style of the button.
  ///
  /// Use [LiquidButtonStyle.transparent] when grouping buttons to avoid
  /// double-drawing glass backgrounds.
  final LiquidButtonStyle style;

  // ===========================================================================
  // LiquidStretch Properties (Animation & Interaction)
  // ===========================================================================

  /// The scale factor to apply when the user is interacting with the button.
  ///
  /// - 1.0: No scaling
  /// - > 1.0: Button grows (e.g., 1.05 = 5% larger)
  /// - < 1.0: Button shrinks
  ///
  /// Creates a satisfying "press down" effect when touched.
  ///
  /// Defaults to 1.05.
  final double interactionScale;

  /// The factor to multiply the drag offset by to determine the stretch amount.
  ///
  /// Controls how much the button stretches in response to drag gestures:
  /// - 0.0: No stretch
  /// - 1.0: Stretch matches drag offset exactly (usually too much)
  /// - 0.5 (default): Balanced, natural stretch effect
  ///
  /// Higher values create more dramatic squash and stretch animations.
  ///
  /// Defaults to 0.5.
  final double stretch;

  /// The resistance factor to apply to the drag offset.
  ///
  /// Controls how "sticky" the drag feels. Higher values create more resistance,
  /// making the button feel heavier and more sluggish. Lower values make it feel
  /// lighter and more responsive. Uses non-linear damping that increases with
  /// distance from the rest position.
  ///
  /// Defaults to 0.08.
  final double resistance;

  /// The hit test behavior for the stretch gesture listener.
  ///
  /// Controls how the stretch effect responds to touches:
  /// - [HitTestBehavior.opaque]: Consumes all touches (default)
  /// - [HitTestBehavior.translucent]: Allows touches to pass through
  /// - [HitTestBehavior.deferToChild]: Only responds when touching the child
  ///
  /// Defaults to [HitTestBehavior.opaque].
  final HitTestBehavior stretchHitTestBehavior;

  // ===========================================================================
  // GlassGlow Properties (Touch Effects)
  // ===========================================================================

  /// The color of the glow effect.
  ///
  /// The glow has this color's opacity at the center and fades to fully transparent
  /// at the edge. Use semi-transparent colors for best results. Common values:
  /// [Colors.white24] (default), [Colors.blue.withOpacity(0.3)], or
  /// [Colors.transparent] to disable.
  ///
  /// Defaults to [Colors.white24].
  final Color glowColor;

  /// The radius of the glow effect relative to the layer's shortest side.
  ///
  /// - 1.0 (default): Glow radius equals the shortest dimension
  /// - 0.5: Half the shortest dimension
  /// - 2.0: Twice the shortest dimension
  ///
  /// Larger values create a more diffuse, spread-out glow.
  ///
  /// Defaults to 1.0.
  final double glowRadius;

  /// The hit test behavior for the glow gesture listener.
  ///
  /// Controls how the glow effect responds to touches:
  /// - [HitTestBehavior.opaque]: Consumes all touches (default)
  /// - [HitTestBehavior.translucent]: Allows touches to pass through
  /// - [HitTestBehavior.deferToChild]: Only responds when touching the child
  ///
  /// Defaults to [HitTestBehavior.opaque].
  final HitTestBehavior glowHitTestBehavior;

  static const _defaultSettings = LiquidGlassSettings();

  @override
  Widget build(BuildContext context) {
    final contentWidget = SizedBox(
      height: height,
      width: width,
      child: Center(
        child: child ??
            Icon(
              icon,
              size: iconSize,
              color: iconColor,
            ),
      ),
    );

    Widget glassWidget;

    if (style == LiquidButtonStyle.transparent) {
      glassWidget = GlassGlow(
        glowColor: glowColor,
        glowRadius: glowRadius,
        hitTestBehavior: glowHitTestBehavior,
        child: contentWidget,
      );
    } else {
      glassWidget = useOwnLayer
          ? LiquidGlass.withOwnLayer(
              shape: shape,
              settings: settings ?? _defaultSettings,
              fake: quality.usesBackdropFilter,
              child: GlassGlow(
                glowColor: glowColor,
                glowRadius: glowRadius,
                hitTestBehavior: glowHitTestBehavior,
                child: contentWidget,
              ),
            )
          : LiquidGlass.grouped(
              shape: shape,
              child: GlassGlow(
                glowColor: glowColor,
                glowRadius: glowRadius,
                hitTestBehavior: glowHitTestBehavior,
                child: contentWidget,
              ),
            );
    }

    final stretchWidget = RepaintBoundary(
      child: LiquidStretch(
        interactionScale: interactionScale,
        stretch: stretch,
        resistance: resistance,
        hitTestBehavior: stretchHitTestBehavior,
        child: Semantics(
          button: true,
          label: label.isNotEmpty ? label : null,
          enabled: enabled,
          child: glassWidget,
        ),
      ),
    );

    final finalWidget = enabled
        ? stretchWidget
        : Opacity(
            opacity: 0.5,
            child: stretchWidget,
          );

    return GestureDetector(
      onTap: enabled ? onTap : null,
      behavior: HitTestBehavior.opaque,
      child: finalWidget,
    );
  }
}
