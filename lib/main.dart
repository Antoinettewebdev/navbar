import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  @override
  void initState() {
    super.initState();
    _loadSavedTheme();
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });

    await prefs.setBool('isDarkMode', _themeMode == ThemeMode.dark);
  }

  Future<void> _loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isDarkMode = prefs.getBool("isDarkMode") ?? false;

    setState(() {
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),

      themeMode: _themeMode,

      home: HomePage(
        onThemeToggle: toggleTheme,
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }
}
