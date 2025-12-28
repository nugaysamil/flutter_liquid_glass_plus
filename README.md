# flutter_liquid_glass_plus

A beautiful Flutter package for creating stunning liquid glass morphism UI effects. Transform your Flutter apps with elegant, modern glassmorphism designs that blur the line between UI and reality.

## Features

- **Beautiful Glass Effects** - Create stunning liquid glass morphism UI components
- **High Performance** - Optimized rendering with quality presets
- **Flexible Components** - Comprehensive set of glass widgets for all your needs
- **Customizable** - Fine-tune blur, thickness, and visual properties
- **Cross-Platform** - Works seamlessly on iOS, Android, Web, and Desktop
- **Grouped or Standalone** - Use shared glass layers or independent effects

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_liquid_glass_plus: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Available Widgets

### Buttons & Controls
- `LGSwitch` - iOS-style toggle switch with liquid glass effect
- `LGSlider` - Draggable slider with jelly physics and glass thumb
- `LGButton` - Glass morphism button with customizable styles
- `LGIconButton` - Icon button with glass effect
- `LGChip` - Glass chip widget
- `LGButtonGroup` - Grouped button container
- `LGPanel` - Glass panel container

### Surfaces
- `LGAppBar` - Glass navigation bar for app headers
- `LGBottomBar` - Bottom navigation bar with glass effect and search support
- `LGBottomBarTab` - Tab configuration for bottom bar
- `LGBottomBarExtraButton` - Extra button for bottom bar
- `LGTabBar` - Horizontal tab bar with glass effect
- `LGTab` - Tab configuration for tab bar
- `LGSideBar` - Side navigation bar
- `LGSideBarItem` - Side bar item configuration
- `LGToolBar` - Toolbar with glass effect

### Overlays
- `LGSheet` - Bottom sheet with glass effect and drag indicator
- `LGDialog` - Modal dialog with glass morphism
- `LGDialogAction` - Dialog action button
- `LGMenu` - Context menu with glass effect
- `LGMenuItem` - Menu item configuration

### Entry & Forms
- `LGTextField` - Text input field with glass effect
- `LGTextArea` - Multi-line text area
- `LGFormField` - Form field wrapper with label and error text
- `LGSearchBar` - Search bar with glass styling
- `LGPicker` - Picker widget with glass effect
- `LGPasswordField` - Password input field

### Components
- `LGCard` - Glass card widget with iOS-style defaults
- `LGContainer` - Flexible container with glass effects
- `LGIndicator` - Glass indicator for selections

## Quick Start

### Basic Usage

Wrap your app with a `LiquidGlassLayer` to enable glass effects:

```dart
import 'package:flutter_liquid_glass_plus/flutter_liquid_glass.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

LiquidGlassLayer(
  settings: const LiquidGlassSettings(
    thickness: 30,
    blur: 30,
  ),
  child: YourAppContent(),
)
```

## Example Usage

### LGBottomBar

Create beautiful bottom navigation bars with glass effect. Supports search functionality, tab navigation, and customizable glass settings.

**Important:** Don't forget to use `extendBody: true` when using `LGBottomBar` in your `Scaffold`.

```dart
Scaffold(
  extendBody: true,
  bottomNavigationBar: LGBottomBar(
    tabs: [
      LGBottomBarTab(label: 'Home', icon: Icon(Icons.home)),
      LGBottomBarTab(label: 'Search', icon: Icon(Icons.search)),
      LGBottomBarTab(label: 'Profile', icon: Icon(Icons.person)),
    ],
    selectedIndex: index,
    onTabSelected: (index) {
      setState(() {
        _selectedIndex = index;
      });
    },
    isSearch: true,
    glassSettings: const LiquidGlassSettings(
      thickness: 40,
      blur: 15,
    ),
  ),
)

```

**Use Cases:**
- Main app navigation
- Tab-based interfaces
- Apps with search functionality
- Multi-section applications

### LGAppBar

Use `LGAppBar` for navigation bars at the top of your screens. Perfect for app headers with title, leading actions, and trailing buttons.

**Important:** Don't forget to use `appBar` property when using `LGAppBar` in your `Scaffold`.

```dart
Scaffold(
  appBar: LGAppBar(
    title: Text('Home'),
    leading: IconButton(
      icon: Icon(Icons.menu),
      onPressed: () {},
    ),
    actions: [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {},
      ),
    ],
    useOwnLayer: true,
    settings: const LiquidGlassSettings(
      thickness: 40,
      blur: 20,
    ),
  ),
)
```

