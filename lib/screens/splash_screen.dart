import 'package:aplikasiantena/screens/login_screen.dart';
import 'package:flutter/material.dart';
// ignore: duplicate_import
import 'package:aplikasiantena/screens/login_screen.dart';



class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Menunggu 2 detik setelah tampilan splash screen muncul dan berpindah ke halaman login
    Future.delayed(const Duration(seconds: 2), () {
      // Setelah 2 detik, arahkan ke halaman login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreens()), // Arahkan ke LoginScreen
      );
    });

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Text(
          'SKAR-ELAZ',
          style: const TextStyle(color: Color.fromARGB(255, 24, 99, 203), fontSize: 30),
        ),
      ),
    );
  }
}
