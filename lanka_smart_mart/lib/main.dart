import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'models/cart_model.dart';
import 'models/app_settings_model.dart';
import 'models/theme_provider.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartModel()),
        ChangeNotifierProvider(create: (_) => AppSettingsModel()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LankaSmartMart',
        theme: ThemeData(
          primarySwatch: Colors.green,
          useMaterial3: true,
          textTheme: GoogleFonts.workSansTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
