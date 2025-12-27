import 'package:flutter/cupertino.dart';
import 'package:flutter_liquid_glass_plus/buttons/liquid_glass_button.dart';
import 'package:flutter_liquid_glass_plus/enum/liquid_glass_quality.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

/// Glass chip with pill shape, perfect for tags and filters.
class LGChip extends StatelessWidget {
  const LGChip({
    required this.label,
    super.key,
    this.icon,
    this.onTap,
    this.onDeleted,
    this.selected = false,
    this.selectedColor,
    this.deleteIcon = CupertinoIcons.xmark_circle_fill,
    this.deleteIconSize = 16.0,
    this.iconSize = 16.0,
    this.iconColor,
    this.labelStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.spacing = 6.0,
    this.settings,
    this.useOwnLayer = false,
    this.quality = LGQuality.standard,
    this.interactionScale = 1.03,
    this.stretch = 0.3,
    this.glowRadius = 0.8,
  });

  // Cache default colors to avoid allocations
  static const _defaultIconColor =
      Color(0xE6FFFFFF); 
  static const _defaultLabelColor =
      Color(0xE6FFFFFF); 
  static const _defaultSelectedColor =
      Color(0x4DFFFFFF); 
  static const _defaultGlowColorSelected =
      Color(0x4DFFFFFF);
  static const _defaultGlowColorUnselected =
      Color(0x33FFFFFF);

  /// Label text displayed in chip.
  final String label;

  /// Optional leading icon.
  final IconData? icon;

  /// Tap callback.
  final VoidCallback? onTap;

  /// Delete button callback.
  final VoidCallback? onDeleted;

  /// Whether chip is selected.
  final bool selected;

  /// Color when selected.
  final Color? selectedColor;

  /// Delete button icon.
  final IconData deleteIcon;

  /// Delete icon size.
  final double deleteIconSize;

  /// Leading icon size.
  final double iconSize;

  /// Leading icon color.
  final Color? iconColor;

  /// Label text style.
  final TextStyle? labelStyle;

  /// Internal padding.
  final EdgeInsetsGeometry padding;

  /// Spacing between elements.
  final double spacing;

  /// Glass effect settings. Only used when [useOwnLayer] is true.
  final LiquidGlassSettings? settings;

  /// Whether to use its own layer or grouped glass.
  final bool useOwnLayer;

  /// Rendering quality.
  final LGQuality quality;

  /// Scale factor when pressed.
  final double interactionScale;

  /// Stretch intensity during animation.
  final double stretch;

  /// Glow radius multiplier.
  final double glowRadius;

  static const _chipShape = LiquidRoundedSuperellipse(borderRadius: 100);

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = iconColor ?? _defaultIconColor;
    final effectiveLabelStyle = labelStyle ??
        const TextStyle(
          fontSize: 14,
          color: _defaultLabelColor,
          fontWeight: FontWeight.w500,
        );

    // Build chip content
    final chipContent = Padding(
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Leading icon
          if (icon != null) ...[
            Icon(
              icon,
              size: iconSize,
              color: effectiveIconColor,
            ),
            SizedBox(width: spacing),
          ],

          // Label
          Text(
            label,
            style: effectiveLabelStyle,
          ),

          // Delete button
          if (onDeleted != null) ...[
            SizedBox(width: spacing),
            GestureDetector(
              onTap: onDeleted,
              child: Icon(
                deleteIcon,
                size: deleteIconSize,
                color: effectiveIconColor,
              ),
            ),
          ],
        ],
      ),
    );

    // Determine if chip should be interactive
    final isInteractive = onTap != null || onDeleted != null;

    // Apply selected state color overlay
    final contentWithSelection = selected
        ? Container(
            decoration: BoxDecoration(
              color: selectedColor ?? _defaultSelectedColor,
              borderRadius: BorderRadius.circular(100),
            ),
            child: chipContent,
          )
        : chipContent;

    // Wrap in IntrinsicWidth/Height to auto-size to content
    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: LGButton.custom(
          onTap: onTap ?? (onDeleted != null ? () {} : () {}),
          shape: _chipShape,
          settings: settings,
          useOwnLayer: useOwnLayer,
          quality: quality,
          interactionScale: interactionScale,
          stretch: stretch,
          glowRadius: glowRadius,
          glowColor: selected
              ? (selectedColor ?? _defaultGlowColorSelected)
              : _defaultGlowColorUnselected,
          enabled: isInteractive,
          width: double.infinity, // Expand to intrinsic width
          height: double.infinity, // Expand to intrinsic height
          child: contentWithSelection,
        ),
      ),
    );
  }
}
