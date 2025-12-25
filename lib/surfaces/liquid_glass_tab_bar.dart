import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass/enum/liquid_glass_quality.dart';
import 'package:flutter_liquid_glass/shared/liquid_glass_indicator.dart';
import 'package:flutter_liquid_glass/utils/indicator_physics.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:motor/motor.dart';


/// A beautiful glass morphism tab bar following Apple's iOS design patterns.
///
/// [LiquidGlassTabBar] provides a horizontal tab navigation bar with glass effect,
/// smooth animations, draggable indicator, and jelly physics. Swipe between tabs
/// with organic motion, or tap to select. Supports icons, labels, or both, with
/// scrollable support for many tabs.
class LiquidGlassTabBar extends StatefulWidget {
  /// Creates a glass tab bar.
  const LiquidGlassTabBar({
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
    super.key,
    this.height = 44.0,
    this.isScrollable = false,
    this.indicatorPadding = const EdgeInsets.all(2),
    this.indicatorColor,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.selectedIconColor,
    this.unselectedIconColor,
    this.iconSize = 24.0,
    this.labelPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.backgroundColor = Colors.transparent,
    this.settings,
    this.useOwnLayer = false,
    this.quality = LiquidGlassQuality.standard,
    this.borderRadius,
    this.indicatorBorderRadius,
    this.indicatorSettings,
  })  : assert(tabs.length >= 2, 'LiquidGlassTabBar requires at least 2 tabs'),
        assert(
          selectedIndex >= 0 && selectedIndex < tabs.length,
          'selectedIndex must be within bounds of tabs list',
        );

  /// List of tabs to display.
  final List<LiquidGlassTab> tabs;

  /// Index of the currently selected tab.
  final int selectedIndex;

  /// Called when a tab is selected.
  final ValueChanged<int> onTabSelected;

  /// Height of the tab bar.
  ///
  /// Defaults to 44.0 (iOS standard).
  /// Use 56.0 or higher when using icons + labels.
  final double height;

  /// Whether the tabs should be scrollable.
  final bool isScrollable;

  /// Padding around the indicator.
  final EdgeInsetsGeometry indicatorPadding;

  /// Color of the pill indicator.
  final Color? indicatorColor;

  /// Text style for selected tab label.
  final TextStyle? selectedLabelStyle;

  /// Text style for unselected tab labels.
  final TextStyle? unselectedLabelStyle;

  /// Icon color for selected tab.
  final Color? selectedIconColor;

  /// Icon color for unselected tabs.
  final Color? unselectedIconColor;

  /// Size of the icons.
  final double iconSize;

  /// Padding around each tab label.
  final EdgeInsetsGeometry labelPadding;

  /// Background color of the tab bar.
  final Color backgroundColor;

  /// Glass effect settings (only used when [useOwnLayer] is true).
  final LiquidGlassSettings? settings;

  /// Whether to create its own layer or use grouped glass.
  final bool useOwnLayer;

  /// Rendering quality for the glass effect.
  final LiquidGlassQuality quality;

  /// BorderRadius of the tab bar.
  final BorderRadius? borderRadius;

  /// BorderRadius of the sliding indicator.
  final BorderRadius? indicatorBorderRadius;

  /// Glass settings for the sliding indicator.
  final LiquidGlassSettings? indicatorSettings;

  @override
  State<LiquidGlassTabBar> createState() => _LiquidGlassTabBarState();
}

class _LiquidGlassTabBarState extends State<LiquidGlassTabBar> {
  static const _defaultBackgroundColor = Color(0x1FFFFFFF);

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(LiquidGlassTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isScrollable &&
        oldWidget.selectedIndex != widget.selectedIndex) {
      _scrollToIndex(widget.selectedIndex);
    }
  }

  void _scrollToIndex(int index) {
    if (!_scrollController.hasClients) return;

    final estimatedTabWidth = widget.isScrollable ? 120.0 : 100.0;
    final targetScroll = index * estimatedTabWidth;
    final viewportWidth = _scrollController.position.viewportDimension;
    final currentScroll = _scrollController.offset;

    if (targetScroll < currentScroll ||
        targetScroll > currentScroll + viewportWidth - estimatedTabWidth) {
      _scrollController.animateTo(
        targetScroll - (viewportWidth - estimatedTabWidth) / 2,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final glassSettings = widget.settings ??
        const LiquidGlassSettings(
          thickness: 30,
          blur: 3,
          chromaticAberration: 0.5,
          lightIntensity: 2,
          refractiveIndex: 1.15,
        );

    final backgroundColor = widget.backgroundColor == Colors.transparent
        ? _defaultBackgroundColor
        : widget.backgroundColor;

    final borderRadius =
        widget.borderRadius ?? BorderRadius.circular(widget.height / 2.2);

    final content = Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      padding: widget.indicatorPadding,
      child: _TabBarContent(
        tabs: widget.tabs,
        selectedIndex: widget.selectedIndex,
        onTabSelected: widget.onTabSelected,
        isScrollable: widget.isScrollable,
        scrollController: _scrollController,
        indicatorColor: widget.indicatorColor,
        selectedLabelStyle: widget.selectedLabelStyle,
        unselectedLabelStyle: widget.unselectedLabelStyle,
        selectedIconColor: widget.selectedIconColor,
        unselectedIconColor: widget.unselectedIconColor,
        iconSize: widget.iconSize,
        labelPadding: widget.labelPadding,
        quality: widget.quality,
        indicatorBorderRadius: widget.indicatorBorderRadius,
        indicatorSettings: widget.indicatorSettings,
      ),
    );

    if (widget.useOwnLayer) {
      return LiquidGlassLayer(
        settings: glassSettings,
        fake: widget.quality.usesBackdropFilter,
        child: content,
      );
    }

    return content;
  }
}

