import 'package:flutter/material.dart';
import 'config/theme.dart';
import 'intro/splash_screen.dart'; // Import Splash Screen
import 'navigation_menu.dart'; // Tetap di-import untuk referensi type jika butuh

// 1. DEFINISI GLOBAL KEY (Agar bisa dipanggil dari Splash Screen)
// Ini berguna jika nanti kamu butuh kontrol navigasi dari luar context
final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

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
      themeMode: ThemeMode.system,

      // 2. SET NAVIGATOR KEY (Opsional, tapi praktik bagus jika punya navKey global)
      navigatorKey: navKey,

      // 3. UBAH HOME KE SPLASH SCREEN
      // Aplikasi akan mulai dari intro dulu, baru pindah ke NavigationMenu
      home: const SplashScreen(),
    );
  }
}
