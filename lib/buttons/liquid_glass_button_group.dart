import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass_plus/buttons/liquid_glass_container.dart';
import 'package:flutter_liquid_glass_plus/enum/liquid_glass_quality.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

/// Container that groups multiple buttons visually with dividers.
class LGButtonGroup extends StatelessWidget {
  const LGButtonGroup({
    required this.children,
    super.key,
    this.direction = Axis.horizontal,
    this.glassSettings,
    this.quality = LGQuality.standard,
    this.borderRadius = 16.0,
    this.borderColor = Colors.white12,
    this.useOwnLayer = false,
  });

  /// Buttons to display in the group.
  final List<Widget> children;

  /// Button arrangement direction.
  final Axis direction;

  /// Glass effect settings.
  final LiquidGlassSettings? glassSettings;

  /// Rendering quality.
  final LGQuality quality;

  /// Group container border radius.
  final double borderRadius;

  /// Divider color between buttons.
  final Color borderColor;

  /// Whether to use its own layer or grouped glass.
  final bool useOwnLayer;

  @override
  Widget build(BuildContext context) {
    return LGContainer(
      useOwnLayer: useOwnLayer,
      quality: quality,
      settings: glassSettings,
      shape: LiquidRoundedSuperellipse(borderRadius: borderRadius),
      padding: EdgeInsets.zero,
      child: IntrinsicHeight(
        child: Flex(
          direction: direction,
          mainAxisSize: MainAxisSize.min,
          children: _buildChildrenWithDividers(),
        ),
      ),
    );
  }

  List<Widget> _buildChildrenWithDividers() {
    final List<Widget> items = [];

    for (int i = 0; i < children.length; i++) {
      // Add divider before item (excluding first)
      if (i > 0) {
        items.add(
          direction == Axis.horizontal
              ? Container(width: 1, color: borderColor)
              : Container(height: 1, color: borderColor),
        );
      }

      items.add(children[i]);
    }

    return items;
  }
}
