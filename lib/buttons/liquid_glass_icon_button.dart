import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass_plus/enum/liquid_glass_quality.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

/// Glass icon button with liquid glass effect.
class LGIconButton extends StatelessWidget {
  const LGIconButton({
    required this.icon,
    required this.onPressed,
    super.key,
    this.size = 44,
    this.iconSize,
    this.shape = LGIconButtonShape.circle,
    this.borderRadius = 12,
    this.glowColor,
    this.glowRadius = 20,
    this.interactionScale = 0.95,
    this.useOwnLayer = false,
    this.settings,
    this.quality = LGQuality.standard,
  });

  static const _defaultIconColorEnabled =
      Color(0xFFFFFFFF); 
  static const _defaultIconColorDisabled =
      Color(0x4DFFFFFF); 
  static const _defaultGlowColor =
      Color(0x4DFFFFFF); 

  /// Icon to display.
  final IconData icon;

  /// Icon size within button.
  final double? iconSize;

  /// Press callback. If null, button is disabled.
  final VoidCallback? onPressed;

  /// Scale factor when pressed.
  final double interactionScale;

  /// Button size (width and height).
  final double size;

  /// Button shape.
  final LGIconButtonShape shape;

  /// Border radius for rounded square shape.
  final double borderRadius;

  /// Glow effect color.
  final Color? glowColor;

  /// Glow effect radius.
  final double glowRadius;

  /// Whether to use its own layer or grouped glass.
  final bool useOwnLayer;

  /// Glass effect settings. Only used when [useOwnLayer] is true.
  final LiquidGlassSettings? settings;

  /// Rendering quality.
  final LGQuality quality;

  @override
  Widget build(BuildContext context) {
    final effectiveIconSize = iconSize ?? (size * 0.5);
    final isEnabled = onPressed != null;

    // Build icon content
    final iconWidget = Icon(
      icon,
      size: effectiveIconSize,
      color: isEnabled ? _defaultIconColorEnabled : _defaultIconColorDisabled,
    );

    // Build glow layer
    final withGlow = GlassGlow(
      glowColor: glowColor ?? _defaultGlowColor,
      glowRadius: glowRadius,
      child: iconWidget,
    );

    // Build glass shape
    final glassShape = _buildShape();
    final withGlass = useOwnLayer
        ? LiquidGlass.withOwnLayer(
            shape: glassShape,
            settings: settings ?? const LiquidGlassSettings(),
            fake: quality.usesBackdropFilter,
            child: withGlow,
          )
        : LiquidGlass.grouped(
            shape: glassShape,
            child: withGlow,
          );

    // Build stretch animation
    final withStretch = LiquidStretch(
      interactionScale: isEnabled ? interactionScale : 1.0,
      child: Semantics(
        button: true,
        enabled: isEnabled,
        child: withGlass,
      ),
    );

    // Build gesture handling
    return GestureDetector(
      onTap: isEnabled ? onPressed : null,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: size,
        height: size,
        child: withStretch,
      ),
    );
  }

  static const _defaultOval = LiquidOval();

  LiquidShape _buildShape() {
    switch (shape) {
      case LGIconButtonShape.circle:
        return _defaultOval;
      case LGIconButtonShape.roundedSquare:
        return LiquidRoundedSuperellipse(
          borderRadius: borderRadius,
        );
    }
  }
}

/// Shape options for [LGIconButton].
enum LGIconButtonShape {
  /// Circular button.
  circle,

  /// Rounded square button.
  roundedSquare,
}
