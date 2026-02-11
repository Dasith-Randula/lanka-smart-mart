import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
    const SplashScreen({super.key});

    @override
    State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
        with SingleTickerProviderStateMixin {
    late AnimationController _animationController;
    late Animation<double> _scaleAnimation;

    @override
    void initState() {
        super.initState();
        _animationController = AnimationController(
            duration: const Duration(milliseconds: 800),
            vsync: this,
        );
        _scaleAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
            CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
        );
        _animationController.repeat(reverse: true);

        Future.delayed(const Duration(milliseconds: 5000)).then((_) {
            if (!mounted) return;
            Navigator.of(context).pushReplacement(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                        const LoginScreen(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                },
                transitionDuration: const Duration(milliseconds: 500),
            ));
        });
    }

    @override
    void dispose() {
        _animationController.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: const Color(0xFF00EC56),
            body: SafeArea(
                child: SizedBox.expand(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                            const SizedBox(height: 20),
                            Expanded(
                                child: Center(
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                            AnimatedBuilder(
                                                animation: _scaleAnimation,
                                                builder: (context, child) {
                                                    return Transform.scale(
                                                        scale: _scaleAnimation.value,
                                                        child: child,
                                                    );
                                                },
                                                child: Container(
                                                    width: 190,
                                                    height: 190,
                                                    decoration: const BoxDecoration(
                                                        color: Color(0xFF19BD4F),
                                                        shape: BoxShape.circle,
                                                    ),
                                                    child: Center(
                                                        child: Image.asset(
                                                            'assets/images/logo.png',
                                                            width: 110,
                                                            height: 110,
                                                        ),
                                                    ),
                                                ),
                                            ),
                                            const SizedBox(height: 40),
                                            Text(
                                                'LANKA SMART',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.workSans(
                                                    color: Colors.white,
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 0.5,
                                                ),
                                            ),
                                            Text(
                                                'MART',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.workSans(
                                                    color: Colors.white,
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 0.5,
                                                ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                                'Freshness Delivered to Your Doorstep',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.workSans(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(bottom: 24),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                        const SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 3.0,
                                            ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                            'Loading',
                                            style: GoogleFonts.workSans(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                            ),
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                            'Powered by LankaSmartMart',
                                            style: GoogleFonts.workSans(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                            ),
                                        ),
                                    ],
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}

