import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass/components/box/liquid_glass_card.dart';
import 'package:flutter_liquid_glass/components/box/liquid_glass_container.dart';
import 'package:flutter_liquid_glass/enum/liquid_glass_quality.dart';
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
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ExamplePage(),
    );
  }
}

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
         color: Colors.black,
        ),
        child: const SafeArea(
          child: LiquidGlassLayer(
            settings: const LiquidGlassSettings(
              thickness: 30,
              blur: 30,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Liquid Glass Examples',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  
                  // GlassCard Examples
                  const Text(
                    'GlassCard Examples',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Basic GlassCard
                  const GlassCard(
                    quality: LiquidGlassQuality.premium,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: const ListTile(
                      leading: Icon(Icons.star, color: Colors.white),
                      title: Text('Basic Card', style: TextStyle(color: Colors.white)),
                      subtitle: Text('Default styling with 16px padding', style: TextStyle(color: Colors.white70)),
                    ),
                  ),
                
                  
                
                  
                  // GlassCard with custom shape
                 const GlassCard(
                    shape: LiquidRoundedRectangle(borderRadius: 8),
                    margin:  EdgeInsets.only(bottom: 40),
                    child:  ListTile(
                      leading: Icon(Icons.shape_line, color: Colors.white),
                      title: Text('Custom Shape', style: TextStyle(color: Colors.white)),
                      subtitle: Text('Using rounded rectangle instead of superellipse', style: TextStyle(color: Colors.white70)),
                    ),
                  ),
                  
                  // LiquidGlassContainer Examples
                  const Text(
                    'LiquidGlassContainer Examples',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Basic Container
                  LiquidGlassContainer(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Basic Container',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'A basic container with default styling.',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  
                  // Container with fixed size
                  LiquidGlassContainer(
                    width: double.infinity,
                    height: 150,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 16),
                    alignment: Alignment.center,
                    child: const Text(
                      'Fixed Size Container',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  
              
                  
                 
                  
                  // Standalone container (with own layer)
                  LiquidGlassContainer(
                    useOwnLayer: true,
                    settings: const LiquidGlassSettings(
                      thickness: 20,
                      blur: 10,
                    ),
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(bottom: 40),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

