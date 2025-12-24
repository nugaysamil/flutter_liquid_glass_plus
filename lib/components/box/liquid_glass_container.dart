import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass/enum/liquid_glass_quality.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

/// Base glass container widget with configurable dimensions and styling.
class LiquidGlassContainer extends StatelessWidget {
  const LiquidGlassContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.shape = const LiquidRoundedSuperellipse(borderRadius: 16),
    this.settings,
    this.useOwnLayer = false,
    this.quality = LiquidGlassQuality.standard,
    this.clipBehavior = Clip.none,
    this.alignment,
  });

  /// Content widget displayed inside the container.
  final Widget? child;

  /// Alignment of the child within the container.
  final AlignmentGeometry? alignment;

  /// Container width. If null, sizes to fit child.
  final double? width;

  /// Container height. If null, sizes to fit child.
  final double? height;

  /// Internal padding.
  final EdgeInsetsGeometry? padding;

  /// External margin around the container.
  final EdgeInsetsGeometry? margin;

  /// Container shape. Defaults to rounded superellipse with 16px radius.
  final LiquidShape shape;

  /// Glass effect settings. Only used when [useOwnLayer] is true.
  final LiquidGlassSettings? settings;

  /// Whether to create its own layer or use grouped glass from parent.
  final bool useOwnLayer;

  /// Rendering quality for the glass effect.
  final LiquidGlassQuality quality;

  /// Content clipping behavior.
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    var content = child ?? const SizedBox.shrink();

    if (padding != null) {
      content = Padding(
        padding: padding!,
        child: content,
      );
    }

    if (alignment != null) {
      content = Align(
        alignment: alignment!,
        child: content,
      );
    }

    Widget glassWidget = useOwnLayer
        ? LiquidGlass.withOwnLayer(
            shape: shape,
            settings: settings ?? const LiquidGlassSettings(),
            fake: quality.usesBackdropFilter,
            clipBehavior: clipBehavior,
            child: content,
          )
        : LiquidGlass.grouped(
            shape: shape,
            clipBehavior: clipBehavior,
            child: content,
          );

    if (width != null || height != null) {
      glassWidget = SizedBox(
        width: width,
        height: height,
        child: glassWidget,
      );
    }

    if (margin != null) {
      glassWidget = Padding(
        padding: margin!,
        child: glassWidget,
      );
    }

    return glassWidget;
  }
}
