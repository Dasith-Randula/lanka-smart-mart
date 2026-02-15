import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/theme_provider.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeProvider>().isDarkMode;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDarkMode
              ? [const Color(0xFF094820), const Color(0xFF030303)]
              : [const Color(0xFFD2E6DA), Colors.white],
        ),
      ),
      child: child,
    );
  }
}