**Use Cases:**
- App navigation headers
- Screen titles with action buttons
- Settings screens
- Profile pages

### LGSwitch

iOS-style toggle switch with liquid glass effect. Perfect for settings and preferences.

```dart
LGSwitch(
  value: _isEnabled,
  onChanged: (value) {
    setState(() {
      _isEnabled = value;
    });
  },
)
```

**Use Cases:**
- Settings toggles
- Feature enable/disable switches
- Preference panels
- Configuration screens

### LGSheet

Bottom sheet with glass effect, perfect for menus and action sheets.

```dart
LGSheet.show(
  context: context,
  builder: (context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      ListTile(
        leading: Icon(Icons.home),
        title: Text('Home'),
        onTap: () => Navigator.pop(context),
      ),
      // More items...
    ],
  ),
  settings: const LiquidGlassSettings(
    thickness: 40,
    blur: 20,
  ),
)
```

**Use Cases:**
- Action menus
- Bottom sheets
- Selection dialogs
- Quick actions

## Standalone Container with Custom Layer

One of the most powerful features is the ability to create **standalone containers** with their own independent glass layer. This is perfect when you want a container to have unique glass effect settings that differ from the parent layer.

### When to Use Standalone Containers

Use `useOwnLayer: true` when you want:
- **Different blur/thickness settings** for specific containers
- **Independent glass effects** that don't inherit from parent
- **Isolated visual styling** for special UI elements
- **Performance optimization** for specific components

### Example: Standalone Container

```dart
LGContainer(
  // Enable standalone mode - creates its own glass layer
  useOwnLayer: true,
  
  // Custom glass effect settings (only used when useOwnLayer is true)
  settings: const LiquidGlassSettings(
    thickness: 20,  // Glass thickness
    blur: 10,       // Blur intensity
  ),
  
  // Standard container properties
  padding: const EdgeInsets.all(20),
  margin: const EdgeInsets.only(bottom: 40),
  
  // Your content
  child: const Column(
    children: [
      Icon(Icons.layers, color: Colors.white, size: 32),
      SizedBox(height: 8),
      Text(
        'Standalone Container',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ],
  ),
)
```

### How It Works

- **`useOwnLayer: true`** - Tells the container to create its own independent `LiquidGlass` layer instead of using the grouped glass effect from the parent `LiquidGlassLayer`.

- **`settings`** - When `useOwnLayer` is true, these settings control the glass effect for this specific container:
  - `thickness` - Controls the visual thickness of the glass (higher = more opaque)
  - `blur` - Controls the blur intensity of the background (higher = more blurred)

- **Independent Rendering** - The container renders its glass effect independently, allowing you to have different visual styles within the same app while maintaining optimal performance.

### Comparison: Grouped vs Standalone

**Grouped (default):**
```dart
// Uses parent LiquidGlassLayer settings
LGContainer(
  child: Text('Uses parent glass layer'),
)
```

**Standalone:**
```dart
// Creates its own layer with custom settings
LGContainer(
  useOwnLayer: true,
  settings: const LiquidGlassSettings(thickness: 20, blur: 10),
  child: Text('Has its own glass layer'),
)
```

## Customization

### Quality Presets

Choose between performance and visual quality:

```dart
// Standard quality - optimized for performance
LGCard(
  quality: LGQuality.standard,
  child: YourContent(),
)

// Premium quality - maximum visual fidelity
LGCard(
  quality: LGQuality.premium,
  child: YourContent(),
)
```

### Custom Shapes

Customize the shape of your glass components:

```dart
LGCard(
  shape: LiquidRoundedRectangle(borderRadius: 8),
  child: YourContent(),
)
```

## Use Cases

- **Modern Dashboards** - Create elegant data visualization interfaces
- **Settings Screens** - Beautiful, organized settings panels
- **Profile Cards** - Eye-catching user profile displays
- **Modal Dialogs** - Premium-feeling dialog boxes
- **Navigation Panels** - Sleek sidebar navigation
- **Onboarding Screens** - Engaging first-impression experiences

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the terms specified in the LICENSE file.

## Acknowledgments

Built with [liquid_glass_renderer](https://pub.dev/packages/liquid_glass_renderer) for the core rendering engine.
