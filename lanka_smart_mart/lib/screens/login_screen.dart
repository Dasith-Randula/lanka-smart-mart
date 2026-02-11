import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF13EC5B),
        elevation: 0,
        centerTitle: true,
        title: const Text('Login'),
      ),
      body: const SafeArea(
        child: Center(
          child: Text(
            'Login Screen',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
