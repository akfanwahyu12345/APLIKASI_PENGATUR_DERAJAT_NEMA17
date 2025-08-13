import 'package:flutter/material.dart';

class teori extends StatelessWidget {
  const teori({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teori"),
      ),
      body: const Center(
        child: Text('Halaman Teori Azimut dan Alavesi'),
      ),
    );
  }
}
