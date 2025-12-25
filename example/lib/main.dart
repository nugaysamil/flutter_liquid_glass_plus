import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass/flutter_liquid_glass.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Liquid Glass Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      home: const ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const FavoritesPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black,
              Colors.grey.shade900,
              Colors.black87,
            ],
          ),
        ),
        child: LiquidGlassLayer(
          settings: const LiquidGlassSettings(
            thickness: 30,
            blur: 30,
            refractiveIndex: 1.59,
          ),
          child: Stack(
            children: [
              _pages[_selectedIndex],
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: LiquidGlassBottomBar(
                  tabs: [
                    LiquidGlassBottomBarTab(
                      label: 'Home',
                      icon: CupertinoIcons.house,
                      selectedIcon: CupertinoIcons.house_fill,
                      glowColor: Colors.white70,
                    ),
                    LiquidGlassBottomBarTab(
                      label: 'Search',
                      icon: CupertinoIcons.search,
                      selectedIcon: CupertinoIcons.search,
                      glowColor: Colors.white60,
                    ),
                    LiquidGlassBottomBarTab(
                      label: 'Favorites',
                      icon: CupertinoIcons.heart,
                      selectedIcon: CupertinoIcons.heart_fill,
                      glowColor: Colors.white.withOpacity(0.8),
                    ),
                    LiquidGlassBottomBarTab(
                      label: 'Profile',
                      icon: CupertinoIcons.person,
                      selectedIcon: CupertinoIcons.person_fill,
                      glowColor: Colors.white,
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabSelected: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  extraButton: GlassBottomBarExtraButton(
                    icon: CupertinoIcons.add_circled,
                    label: 'Create',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Create button tapped!'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Welcome Back',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Discover beautiful glass effects',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 40),
            LiquidGlassCard(
              quality: LiquidGlassQuality.premium,
              margin: const EdgeInsets.only(bottom: 20),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.star, color: Colors.white, size: 32),
                  SizedBox(height: 12),
                  Text(
                    'Premium Quality',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Experience the best glass morphism effects with premium rendering quality.',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            LiquidGlassCard(
              quality: LiquidGlassQuality.standard,
              margin: const EdgeInsets.only(bottom: 20),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.speed, color: Colors.white, size: 32),
                  SizedBox(height: 12),
                  Text(
                    'Optimized Performance',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Smooth animations and optimized rendering for better performance.',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            LiquidGlassContainer(
              useOwnLayer: true,
              settings: const LiquidGlassSettings(
                thickness: 20,
                blur: 10,
              ),
              padding: const EdgeInsets.all(20),
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
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Search',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            LiquidGlassTextField(
              placeholder: 'Search for anything...',
              prefixIcon: Icon(
                CupertinoIcons.search,
                size: 20,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 30),
            ...List.generate(
              5,
              (index) => LiquidGlassCard(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: const Icon(
                      CupertinoIcons.music_note,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    'Search Result ${index + 1}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Tap to view details',
                    style: TextStyle(color: Colors.white.withOpacity(0.7)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Favorites',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your saved items',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 30),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return LiquidGlassCard(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        CupertinoIcons.heart_fill,
                        color: Colors.white,
                        size: 40,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Item ${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            LiquidGlassCard(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: const Icon(
                      CupertinoIcons.person_fill,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'john.doe@example.com',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            LiquidGlassCard(
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                leading: const Icon(
                  CupertinoIcons.settings,
                  color: Colors.white,
                ),
                title: const Text(
                  'Settings',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(
                  CupertinoIcons.chevron_right,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
            LiquidGlassCard(
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                leading: const Icon(
                  CupertinoIcons.bell,
                  color: Colors.white,
                ),
                title: const Text(
                  'Notifications',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(
                  CupertinoIcons.chevron_right,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
            LiquidGlassCard(
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                leading: const Icon(
                  CupertinoIcons.info,
                  color: Colors.white,
                ),
                title: const Text(
                  'About',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(
                  CupertinoIcons.chevron_right,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
