import 'package:flutter/material.dart';
import 'config/theme.dart';
import 'navigation_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Wisata Lokal',
      debugShowCheckedModeBanner: false,
      // Menggunakan konfigurasi tema dari file theme.dart
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Otomatis ikut pengaturan HP (Dark/Light)

      home: const NavigationMenu(),
    );
  }
}
