import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass/enum/liquid_glass_quality.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';


/// A beautiful glass morphism app bar following Apple's navigation bar design.
///
/// [LiquidGlassAppBar] provides a blurred glass navigation bar with support for
/// title, leading widget, and trailing actions, matching iOS design patterns.
/// This widget implements [PreferredSizeWidget] for use in [Scaffold.appBar].
class LiquidGlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a glass app bar.
  const LiquidGlassAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.centerTitle = true,
    this.backgroundColor = Colors.transparent,
    this.preferredSize = const Size.fromHeight(44.0),
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
    this.settings,
    this.useOwnLayer = false,
    this.quality = LiquidGlassQuality.premium,
  });


  /// The primary widget displayed in the app bar.
  ///
  /// Typically a [Text] widget containing the page title.
  final Widget? title;

  /// A widget to display before the [title].
  ///
  /// Typically a [GlassButton] with a back arrow or menu icon.
  final Widget? leading;

  /// Widgets to display in a row after the [title].
  ///
  /// Typically [GlassButton] widgets for actions like search, share, etc.
  final List<Widget>? actions;

  /// Whether the [title] should be centered.
  ///
  /// Defaults to true (matching iOS behavior).
  /// Set to false for Android-style left-aligned titles.
  final bool centerTitle;


  /// The background color of the app bar.
  ///
  /// This color is rendered behind the glass effect. Use a semi-transparent
  /// color to allow background content to show through the glass.
  ///
  /// Defaults to [Colors.transparent].
  final Color backgroundColor;

  /// The height of the app bar.
  ///
  /// Defaults to 44.0 (iOS compact navigation bar height).
  /// For large titles, use 96.0 or higher.
  @override
  final Size preferredSize;

  /// Padding around the app bar content.
  ///
  /// Defaults to 8px horizontal padding.
  final EdgeInsetsGeometry padding;


  /// Glass effect settings (only used when [useOwnLayer] is true).
  ///
  /// Controls the visual appearance of the glass effect including thickness,
  /// blur radius, color tint, lighting, and more.
  ///
  /// If null when [useOwnLayer] is true, uses [LiquidGlassSettings] defaults
  /// optimized for navigation bars (high blur, subtle thickness).
  ///
  /// Ignored when [useOwnLayer] is false (inherits from parent layer).
  final LiquidGlassSettings? settings;

  /// Whether to create its own layer or use grouped glass within an existing
  /// layer.
  ///
  /// - `false` (default): Uses [LiquidGlass.grouped], must wrap [Scaffold] in
  /// [LiquidGlassLayer].
  ///   This is more performant when you have multiple glass elements.
  ///
  /// - `true`: Uses [LiquidGlass.withOwnLayer], can be used anywhere.
  ///   Creates an independent glass rendering context for this app bar.
  ///
  /// Defaults to false.
  final bool useOwnLayer;

  /// Rendering quality for the glass effect.
  ///
  /// Defaults to [GlassQuality.premium] since app bars are typically static
  /// surfaces at the top of the screen where premium quality looks best.
  ///
  /// Use [GlassQuality.standard] if the app bar will be used in a scrollable
  /// context.
  final LiquidGlassQuality quality;

  static const _appBarShape = LiquidRoundedRectangle(borderRadius: 0);
  static const _defaultSettings = LiquidGlassSettings(blur: 15);

  @override
  Widget build(BuildContext context) {
    final appBarContent = SafeArea(
      child: Padding(
        padding: padding,
        child: SizedBox(
          height: preferredSize.height,
          child: Row(
            children: [
              if (leading != null) leading!,
              Expanded(
                child: centerTitle
                    ? Center(child: title ?? const SizedBox.shrink())
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: title ?? const SizedBox.shrink(),
                        ),
                      ),
              ),
              if (actions != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8,
                  children: actions!,
                ),
            ],
          ),
        ),
      ),
    );

    final glassWidget = useOwnLayer
        ? LiquidGlass.withOwnLayer(
            shape: _appBarShape,
            settings: settings ?? _defaultSettings,
            fake: quality.usesBackdropFilter,
            child: appBarContent,
          )
        : LiquidGlass.grouped(
            shape: _appBarShape,
            child: appBarContent,
          );

    return ColoredBox(
      color: backgroundColor,
      child: glassWidget,
    );
  }
}
