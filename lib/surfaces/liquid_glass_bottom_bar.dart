// ignore_for_file: deprecated_member_use

import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass/buttons/liquid_glass_button.dart';
import 'package:flutter_liquid_glass/entry/liquid_glass_text_field.dart';
import 'package:flutter_liquid_glass/enum/liquid_glass_quality.dart';
import 'package:flutter_liquid_glass/shared/liquid_glass_indicator.dart';
import 'package:flutter_liquid_glass/utils/indicator_physics.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:motor/motor.dart';



/// A beautiful glass morphism bottom navigation bar inspired by Apple's design language.
///
/// [LiquidGlassBottomBar] brings the elegance of iOS navigation to Flutter with
/// a stunning liquid glass effect. Swipe between tabs with a draggable indicator
/// that responds naturally to your touch, complete with spring physics and
/// organic animations that feel alive.
///
/// Each tab can have its own glow color that animates on selection, creating
/// a personalized visual experience. The optional search integration expands
/// seamlessly when activated, while extra buttons can be added for primary
/// actions. Everything blends together beautifully using [LiquidGlassBlendGroup]
/// for that premium, cohesive look.
class LiquidGlassBottomBar extends StatefulWidget {
  /// Creates a glass bottom navigation bar.
  const LiquidGlassBottomBar({
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
    super.key,
    this.extraButton,
    this.spacing = 8,
    this.horizontalPadding = 20,
    this.verticalPadding = 20,
    this.barHeight = 64,
    this.barBorderRadius = 32,
    this.tabPadding = const EdgeInsets.symmetric(horizontal: 4),
    this.blendAmount = 10,
    this.glassSettings,
    this.showIndicator = true,
    this.indicatorColor,
    this.indicatorSettings,
    this.selectedIconColor = Colors.white,
    this.unselectedIconColor = Colors.white,
    this.selectedLabelColor,
    this.unselectedLabelColor,
    this.iconSize = 24,
    this.textStyle,
    this.glowDuration = const Duration(milliseconds: 300),
    this.glowBlurRadius = 32,
    this.glowSpreadRadius = 8,
    this.glowOpacity = 0.6,
    this.quality = LiquidGlassQuality.premium,
    this.isSearch = false,
    this.searchTab,
    this.onSearchTap,
    this.onSearchChanged,
    this.onSearchSubmitted,
    this.searchPlaceholder,
    this.searchCloseIcon,
    this.searchTextStyle,
    this.searchPlaceholderStyle,
    this.showLabel = true,
  });


  /// List of tabs to display in the bottom bar.
  ///
  /// Each tab requires a label and icon. Optionally specify a selectedIcon
  /// for a different appearance when selected, and a glowColor for the
  /// animated glow effect.
  final List<LiquidGlassBottomBarTab> tabs;

  /// Index of the currently selected tab.
  ///
  /// Must be between 0 and tabs.length - 1.
  final int selectedIndex;

  /// Called when a tab is selected.
  ///
  /// Provides the index of the newly selected tab. Use this to update
  /// your state and switch between pages.
  final ValueChanged<int> onTabSelected;

  /// Optional extra button displayed to the right of the tab bar.
  ///
  /// Typically used for a primary action like "Create", "Add", or "Compose".
  /// The button is rendered as a [GlassButton] and inherits the glass settings.
  final GlassBottomBarExtraButton? extraButton;


  /// Spacing between the tab bar and extra button.
  ///
  /// Only applies when [extraButton] is provided.
  /// Defaults to 8.
  final double spacing;

  /// Horizontal padding around the entire bottom bar content.
  ///
  /// Defaults to 20.
  final double horizontalPadding;

  /// Vertical padding above and below the bottom bar content.
  ///
  /// Defaults to 20.
  final double verticalPadding;

  /// Height of the tab bar.
  ///
  /// Defaults to 64.
  final double barHeight;

  /// Border radius of the tab bar.
  ///
  /// Defaults to 32 for a pill-shaped appearance.
  final double barBorderRadius;

  /// Internal padding of the tab bar.
  ///
  /// Controls spacing between the bar edges and the tab icons.
  /// Defaults to 4px horizontal padding.
  final EdgeInsetsGeometry tabPadding;

  /// Blend amount for glass surfaces.
  ///
  /// Higher values create smoother blending between the tab bar and extra
  /// button.
  /// Passed to [LiquidGlassBlendGroup].
  /// Defaults to 10.
  final double blendAmount;


  /// Glass effect settings for the bottom bar.
  ///
  /// If null, uses optimized defaults for bottom navigation bars:
  /// - thickness: 30
  /// - blur: 3
  /// - chromaticAberration: 0.3
  /// - lightIntensity: 0.6
  /// - refractiveIndex: 1.59
  /// - saturation: 0.7
  /// - ambientStrength: 1
  /// - lightAngle: 0.25 * π
  /// - glassColor: Colors.white24
  final LiquidGlassSettings? glassSettings;

  /// Rendering quality for the glass effect.
  ///
  /// Defaults to [GlassQuality.premium] since bottom bars are typically static
  /// surfaces at the bottom of the screen where premium quality looks best.
  ///
  /// Use [GlassQuality.standard] if the bottom bar will be used in a scrollable
  /// context.
  final LiquidGlassQuality quality;


