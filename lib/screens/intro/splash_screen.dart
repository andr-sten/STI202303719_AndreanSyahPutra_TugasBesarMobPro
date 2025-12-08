import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../navigation_menu.dart';
import '../../main.dart'; // tempat navKey

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  final String title = "TRAVEL WISATA LOKAL";

  @override
  void initState() {
    super.initState();

    // Controller utama 4 detik
    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..forward();

    // Listener akhir animasi
    _mainController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 400), () {
          // LOGIC BARU SESUAI PERMINTAAN AYANG ❤️
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => NavigationMenu(key: navKey)),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ======================
            //   LOGO GPS ANIMASI
            // ======================
            AnimatedBuilder(
              animation: _mainController,
              builder: (_, __) {
                return SizedBox(
                  width: 100,
                  height: 100,
                  child: CustomPaint(
                    painter: GPSLogoPainter(
                      progress: Curves.easeInOut.transform(
                        _mainController.value.clamp(0.0, 0.6) / 0.6,
                      ),
                      color: theme.primaryColor,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            // ======================
            //   ANIMASI TEKS PER HURUF
            // ======================
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 2,
              children: List.generate(title.length, (i) {
                if (title[i] == " ") return const SizedBox(width: 12);

                double start = (0.4 + i * 0.03).clamp(0.0, 1.0);
                double end = (start + 0.15).clamp(0.0, 1.0);

                final anim = CurvedAnimation(
                  parent: _mainController,
                  curve: Interval(start, end, curve: Curves.easeOutBack),
                );

                return AnimatedBuilder(
                  animation: anim,
                  builder: (_, __) {
                    final v = anim.value.clamp(0.0, 1.0);
                    final angle = (1 - v) * pi;

                    return Opacity(
                      opacity: v,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(angle),
                        child: Text(
                          title[i],
                          style: TextStyle(
                            fontFamily: 'AppFont',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),

            // ======================
            //   SUBTITLE
            // ======================
            FadeTransition(
              opacity: CurvedAnimation(
                parent: _mainController,
                curve: const Interval(0.6, 0.9, curve: Curves.easeIn),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  "Kelola wisata lokal sekitar dengan mudah",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'AppFont',
                    fontSize: 14,
                    letterSpacing: 0.5,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // ======================
            //   DOT LOADER
            // ======================
            FadeTransition(
              opacity: CurvedAnimation(
                parent: _mainController,
                curve: const Interval(0.8, 1.0),
              ),
              child: const DotLoader(),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================================================
// GPS LOGO (VERSION LEBIH SMOOTH)
// =========================================================

class GPSLogoPainter extends CustomPainter {
  final double progress;
  final Color color;

  GPSLogoPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final path = Path();
    double w = size.width, h = size.height;

    // Lingkaran kepala pin
    path.addArc(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.35),
        width: w * 0.5,
        height: w * 0.5,
      ),
      0.5 * pi,
      2 * pi,
    );

    // Ekor pin
    final tail = Path()
      ..moveTo(w * 0.28, h * 0.45)
      ..quadraticBezierTo(w * 0.5, h * 0.55, w * 0.5, h * 0.9)
      ..quadraticBezierTo(w * 0.5, h * 0.55, w * 0.72, h * 0.45);

    path.addPath(tail, Offset.zero);

    // Titik kecil di tengah
    path.addOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.35),
        width: w * 0.15,
        height: w * 0.15,
      ),
    );

    for (var metric in path.computeMetrics()) {
      final draw = metric.extractPath(0, metric.length * progress);
      canvas.drawPath(draw, paint);
    }
  }

  @override
  bool shouldRepaint(covariant GPSLogoPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

// =========================================================
// DOT LOADER (WAVE SCALE)
// =========================================================

class DotLoader extends StatefulWidget {
  const DotLoader({super.key});

  @override
  State<DotLoader> createState() => _DotLoaderState();
}

class _DotLoaderState extends State<DotLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController c;

  @override
  void initState() {
    super.initState();
    c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) {
        return AnimatedBuilder(
          animation: c,
          builder: (_, __) {
            double wave = sin((c.value * 2 * pi) - (i * 0.8));
            double scale = 0.4 + (0.6 * ((wave + 1) / 2));

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Transform.scale(
                scale: scale.clamp(0.4, 1.0),
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