class _TabBarContent extends StatefulWidget {
  const _TabBarContent({
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.isScrollable,
    required this.scrollController,
    required this.indicatorColor,
    required this.selectedLabelStyle,
    required this.unselectedLabelStyle,
    required this.selectedIconColor,
    required this.unselectedIconColor,
    required this.iconSize,
    required this.labelPadding,
    required this.quality,
    this.indicatorBorderRadius,
    this.indicatorSettings,
  });

  final List<LiquidGlassTab> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final bool isScrollable;
  final ScrollController scrollController;
  final Color? indicatorColor;
  final TextStyle? selectedLabelStyle;
  final TextStyle? unselectedLabelStyle;
  final Color? selectedIconColor;
  final Color? unselectedIconColor;
  final double iconSize;
  final EdgeInsetsGeometry labelPadding;
  final LiquidGlassQuality quality;
  final BorderRadius? indicatorBorderRadius;
  final LiquidGlassSettings? indicatorSettings;

  @override
  State<_TabBarContent> createState() => _TabBarContentState();
}

class _TabBarContentState extends State<_TabBarContent> {
  static const _defaultIndicatorColor = Color(0x33FFFFFF);
  static const _defaultUnselectedTextColor = Color(0x99FFFFFF);
  static const _defaultUnselectedIconColor = Color(0x99FFFFFF);

  bool _isDown = false;
  bool _isDragging = false;
  late double _xAlign = _computeXAlignmentForTab(widget.selectedIndex);

