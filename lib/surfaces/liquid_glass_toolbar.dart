import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass/enum/liquid_glass_quality.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';


/// A beautiful glass morphism toolbar following Apple's iOS design patterns.
///
/// [LiquidGlassToolBar] provides a sophisticated bottom toolbar for actions,
/// utilizing the liquid glass material. It is typically used at the bottom
/// of the screen to present a set of actions relevant to the current context.
/// Unlike [LiquidGlassBottomBar] which is for navigation, this widget is for
/// actions (e.g., "Edit", "Share", "Delete").
class LiquidGlassToolBar extends StatelessWidget {
  /// Creates a glass toolbar.
  const LiquidGlassToolBar({
    required this.children,
    super.key,
    this.height = 44.0,
    this.alignment = MainAxisAlignment.spaceBetween,
    this.glassSettings,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.quality = LiquidGlassQuality.premium,
    this.backgroundColor,
  });

  /// The action buttons to display in the toolbar.
  ///
  /// Typically [GlassButton]s or [IconButton]s.
  /// Use [Spacer] widgets to control spacing between items if [alignment]
  /// is set to [MainAxisAlignment.spaceBetween] (the default).
  final List<Widget> children;

  /// Height of the toolbar content area.
  ///
  /// Does not include safe area insets (bottom padding).
  /// Defaults to 44.0, which is the standard iOS toolbar height.
  final double height;

  /// How the children should be placed along the horizontal axis.
  ///
  /// Defaults to [MainAxisAlignment.spaceBetween].
  final MainAxisAlignment alignment;

  /// Glass effect settings.
  ///
  /// If null, uses optimized defaults for toolbars.
  final LiquidGlassSettings? glassSettings;

  /// Padding around the content.
  ///
  /// Defaults to symmetric(horizontal: 16, vertical: 8).
  final EdgeInsetsGeometry padding;

  /// Rendering quality for the glass effect.
  ///
  /// Defaults to [GlassQuality.premium].
  final LiquidGlassQuality quality;

  /// Optional background color override.
  ///
  /// If provided, this color is mixed with the glass effect.
  /// If null, a default iOS-style translucent tint is used.
  final Color? backgroundColor;

  static const _defaultSettings = LiquidGlassSettings(
    thickness: 25,
    blur: 20,
    chromaticAberration: 0.2,
    lightIntensity: 0.35,
    refractiveIndex: 1.5,
    saturation: 1.2,
    glassColor: Colors.white10,
  );

  @override
  Widget build(BuildContext context) {
    final effectiveSettings = glassSettings ?? _defaultSettings;
    final effectiveBackgroundColor =
        backgroundColor ?? Colors.grey.withAlpha(20);

    return LiquidGlassLayer(
      settings: effectiveSettings,
      fake: quality.usesBackdropFilter,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.white12,
              width: 0.5,
            ),
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: LiquidGlass.grouped(
                shape: const LiquidRoundedRectangle(borderRadius: 0),
                child: Container(color: effectiveBackgroundColor),
              ),
            ),
            SafeArea(
              top: false,
              child: SizedBox(
                height: height,
                child: Padding(
                  padding: padding,
                  child: Row(
                    mainAxisAlignment: alignment,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: children,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