  /// Whether to show the draggable indicator.
  ///
  /// When true, displays a glass indicator behind the selected tab that can
  /// be dragged to switch tabs. When false, only shows tab icons and labels.
  /// Defaults to true.
  final bool showIndicator;

  /// Color of the subtle indicator shown when not being dragged.
  ///
  /// If null, defaults to a semi-transparent color from the theme.
  final Color? indicatorColor;

  /// Glass settings for the draggable indicator.
  ///
  /// If null, uses optimized defaults for the indicator:
  /// - glassColor: Color.from(alpha: 0.1, red: 1, green: 1, blue: 1)
  /// - saturation: 1.5
  /// - refractiveIndex: 1.15
  /// - thickness: 20
  /// - lightIntensity: 2
  /// - chromaticAberration: 0.5
  /// - blur: 0
  final LiquidGlassSettings? indicatorSettings;


  /// Color of the icon when a tab is selected.
  ///
  /// Defaults to [Colors.white].
  final Color selectedIconColor;

  /// Color of the icon when a tab is not selected.
  ///
  /// Defaults to [Colors.white].
  final Color unselectedIconColor;

  /// Color of the label when a tab is selected.
  ///
  /// If null, uses [selectedIconColor].
  final Color? selectedLabelColor;

  /// Color of the label when a tab is not selected.
  ///
  /// If null, uses [unselectedIconColor].
  final Color? unselectedLabelColor;

  /// Size of the tab icons.
  ///
  /// Defaults to 24.
  final double iconSize;

  /// Text style for tab labels.
  ///
  /// If null, uses default style with fontSize 11, and fontWeight that
  /// changes based on selection (w600 for selected, w500 for unselected).
  final TextStyle? textStyle;


  /// Duration of the glow animation when selecting a tab.
  ///
  /// Defaults to 300 milliseconds.
  final Duration glowDuration;

  /// Blur radius of the glow effect.
  ///
  /// Larger values create a softer, more diffuse glow.
  /// Defaults to 32.
  final double glowBlurRadius;

  /// Spread radius of the glow effect.
  ///
  /// Controls how far the glow extends from the icon.
  /// Defaults to 8.
  final double glowSpreadRadius;

  /// Opacity of the glow effect when a tab is selected.
  ///
  /// Value between 0.0 (invisible) and 1.0 (fully opaque).
  /// Defaults to 0.6.
  final double glowOpacity;

  /// Whether to show the label below the icon.
  ///
  /// Defaults to true.
  final bool showLabel;


  /// Whether to show a separate search widget within the bottom bar.
  ///
  /// When true, displays a search tab that is visually separated from other tabs
  /// but still within the bottom bar container, similar to Apple's App Store design.
  /// Defaults to false.
  final bool isSearch;

  /// Configuration for the search tab.
  ///
  /// Only used when [isSearch] is true. If null, a default search tab will be used.
  final LiquidGlassBottomBarTab? searchTab;

  /// Callback when the search tab is tapped.
  ///
  /// Only used when [isSearch] is true.
  final VoidCallback? onSearchTap;

  /// Callback when the search query changes.
  ///
  /// Only used when [isSearch] is true and search field is active.
  final ValueChanged<String>? onSearchChanged;

  /// Callback when the search is submitted (e.g., user presses Enter).
  ///
  /// Only used when [isSearch] is true.
  final ValueChanged<String>? onSearchSubmitted;

  /// Placeholder text for the search field.
  ///
  /// Only used when [isSearch] is true.
  /// Defaults to 'Search'.
  final String? searchPlaceholder;

  /// Icon for the close button that appears when search is open.
  ///
  /// Only used when [isSearch] is true and search is open.
  /// Accepts both [IconData] and [Widget] (e.g., [SvgPicture]).
  /// If null, defaults to [CupertinoIcons.xmark].
  final Object? searchCloseIcon;

  /// Text style for the search field text.
  ///
  /// Only used when [isSearch] is true.
  /// If null, defaults to white color with fontSize 17.
  final TextStyle? searchTextStyle;

  /// Text style for the search field placeholder.
  ///
  /// Only used when [isSearch] is true.
  /// If null, defaults to white color with fontSize 16.
  final TextStyle? searchPlaceholderStyle;

  @override
  State<LiquidGlassBottomBar> createState() => _LiquidGlassBottomBarState();
}

class _LiquidGlassBottomBarState extends State<LiquidGlassBottomBar> {
  static const _defaultGlassColor = Color(0x3DFFFFFF);
  static const _defaultLightAngle = 0.7853981633974483;
  static const _defaultGlassSettings = LiquidGlassSettings(
    thickness: 30,
    blur: 3,
    chromaticAberration: 0.3,
    lightIntensity: 0.6,
    refractiveIndex: 1.59,
    saturation: 0.7,
    ambientStrength: 1,
    lightAngle: _defaultLightAngle,
    glassColor: _defaultGlassColor,
  );

