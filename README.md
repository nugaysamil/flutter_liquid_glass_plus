# flutter_liquid_glass

A beautiful Flutter package for creating stunning liquid glass morphism UI effects. Transform your Flutter apps with elegant, modern glassmorphism designs that blur the line between UI and reality.

## ✨ Features

- 🎨 **Beautiful Glass Effects** - Create stunning liquid glass morphism UI components
- 🚀 **High Performance** - Optimized rendering with quality presets
- 🎯 **Flexible Components** - `LiquidGlassCard` and `LiquidGlassContainer` for all your needs
- 🔧 **Customizable** - Fine-tune blur, thickness, and visual properties
- 📱 **Cross-Platform** - Works seamlessly on iOS, Android, Web, and Desktop
- 🎭 **Grouped or Standalone** - Use shared glass layers or independent effects

## 📦 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_liquid_glass: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## 🚀 Quick Start

### Basic Usage

Wrap your app with a `LiquidGlassLayer` to enable glass effects:

```dart
import 'package:flutter_liquid_glass/components/box/liquid_glass_card.dart';
import 'package:flutter_liquid_glass/components/box/liquid_glass_container.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

LiquidGlassLayer(
  settings: const LiquidGlassSettings(
    thickness: 30,
    blur: 30,
  ),
  child: YourAppContent(),
)
```

### Using LiquidGlassCard

Create beautiful glass cards with default styling:

```dart
LiquidGlassCard(
  quality: LiquidGlassQuality.premium,
  margin: const EdgeInsets.only(bottom: 16),
  child: ListTile(
    leading: Icon(Icons.star, color: Colors.white),
    title: Text('Glass Card', style: TextStyle(color: Colors.white)),
    subtitle: Text('Beautiful glass effect', style: TextStyle(color: Colors.white70)),
  ),
)
```

### Using LiquidGlassContainer

Create flexible glass containers with custom dimensions:

```dart
LiquidGlassContainer(
  width: double.infinity,
  height: 150,
  padding: const EdgeInsets.all(16),
  alignment: Alignment.center,
  child: Text(
    'Custom Container',
    style: TextStyle(color: Colors.white),
  ),
)
```

## 🎯 Standalone Container with Custom Layer

One of the most powerful features of `LiquidGlassContainer` is the ability to create **standalone containers** with their own independent glass layer. This is perfect when you want a container to have unique glass effect settings that differ from the parent layer.

### When to Use Standalone Containers

Use `useOwnLayer: true` when you want:
- **Different blur/thickness settings** for specific containers
- **Independent glass effects** that don't inherit from parent
- **Isolated visual styling** for special UI elements
- **Performance optimization** for specific components

### Example: Standalone Container

Here's a complete example showing how to create a standalone container with custom glass settings:

```dart

https://github.com/user-attachments/assets/d63afa64-d3d2-410a-938b-c6c4b885987d

LiquidGlassContainer(
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
      SizedBox(height: 4),
      Text(
        'Uses its own layer with custom settings',
        style: TextStyle(color: Colors.white70),
        textAlign: TextAlign.center,
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
LiquidGlassContainer(
  child: Text('Uses parent glass layer'),
)
```

**Standalone:**
```dart
// Creates its own layer with custom settings
LiquidGlassContainer(
  useOwnLayer: true,
  settings: const LiquidGlassSettings(thickness: 20, blur: 10),
  child: Text('Has its own glass layer'),
)
```

## 🎨 Customization

### Quality Presets

Choose between performance and visual quality:

```dart
// Standard quality - optimized for performance
LiquidGlassCard(
  quality: LiquidGlassQuality.standard,
  child: YourContent(),
)

// Premium quality - maximum visual fidelity
LiquidGlassCard(
  quality: LiquidGlassQuality.premium,
  child: YourContent(),
)
```

### Custom Shapes

Customize the shape of your glass components:

```dart
LiquidGlassCard(
  shape: LiquidRoundedRectangle(borderRadius: 8),
  child: YourContent(),
)
```

## 📚 API Reference

### LiquidGlassContainer

A flexible container widget with configurable glass effects.

**Properties:**
- `child` - Content widget displayed inside the container
- `width` / `height` - Container dimensions
- `padding` - Internal padding
- `margin` - External margin
- `shape` - Container shape (default: rounded superellipse)
- `settings` - Glass effect settings (only used when `useOwnLayer` is true)
- `useOwnLayer` - Whether to create its own layer or use grouped glass
- `quality` - Rendering quality preset
- `alignment` - Child alignment within container

### LiquidGlassCard

A card widget with iOS-style design defaults.

**Properties:**
- `child` - Content widget
- `padding` - Internal padding (default: 16px)
- `margin` - External margin
- `shape` - Card shape (default: rounded superellipse with 12px radius)
- `settings` - Glass effect settings (only used when `useOwnLayer` is true)
- `useOwnLayer` - Whether to create its own layer
- `quality` - Rendering quality preset

## 🎯 Use Cases

- **Modern Dashboards** - Create elegant data visualization interfaces
- **Settings Screens** - Beautiful, organized settings panels
- **Profile Cards** - Eye-catching user profile displays
- **Modal Dialogs** - Premium-feeling dialog boxes
- **Navigation Panels** - Sleek sidebar navigation
- **Onboarding Screens** - Engaging first-impression experiences

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the terms specified in the LICENSE file.

## 🙏 Acknowledgments

Built with [liquid_glass_renderer](https://pub.dev/packages/liquid_glass_renderer) for the core rendering engine.

---

Made with ❤️ for the Flutter community