  @override
  void didUpdateWidget(_TabBarContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex ||
        oldWidget.tabs.length != widget.tabs.length) {
      setState(() {
        _xAlign = _computeXAlignmentForTab(widget.selectedIndex);
      });
    }
  }

  double _computeXAlignmentForTab(int tabIndex) {
    return IndicatorPhysics.computeAlignment(
      tabIndex,
      widget.tabs.length,
    );
  }

  void _onDragDown(DragDownDetails details) {
    setState(() {
      _isDown = true;
      _xAlign = _getAlignmentFromGlobalPosition(details.globalPosition);
    });
  }

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _isDragging = true;
      _xAlign = _getAlignmentFromGlobalPosition(details.globalPosition);
    });
  }

  void _onDragEnd(DragEndDetails details) {
    setState(() {
      _isDragging = false;
      _isDown = false;
    });

    final box = context.findRenderObject()! as RenderBox;
    final currentRelativeX = (_xAlign + 1) / 2;
    final tabWidth = 1.0 / widget.tabs.length;
    final indicatorWidth = 1.0 / widget.tabs.length;
    final draggableRange = 1.0 - indicatorWidth;
    final velocityX =
        (details.velocity.pixelsPerSecond.dx / box.size.width) / draggableRange;

    final targetTabIndex = _computeTargetTab(
      currentRelativeX: currentRelativeX,
      velocityX: velocityX,
      tabWidth: tabWidth,
    );

    _xAlign = _computeXAlignmentForTab(targetTabIndex);

    if (targetTabIndex != widget.selectedIndex) {
      widget.onTabSelected(targetTabIndex);
    }
  }

  double _getAlignmentFromGlobalPosition(Offset globalPosition) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return _xAlign;

    final local = box.globalToLocal(globalPosition);
    final relativeX = (local.dx / box.size.width).clamp(0.0, 1.0);
    final indicatorWidth = 1.0 / widget.tabs.length;
    final draggableRange = 1.0 - indicatorWidth;

    if (draggableRange <= 0) return 0.0;
    final alignment = (relativeX / draggableRange - 0.5) * 2;
    return alignment.clamp(-1.0, 1.0);
  }

  int _computeTargetTab({
    required double currentRelativeX,
    required double velocityX,
    required double tabWidth,
  }) {
    return IndicatorPhysics.computeTargetIndex(
      currentRelativeX: currentRelativeX,
      velocityX: velocityX,
      itemWidth: tabWidth,
      itemCount: widget.tabs.length,
    );
  }

  void _onTabTap(int index) {
    if (index != widget.selectedIndex) {
      widget.onTabSelected(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final indicatorColor = widget.indicatorColor ?? _defaultIndicatorColor;
    final targetAlignment = _computeXAlignmentForTab(widget.selectedIndex);

    final selectedLabelStyle = widget.selectedLabelStyle ??
        const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        );

    final unselectedLabelStyle = widget.unselectedLabelStyle ??
        const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: _defaultUnselectedTextColor,
        );

    final selectedIconColor = widget.selectedIconColor ?? Colors.white;
    final unselectedIconColor =
        widget.unselectedIconColor ?? _defaultUnselectedIconColor;

    return GestureDetector(
      onHorizontalDragDown: _onDragDown,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      onHorizontalDragCancel: () => setState(() {
        _isDragging = false;
        _isDown = false;
      }),
      child: VelocityMotionBuilder(
        converter: const SingleMotionConverter(),
        value: _xAlign,
        motion: _isDragging
            ? const Motion.interactiveSpring(snapToEnd: true)
            : const Motion.bouncySpring(snapToEnd: true),
        builder: (context, value, velocity, child) {
          final alignment = Alignment(value, 0);

          return SingleMotionBuilder(
            motion: const Motion.snappySpring(
              snapToEnd: true,
              duration: Duration(milliseconds: 300),
            ),
            value: _isDown || (alignment.x - targetAlignment).abs() > 0.15
                ? 1.0
                : 0.0,
            builder: (context, thickness, child) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  if (thickness < 1)
                    LiquidGlassIndicator(
                      velocity: velocity,
                      itemCount: widget.tabs.length,
                      alignment: alignment,
                      thickness: thickness,
                      quality: widget.quality,
                      indicatorColor: indicatorColor,
                      isBackgroundIndicator: true,
                      borderRadius:
                          widget.indicatorBorderRadius?.topLeft.x ?? 16,
                      glassSettings: widget.indicatorSettings,
                    ),
                  if (thickness > 0)
                    LiquidGlassIndicator(
                      velocity: velocity,
                      itemCount: widget.tabs.length,
                      alignment: alignment,
                      thickness: thickness,
                      quality: widget.quality,
                      indicatorColor: indicatorColor,
                      isBackgroundIndicator: false,
                      borderRadius:
                          widget.indicatorBorderRadius?.topLeft.x ?? 16,
                      glassSettings: widget.indicatorSettings,
                    ),
                  child!,
                ],
              );
            },
            child: _buildTabLabels(
              selectedLabelStyle,
              unselectedLabelStyle,
              selectedIconColor,
              unselectedIconColor,
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabLabels(
    TextStyle selectedStyle,
    TextStyle unselectedStyle,
    Color selectedIconColor,
    Color unselectedIconColor,
  ) {
    final tabWidgets = List.generate(
      widget.tabs.length,
      (index) {
        final tab = widget.tabs[index];
        final isSelected = index == widget.selectedIndex;
        return RepaintBoundary(
          child: _TabItem(
            tab: tab,
            isSelected: isSelected,
            onTap: () => _onTabTap(index),
            labelStyle: isSelected ? selectedStyle : unselectedStyle,
            iconColor: isSelected ? selectedIconColor : unselectedIconColor,
            iconSize: widget.iconSize,
            padding: widget.labelPadding,
          ),
        );
      },
    );

    if (widget.isScrollable) {
      return SingleChildScrollView(
        controller: widget.scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(children: tabWidgets),
      );
    }

    return Row(
      children: tabWidgets.map((tab) => Expanded(child: tab)).toList(),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.tab,
    required this.isSelected,
    required this.onTap,
    required this.labelStyle,
    required this.iconColor,
    required this.iconSize,
    required this.padding,
  });

  final LiquidGlassTab tab;
  final bool isSelected;
  final VoidCallback onTap;
  final TextStyle labelStyle;
  final Color iconColor;
  final double iconSize;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    Widget? iconWidget;
    if (tab.icon != null) {
      iconWidget = Icon(
        tab.icon,
        size: iconSize,
        color: iconColor,
      );
    }

    Widget? labelWidget;
    if (tab.label != null) {
      labelWidget = Text(
        tab.label!,
        style: labelStyle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    Widget content;
    if (iconWidget != null && labelWidget != null) {
      content = Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconWidget,
          const SizedBox(height: 4),
          labelWidget,
        ],
      );
    } else if (iconWidget != null) {
      content = iconWidget;
    } else if (labelWidget != null) {
      content = labelWidget;
    } else {
      content = const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Semantics(
        button: true,
        selected: isSelected,
        label: tab.semanticLabel ?? tab.label,
        child: Container(
          padding: padding,
          alignment: Alignment.center,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: labelStyle,
            child: content,
          ),
        ),
      ),
    );
  }
}

/// Configuration for a tab in [LiquidGlassTabBar].
class LiquidGlassTab {
  /// Creates a tab configuration.
  const LiquidGlassTab({
    this.icon,
    this.label,
    this.semanticLabel,
  }) : assert(
          icon != null || label != null,
          'LiquidGlassTab must have either an icon or label',
        );

  /// Icon to display in the tab.
  final IconData? icon;

  /// Label text to display in the tab.
  final String? label;

  /// Semantic label for accessibility.
  final String? semanticLabel;
}