  bool _isSearchOpen = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  double _previousKeyboardHeight = 0.0;
  bool _isWaitingForKeyboard = false;

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(_onFocusChange);
  }

  /// Handles search field focus changes and closes search when keyboard is dismissed.
  void _onFocusChange() {
    if (mounted) {
      setState(() {
        if (!_searchFocusNode.hasFocus && _isSearchOpen) {
          _isSearchOpen = false;
          _isWaitingForKeyboard = false;
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) {
              _searchController.clear();
            }
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _searchFocusNode.removeListener(_onFocusChange);
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _openSearch() {
    if (_isSearchOpen) return;

    setState(() {
      _isSearchOpen = true;
    });

    widget.onSearchTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    final glassSettings = widget.glassSettings ?? _defaultGlassSettings;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final keyboardOffset = math.max(0.0, keyboardHeight - 20);

    final isKeyboardClosing = keyboardHeight < _previousKeyboardHeight;
    final animationDuration = isKeyboardClosing
        ? const Duration(milliseconds: 400)
        : const Duration(milliseconds: 300);
    final animationCurve =
        isKeyboardClosing ? Curves.easeInOut : Curves.easeOutCubic;

    _previousKeyboardHeight = keyboardHeight;

    return LiquidGlassLayer(
      settings: glassSettings,
      fake: widget.quality.usesBackdropFilter,
      child: LiquidGlassBlendGroup(
        blend: widget.blendAmount,
        child: AnimatedPadding(
          duration: animationDuration,
          curve: animationCurve,
          padding: EdgeInsets.only(
            bottom: _isSearchOpen && widget.isSearch ? keyboardOffset : 0,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.horizontalPadding,
              vertical: widget.verticalPadding,
            ),
            child: _buildAnimatedBottomBar(context, glassSettings),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedBottomBar(
      BuildContext context, LiquidGlassSettings glassSettings) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final extraButtonWidth =
            widget.extraButton != null ? widget.barHeight : 0.0;
        final spacingCount =
            (widget.extraButton != null ? 1 : 0) + (widget.isSearch ? 1 : 0);
        final totalSpacing = spacingCount * widget.spacing;

        final collapsedTabBarWidth = widget.barHeight;
        final collapsedSearchWidth = widget.barHeight * 1.1;

        if (_isSearchOpen && widget.isSearch) {
          final isTextFieldFocused =
              _searchFocusNode.hasFocus || _isWaitingForKeyboard;
          final remainingWidth =
              availableWidth - extraButtonWidth - totalSpacing;

          final searchFieldWidth = isTextFieldFocused
              ? remainingWidth - collapsedSearchWidth - widget.spacing
              : remainingWidth - collapsedTabBarWidth - widget.spacing;

          return Row(
            key: const ValueKey('animatedBottomBar'),
            spacing: widget.spacing,
            children: [
              if (!isTextFieldFocused)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutCubic,
                  width: collapsedTabBarWidth,
                  child: _buildCollapsedTabBar(glassSettings),
                ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                width: searchFieldWidth,
                child: _buildExpandedSearchField(context, glassSettings),
              ),
              if (isTextFieldFocused)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutCubic,
                  width: collapsedSearchWidth,
                  child: _buildCloseIconButton(glassSettings),
                ),
              if (widget.extraButton != null)
                _ExtraButton(
                  config: widget.extraButton!,
                  quality: widget.quality,
                ),
            ],
          );
        } else {
          final remainingWidth =
              availableWidth - extraButtonWidth - totalSpacing;
          final expandedTabBarWidth = remainingWidth -
              (widget.isSearch ? collapsedSearchWidth + widget.spacing : 0);

          return Row(
            key: const ValueKey('animatedBottomBar'),
            spacing: widget.spacing,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                width: expandedTabBarWidth,
                child: _buildExpandedTabBar(glassSettings),
              ),
              if (widget.isSearch)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutCubic,
                  width: collapsedSearchWidth,
                  child: _buildCollapsedSearchWidget(glassSettings),
                ),
              if (widget.extraButton != null)
                _ExtraButton(
                  config: widget.extraButton!,
                  quality: widget.quality,
                ),
            ],
          );
        }
      },
    );
  }

  Widget _buildExpandedTabBar(LiquidGlassSettings glassSettings) {
    return _TabIndicator(
      quality: widget.quality,
      visible: widget.showIndicator,
      tabIndex: widget.selectedIndex,
      tabCount: widget.tabs.length,
      indicatorColor: widget.indicatorColor,
      indicatorSettings: widget.indicatorSettings,
      barGlassSettings: glassSettings,
      onTabChanged: widget.onTabSelected,
      barHeight: widget.barHeight,
      barBorderRadius: widget.barBorderRadius,
      tabPadding: widget.tabPadding,
      child: Row(
        children: [
          for (var i = 0; i < widget.tabs.length; i++)
            Expanded(
              child: RepaintBoundary(
                child: _BottomBarTab(
                  tab: widget.tabs[i],
                  selected: widget.selectedIndex == i,
                  selectedIconColor: widget.selectedIconColor,
                  unselectedIconColor: widget.unselectedIconColor,
                  selectedLabelColor: widget.selectedLabelColor,
                  unselectedLabelColor: widget.unselectedLabelColor,
                  iconSize: widget.iconSize,
                  textStyle: widget.textStyle,
                  glowDuration: widget.glowDuration,
                  glowBlurRadius: widget.glowBlurRadius,
                  glowSpreadRadius: widget.glowSpreadRadius,
                  glowOpacity: widget.glowOpacity,
                  onTap: () => widget.onTabSelected(i),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Builds a collapsed tab bar showing only the selected tab icon.
  Widget _buildCollapsedTabBar(LiquidGlassSettings glassSettings) {
    return LiquidGlass.grouped(
      shape: LiquidRoundedSuperellipse(borderRadius: widget.barBorderRadius),
      child: Container(
        height: widget.barHeight,
        padding: widget.tabPadding,
        alignment: Alignment.center,
        child: RepaintBoundary(
          child: _BottomBarTab(
            tab: widget.tabs[widget.selectedIndex],
            selected: true,
            selectedIconColor: widget.selectedIconColor,
            unselectedIconColor: widget.unselectedIconColor,
            selectedLabelColor: widget.selectedLabelColor,
            unselectedLabelColor: widget.unselectedLabelColor,
            iconSize: widget.iconSize,
            textStyle: widget.textStyle,
            glowDuration: widget.glowDuration,
            glowBlurRadius: widget.glowBlurRadius,
            glowSpreadRadius: widget.glowSpreadRadius,
            glowOpacity: widget.glowOpacity,

            onTap: () {
              _searchFocusNode.unfocus();
              setState(() {
                _isSearchOpen = false;
              });
              Future.delayed(const Duration(milliseconds: 300), () {
                if (mounted) {
                  _searchController.clear();
                }
              });
            },
            showLabel: widget.showLabel,
          ),
        ),
      ),
    );
  }

  /// Builds the close button that appears when search field is focused.
  Widget _buildCloseIconButton(LiquidGlassSettings glassSettings) {
    return LiquidGlass.grouped(
      shape: LiquidRoundedSuperellipse(borderRadius: widget.barBorderRadius),
      child: Container(
        height: widget.barHeight,
        padding: widget.tabPadding,
        alignment: Alignment.center,
          child: GestureDetector(
          onTap: () {
            _searchFocusNode.unfocus();
            setState(() {
              _isSearchOpen = false;
            });
            Future.delayed(const Duration(milliseconds: 300), () {
              if (mounted) {
                _searchController.clear();
              }
            });
          },
          behavior: HitTestBehavior.opaque,
          child: Semantics(
            button: true,
            label: 'Close search',
            child: _buildCloseIcon(),
          ),
        ),
      ),
    );
  }

  /// Builds the close icon widget, supporting both IconData and custom Widget.
  Widget _buildCloseIcon() {
    const defaultIcon = CupertinoIcons.xmark;
    final icon = widget.searchCloseIcon ?? defaultIcon;

    if (icon is Widget) {
      return SizedBox(
        width: widget.iconSize,
        height: widget.iconSize,
        child: icon,
      );
    } else if (icon is IconData) {
      return Icon(
        icon,
        color: widget.selectedIconColor,
        size: widget.iconSize,
      );
    }

    return Icon(
      defaultIcon,
      color: widget.selectedIconColor,
      size: widget.iconSize,
    );
  }

  Widget _buildCollapsedSearchWidget(LiquidGlassSettings glassSettings) {
    return _SearchWidget(
      searchTab: widget.searchTab,
      onSearchTap: _openSearch,
      selectedIconColor: widget.selectedIconColor,
      unselectedIconColor: widget.unselectedIconColor,
      iconSize: widget.iconSize * 1.3,
      textStyle: widget.textStyle,
      quality: widget.quality,
      barHeight: widget.barHeight,
      barBorderRadius: widget.barBorderRadius,
    );
  }

  /// Builds the expanded search field with keyboard focus handling.
  Widget _buildExpandedSearchField(
      BuildContext context, LiquidGlassSettings glassSettings) {
    return GestureDetector(
      onTap: () {
        if (!_searchFocusNode.hasFocus) {
          setState(() {
            _isWaitingForKeyboard = true;
          });

          Future.delayed(const Duration(milliseconds: 2), () {
            if (mounted && _isWaitingForKeyboard) {
              Future.delayed(const Duration(milliseconds: 20), () {
                if (mounted && !_searchFocusNode.hasFocus) {
                  _searchFocusNode.requestFocus();
                  setState(() {
                    _isWaitingForKeyboard = false;
                  });
                }
              });
            }
          });
        }
      },
      behavior: HitTestBehavior.opaque,
      child: AbsorbPointer(
        child: LiquidGlass.grouped(
          shape: LiquidRoundedSuperellipse(
            borderRadius: widget.barBorderRadius,
          ),
          child: Container(
            height: widget.barHeight,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Container(
              height: 1,
              child: LiquidGlassTextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                onChanged: widget.onSearchChanged,
                onSubmitted: widget.onSearchSubmitted,
                textInputAction: TextInputAction.search,
                placeholder: widget.searchPlaceholder,
                placeholderStyle: widget.searchPlaceholderStyle ??
                    const TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 16,
                    ),
                textStyle: widget.searchTextStyle ??
                   const TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 17,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Configuration for a tab in [LiquidGlassBottomBar].
///
/// Each tab displays an icon and label. Optionally provide a different icon
/// for the selected state and a glow color for the selection animation.
///
/// Supports both [IconData] and custom [Widget] (e.g., [SvgPicture]) for icons.
/// You can use [icon] and [selectedIcon] with either [IconData] or [Widget],
/// or use the explicit [iconWidget] and [selectedIconWidget] parameters.
class LiquidGlassBottomBarTab {
  /// Creates a bottom bar tab configuration.
  ///
  /// The [icon] and [selectedIcon] parameters accept both [IconData] and [Widget]
  /// (e.g., [SvgPicture]). Alternatively, you can use [iconWidget] and
  /// [selectedIconWidget] for explicit widget support.
  const LiquidGlassBottomBarTab({
    required this.label,
    this.icon,
    this.selectedIcon,
    this.iconWidget,
    this.selectedIconWidget,
    this.glowColor,
    this.thickness,
    this.selectedLabelColor,
    this.unselectedLabelColor,
  }) : assert(
          icon != null || iconWidget != null,
          'Either icon or iconWidget must be provided',
        );

  /// Label text displayed below the icon.
  final String label;

  /// Icon displayed when the tab is not selected.
  ///
  /// Accepts both [IconData] and [Widget] (e.g., [SvgPicture]).
  /// Also used when selected if [selectedIcon] is not provided.
  /// Mutually exclusive with [iconWidget] - provide either [icon] or [iconWidget].
  final Object? icon;

  /// Icon displayed when the tab is selected.
  ///
  /// Accepts both [IconData] and [Widget] (e.g., [SvgPicture]).
  /// If null, uses [icon] for both selected and unselected states.
  /// Mutually exclusive with [selectedIconWidget].
  final Object? selectedIcon;

  /// Custom widget (e.g., [SvgPicture]) displayed when the tab is not selected.
  ///
  /// Also used when selected if [selectedIconWidget] is not provided.
  /// Mutually exclusive with [icon] - provide either [icon] or [iconWidget].
  final Widget? iconWidget;

  /// Custom widget (e.g., [SvgPicture]) displayed when the tab is selected.
  ///
  /// If null, uses [iconWidget] for both selected and unselected states.
  /// Mutually exclusive with [selectedIcon].
  final Widget? selectedIconWidget;

  /// Color of the animated glow effect when this tab is selected.
  ///
  /// If null, no glow effect is shown for this tab.
  final Color? glowColor;

  /// Thickness of the icon shadow halo effect.
  ///
  /// When provided, creates a shadow halo around the icon for emphasis.
  /// Only visible on unselected tabs, or selected tabs without a
  /// [selectedIcon].
  /// Typical values are between 0.5 and 2.0.
  final double? thickness;

  /// Color of the label when this tab is selected.
  ///
  /// If null, uses the [LiquidGlassBottomBar.selectedLabelColor] or
  /// [LiquidGlassBottomBar.selectedIconColor] as fallback.
  final Color? selectedLabelColor;

  /// Color of the label when this tab is not selected.
  ///
  /// If null, uses the [LiquidGlassBottomBar.unselectedLabelColor] or
  /// [LiquidGlassBottomBar.unselectedIconColor] as fallback.
  final Color? unselectedLabelColor;
}

/// Configuration for the extra button in [LiquidGlassBottomBar].
///
/// The extra button is rendered as a [GlassButton] and typically used for
/// primary actions like creating new content.
///
/// Supports both [IconData] and custom [Widget] (e.g., [SvgPicture]) for icons.
/// You can use [icon] with either [IconData] or [Widget], or use the explicit
/// [iconWidget] parameter.
class GlassBottomBarExtraButton {
  /// Creates an extra button configuration.
  ///
  /// The [icon] parameter accepts both [IconData] and [Widget] (e.g., [SvgPicture]).
  /// Alternatively, you can use [iconWidget] for explicit widget support.
  const GlassBottomBarExtraButton({
    this.icon,
    this.iconWidget,
    required this.onTap,
    required this.label,
    this.size = 64,
  }) : assert(
          icon != null || iconWidget != null,
          'Either icon or iconWidget must be provided',
        );

  /// Icon displayed in the button.
  ///
  /// Accepts both [IconData] and [Widget] (e.g., [SvgPicture]).
  /// Mutually exclusive with [iconWidget] - provide either [icon] or [iconWidget].
  final Object? icon;

  /// Custom widget (e.g., [SvgPicture]) displayed in the button.
  ///
  /// Mutually exclusive with [icon] - provide either [icon] or [iconWidget].
  final Widget? iconWidget;

  /// Callback when the button is tapped.
  final VoidCallback onTap;

  /// Accessibility label for the button.
  final String label;

  /// Width and height of the button.
  ///
  /// Defaults to 64 to match the default bar height.
  final double size;
}

/// Internal widget that renders a single tab.
class _BottomBarTab extends StatelessWidget {
  const _BottomBarTab({
    required this.tab,
    required this.selected,
    required this.selectedIconColor,
    required this.unselectedIconColor,
    this.selectedLabelColor,
    this.unselectedLabelColor,
    required this.iconSize,
    required this.textStyle,
    required this.glowDuration,
    required this.glowBlurRadius,
    required this.glowSpreadRadius,
    required this.glowOpacity,
    required this.onTap,
    this.showLabel = true,
  });

  final LiquidGlassBottomBarTab tab;
  final bool selected;
  final Color selectedIconColor;
  final Color unselectedIconColor;
  final Color? selectedLabelColor;
  final Color? unselectedLabelColor;
  final double iconSize;
  final TextStyle? textStyle;
  final Duration glowDuration;
  final double glowBlurRadius;
  final double glowSpreadRadius;
  final double glowOpacity;
  final VoidCallback onTap;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    final iconColor = selected ? selectedIconColor : unselectedIconColor;
    final labelColor = selected
        ? (tab.selectedLabelColor ?? selectedLabelColor ?? selectedIconColor)
        : (tab.unselectedLabelColor ??
            unselectedLabelColor ??
            unselectedIconColor);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Semantics(
        button: true,
        label: tab.label,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ExcludeSemantics(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    if (tab.glowColor != null)
                      Positioned(
                        top: -24,
                        right: -24,
                        left: -24,
                        bottom: -24,
                        child: RepaintBoundary(
                          child: AnimatedContainer(
                            duration: glowDuration,
                            transformAlignment: Alignment.center,
                            curve: Curves.easeOutCirc,
                            transform: selected
                                ? Matrix4.identity()
                                : (Matrix4.identity()
                                  ..scale(0.4)
                                  ..rotateZ(-math.pi)),
                            child: AnimatedOpacity(
                              duration: glowDuration,
                              opacity: selected ? 1 : 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: tab.glowColor!.withOpacity(
                                        selected ? glowOpacity : 0,
                                      ),
                                      blurRadius: glowBlurRadius,
                                      spreadRadius: glowSpreadRadius,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    AnimatedScale(
                      scale: 1,
                      duration: const Duration(milliseconds: 150),
                      child: _buildIcon(
                        selected: selected,
                        tab: tab,
                        iconColor: iconColor,
                        iconSize: iconSize,
                      ),
                    ),
                  ],
                ),
              ),

              if (showLabel) const SizedBox(height: 4),
              if (showLabel)
                Text(
                  tab.label,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle ??
                      TextStyle(
                        color: labelColor,
                        fontSize: 11,
                        fontWeight:
                            selected ? FontWeight.w600 : FontWeight.w500,
                      ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the icon widget, supporting both IconData and custom Widget.
  Widget _buildIcon({
    required bool selected,
    required LiquidGlassBottomBarTab tab,
    required Color iconColor,
    required double iconSize,
  }) {
    if (tab.iconWidget != null || tab.selectedIconWidget != null) {
      final widget = selected
          ? (tab.selectedIconWidget ?? tab.iconWidget)
          : tab.iconWidget;

      if (widget != null) {
        return SizedBox(
          width: iconSize,
          height: iconSize,
          child: widget,
        );
      }
    }

    final icon = selected ? (tab.selectedIcon ?? tab.icon) : tab.icon;

    if (icon == null) {
      return SizedBox(width: iconSize, height: iconSize);
    }

    if (icon is Widget) {
      return SizedBox(
        width: iconSize,
        height: iconSize,
        child: icon,
      );
    } else if (icon is IconData) {
      return Icon(
        icon,
        color: iconColor,
        size: iconSize,
        shadows: _buildIconShadows(),
      );
    }

    return SizedBox(width: iconSize, height: iconSize);
  }

  /// Builds a circular shadow halo around the icon for emphasis.
  ///
  /// Only applied when [tab.thickness] is provided and the tab is unselected
  /// (or selected without a different selectedIcon). Only works with IconData.
  List<Shadow>? _buildIconShadows() {
    final hasIconWidget =
        tab.iconWidget != null || tab.selectedIconWidget != null;
    final iconIsWidget = tab.icon is Widget || tab.selectedIcon is Widget;

    if (tab.thickness == null ||
        (selected &&
            (tab.selectedIcon != null || tab.selectedIconWidget != null)) ||
        hasIconWidget ||
        iconIsWidget) {
      return null;
    }

    final shadows = <Shadow>[];
    const angleStep = math.pi / 4;

    for (double angle = 0; angle < math.pi * 2; angle += angleStep) {
      shadows.add(
        Shadow(
          color: selected ? selectedIconColor : unselectedIconColor,
          offset: Offset.fromDirection(angle, tab.thickness!),
        ),
      );
    }

    return shadows;
  }
}

/// Internal widget that renders the extra button using [LiquidGlassButton].
class _ExtraButton extends StatelessWidget {
  const _ExtraButton({
    required this.config,
    required this.quality,
  });

  final GlassBottomBarExtraButton config;
  final LiquidGlassQuality quality;

  @override
  Widget build(BuildContext context) {
    if (config.iconWidget != null) {
      return LiquidGlassButton.custom(
        child: config.iconWidget!,
        onTap: config.onTap,
        label: config.label,
        width: config.size,
        height: config.size,
        quality: quality,
      );
    }

    if (config.icon == null) {
      return LiquidGlassButton.custom(
        child: null,
        onTap: config.onTap,
        label: config.label,
        width: config.size,
        height: config.size,
        quality: quality,
      );
    }

    if (config.icon is Widget) {
      return LiquidGlassButton.custom(
        child: config.icon as Widget,
        onTap: config.onTap,
        label: config.label,
        width: config.size,
        height: config.size,
        quality: quality,
      );
    } else if (config.icon is IconData) {
      return LiquidGlassButton(
        icon: config.icon as IconData,
        onTap: config.onTap,
        label: config.label,
        width: config.size,
        height: config.size,
        quality: quality,
      );
    }

    return LiquidGlassButton.custom(
      child: const SizedBox(),
      onTap: config.onTap,
      label: config.label,
      width: config.size,
      height: config.size,
      quality: quality,
    );
  }
}

/// Internal widget that renders a separated search tab within the bottom bar.
///
/// This widget creates a search tab that is visually separated from the main
/// tab bar but still within the bottom bar container, similar to Apple's
/// App Store design.
class _SearchWidget extends StatelessWidget {
  const _SearchWidget({
    required this.searchTab,
    required this.onSearchTap,
    required this.selectedIconColor,
    required this.unselectedIconColor,
    required this.iconSize,
    required this.textStyle,
    required this.quality,
    required this.barHeight,
    required this.barBorderRadius,
  });

  final LiquidGlassBottomBarTab? searchTab;
  final VoidCallback? onSearchTap;
  final Color selectedIconColor;
  final Color unselectedIconColor;
  final double iconSize;
  final TextStyle? textStyle;
  final LiquidGlassQuality quality;
  final double barHeight;
  final double barBorderRadius;

  @override
  Widget build(BuildContext context) {
    final tab = searchTab ??
        const LiquidGlassBottomBarTab(
          label: '',
          icon: CupertinoIcons.search,
        );

    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: RepaintBoundary(
        child: LiquidGlass.grouped(
          shape: LiquidRoundedSuperellipse(borderRadius: barBorderRadius),
          child: Container(
            height: barHeight,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: GestureDetector(
              onTap: onSearchTap,
              behavior: HitTestBehavior.opaque,
              child: Center(
                child: ExcludeSemantics(
                  child: SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: _buildSearchIcon(tab),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the search icon widget, supporting both IconData and custom Widget.
  Widget _buildSearchIcon(LiquidGlassBottomBarTab tab) {
    if (tab.iconWidget != null) {
      return tab.iconWidget!;
    }

    if (tab.icon == null) {
      return const SizedBox();
    }

    if (tab.icon is Widget) {
      return tab.icon as Widget;
    } else if (tab.icon is IconData) {
      return Icon(
        tab.icon as IconData,
        color: unselectedIconColor,
        size: iconSize,
      );
    }

    return const SizedBox();
  }
}

/// Internal widget that manages the draggable indicator with physics.
class _TabIndicator extends StatefulWidget {
  const _TabIndicator({
    required this.child,
    required this.tabIndex,
    required this.tabCount,
    required this.onTabChanged,
    required this.visible,
    required this.indicatorColor,
    required this.quality,
    required this.barHeight,
    required this.barBorderRadius,
    required this.tabPadding,
    required this.barGlassSettings,
    this.indicatorSettings,
  });

  final int tabIndex;
  final int tabCount;
  final bool visible;
  final Widget child;
  final Color? indicatorColor;
  final LiquidGlassSettings? indicatorSettings;
  final LiquidGlassSettings barGlassSettings;
  final ValueChanged<int> onTabChanged;
  final LiquidGlassQuality quality;
  final double barHeight;
  final double barBorderRadius;
  final EdgeInsetsGeometry tabPadding;

  @override
  State<_TabIndicator> createState() => _TabIndicatorState();
}

class _TabIndicatorState extends State<_TabIndicator> {
  static const _fallbackIndicatorColor = Color(0x1AFFFFFF);

  bool _isDown = false;
  bool _isDragging = false;

  /// Current horizontal alignment of the indicator (-1 to 1).
  late double _xAlign = _computeXAlignmentForTab(widget.tabIndex);

  /// Cached shape to avoid recreation on every animation frame.
  late LiquidRoundedSuperellipse _barShape =
      LiquidRoundedSuperellipse(borderRadius: widget.barBorderRadius);

  /// Cached values to avoid recalculation on every frame.
  Color? _cachedIndicatorColor;
  double? _cachedTargetAlignment;
  double? _cachedBackgroundRadius;
  double? _cachedGlassRadius;

  @override
  void didUpdateWidget(covariant _TabIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.tabIndex != widget.tabIndex ||
        oldWidget.tabCount != widget.tabCount) {
      _xAlign = _computeXAlignmentForTab(widget.tabIndex);
      _cachedTargetAlignment = null;
    }

    if (oldWidget.barBorderRadius != widget.barBorderRadius) {
      _barShape =
          LiquidRoundedSuperellipse(borderRadius: widget.barBorderRadius);
      _cachedBackgroundRadius = null;
      _cachedGlassRadius = null;
    }

    if (oldWidget.indicatorColor != widget.indicatorColor) {
      _cachedIndicatorColor = null;
    }
  }

  /// Converts a tab index to horizontal alignment (-1 to 1).
  double _computeXAlignmentForTab(int tabIndex) {
    return IndicatorPhysics.computeAlignment(
      tabIndex,
      widget.tabCount,
    );
  }

  /// Converts a global drag position to horizontal alignment (-1 to 1).
  double _getAlignmentFromGlobalPosition(Offset globalPosition) {
    return IndicatorPhysics.alignmentFromPosition(
      globalPosition,
      context,
      widget.tabCount,
    );
  }

  void _onDragDown(DragDownDetails details) {
    setState(() {
      _isDown = true;
      _xAlign = _getAlignmentFromGlobalPosition(details.globalPosition);
    });
  }

  void _onDragUpdate(DragUpdateDetails details) {
    final newAlign = _getAlignmentFromGlobalPosition(details.globalPosition);
    if ((_xAlign - newAlign).abs() > 0.0001) {
      setState(() {
        _isDragging = true;
        _xAlign = newAlign;
      });
    }
  }

  void _onDragEnd(DragEndDetails details) {
    setState(() {
      _isDragging = false;
      _isDown = false;
    });

    final box = context.findRenderObject()! as RenderBox;
    final currentRelativeX = (_xAlign + 1) / 2;
    final tabWidth = 1.0 / widget.tabCount;
    final indicatorWidth = 1.0 / widget.tabCount;
    final draggableRange = 1.0 - indicatorWidth;
    final velocityX =
        (details.velocity.pixelsPerSecond.dx / box.size.width) / draggableRange;

    final targetTabIndex = _computeTargetTab(
      currentRelativeX: currentRelativeX,
      velocityX: velocityX,
      tabWidth: tabWidth,
    );

    _xAlign = _computeXAlignmentForTab(targetTabIndex);

    if (targetTabIndex != widget.tabIndex) {
      widget.onTabChanged(targetTabIndex);
    }
  }

  /// Computes the target tab index based on drag position and velocity.
  int _computeTargetTab({
    required double currentRelativeX,
    required double velocityX,
    required double tabWidth,
  }) {
    return IndicatorPhysics.computeTargetIndex(
      currentRelativeX: currentRelativeX,
      velocityX: velocityX,
      itemWidth: tabWidth,
      itemCount: widget.tabCount,
      velocityThreshold: 100.0,
      projectionTime: 0.15,
    );
  }

  @override
  Widget build(BuildContext context) {
    _cachedIndicatorColor ??= widget.indicatorColor ??
        (CupertinoTheme.of(context)
                .textTheme
                .textStyle
                .color
                ?.withValues(alpha: .1) ??
            _fallbackIndicatorColor);

    _cachedTargetAlignment ??= _computeXAlignmentForTab(widget.tabIndex);
    _cachedBackgroundRadius ??= widget.barBorderRadius * 2;
    _cachedGlassRadius ??= widget.barBorderRadius;

    final indicatorColor = _cachedIndicatorColor!;
    final targetAlignment = _cachedTargetAlignment!;
    final backgroundRadius = _cachedBackgroundRadius!;
    final glassRadius = _cachedGlassRadius!;

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
              ? const Motion.interactiveSpring(
                  snapToEnd: true,
                  duration: Duration(milliseconds: 50),
                )
              : const Motion.bouncySpring(
                  snapToEnd: true,
                  duration: Duration(milliseconds: 250),
                ),
          builder: (context, value, velocity, child) {
            final alignment = Alignment(value, 0);

            return SingleMotionBuilder(
              motion: const Motion.snappySpring(
                snapToEnd: true,
                duration: Duration(milliseconds: 200),
              ),
              value: widget.visible &&
                      (_isDown || (alignment.x - targetAlignment).abs() > 0.30)
                  ? 1.0
                  : 0.0,
              builder: (context, thickness, child) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned.fill(
                      child: RepaintBoundary(
                        child: LiquidGlass.grouped(
                          clipBehavior: Clip.none,
                          shape: _barShape,
                          child: const SizedBox.expand(),
                        ),
                      ),
                    ),
                    if (thickness < 1)
                      LiquidGlassIndicator(
                        velocity: velocity,
                        itemCount: widget.tabCount,
                        alignment: alignment,
                        thickness: thickness,
                        quality: widget.quality,
                        indicatorColor: indicatorColor,
                        isBackgroundIndicator: true,
                        borderRadius: backgroundRadius,
                        padding: const EdgeInsets.all(4),
                        expansion: 14,
                      ),
                    if (thickness > 0)
                      LiquidGlassIndicator(
                        velocity: velocity,
                        itemCount: widget.tabCount,
                        alignment: alignment,
                        thickness: thickness,
                        quality: widget.quality,
                        indicatorColor: indicatorColor,
                        isBackgroundIndicator: false,
                        borderRadius: glassRadius,
                        padding: const EdgeInsets.all(4),
                        expansion: 14,
                        glassSettings: widget.indicatorSettings,
                      ),
                    RepaintBoundary(
                      child: Container(
                        padding: widget.tabPadding,
                        height: widget.barHeight,
                        child: child!,
                      ),
                    ),
                  ],
                );
              },
              child: widget.child,
            );
          },
          child: widget.child,
        ));
  }
}
