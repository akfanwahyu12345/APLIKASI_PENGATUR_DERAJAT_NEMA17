import 'package:flutter/material.dart';
import 'package:aplikasiantena/screens/pengukuran.dart'; // Pastikan ini sesuai dengan lokasi file pengukuran.dart
import 'package:aplikasiantena/screens/teori.dart'; // Pastikan ini sesuai dengan lokasi file teori.dart
import 'package:aplikasiantena/screens/kompas.dart'; // Pastikan ini sesuai dengan lokasi file kompas.dart

class DashboardScreens extends StatelessWidget {
  // Menerima data nama dan id (NIM/NIP)
  final String name;
  final String id;

  // Konstruktor untuk menerima data dari LoginScreens
  const DashboardScreens({super.key, required this.name, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      // Tambahkan Drawer untuk sidebar
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Profil', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            // Tampilkan Nama dan NIM/NIP di Sidebar (Drawer)
            ListTile(
              title: const Text('Nama:'),
              subtitle: Text(name),
            ),
            ListTile(
              title: const Text('NIM/NIP:'),
              subtitle: Text(id),
            ),
            const Divider(),  // Pembatas antara Profil dan menu lainnya
            // Menu lainnya dengan ElevatedButton untuk navigasi
            ListTile(
              title: ElevatedButton(
                onPressed: () {
                  // Menavigasi ke halaman Teori
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const teori()), // Navigasi ke TeoriScreen
                  );
                },
                child: const Text('Teori'),
              ),
            ),
            ListTile(
              title: ElevatedButton(
                onPressed: () {
                  // Menavigasi ke halaman Pengukuran
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PengukuranScreen()), // Navigasi ke PengukuranScreen
                  );
                },
                child: const Text('Pengukuran'),
              ),
            ),
            ListTile(
              title: ElevatedButton(
                onPressed: () {
                  // Menavigasi ke halaman Kompas
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const kompas()), // Perbaiki ke KompasScreen
                  );
                },
                child: const Text('Kompas'),
              ),
            ),
          ],
        ),
      ),
      // Body utama dashboard, bisa diisi dengan konten lain (misal icon, grafik, dll)
      body: Center(
        child: const Text(
          'Konten Dashboard',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
