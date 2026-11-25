
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ColorProvider(),
      child: const MyApp(),
    ),
  );
}

// Клас для збереження та зміни кольору
class ColorProvider extends ChangeNotifier {
  int _red = 50;
  int _green = 128;
  int _blue = 230;

  int get red => _red;
  int get green => _green;
  int get blue => _blue;

  void setRed(double value) {
    _red = value.round();
    notifyListeners();
  }

  void setGreen(double value) {
    _green = value.round();
    notifyListeners();
  }

  void setBlue(double value) {
    _blue = value.round();
    notifyListeners();
  }
}

// Головний клас застосунку
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        scaffoldBackgroundColor: const Color(0xFFFAF2FC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFCBB0F5),
          centerTitle: true,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

// Основний екран
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 90),

            ColorPreview(),

            SizedBox(height: 95),

            SliderSection(),
          ],
        ),
      ),
    );
  }
}

// Окремий віджет попереднього перегляду
class ColorPreview extends StatelessWidget {
  const ColorPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ColorProvider>();

    return Center(
      child: Container(
        width: 150,
        height: 150,
        color: Color.fromRGBO(
          provider.red,
          provider.green,
          provider.blue,
          1.0,
        ),
      ),
    );
  }
}

// Окремий віджет із трьома повзунками
class SliderSection extends StatelessWidget {
  const SliderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ColorProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Red: ${provider.red}'),

        Slider(
          value: provider.red.toDouble(),
          min: 0,
          max: 255,
          divisions: 255,
          onChanged: (value) {
            context.read<ColorProvider>().setRed(value);
          },
        ),

        Text('Green: ${provider.green}'),

        Slider(
          value: provider.green.toDouble(),
          min: 0,
          max: 255,
          divisions: 255,
          onChanged: (value) {
            context.read<ColorProvider>().setGreen(value);
          },
        ),

        Text('Blue: ${provider.blue}'),

        Slider(
          value: provider.blue.toDouble(),
          min: 0,
          max: 255,
          divisions: 255,
          onChanged: (value) {
            context.read<ColorProvider>().setBlue(value);
          },
        ),
      ],
    );
  }
}
