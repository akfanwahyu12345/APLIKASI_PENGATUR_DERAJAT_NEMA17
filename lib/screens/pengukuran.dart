import 'package:flutter/material.dart';
import 'package:aplikasiantena/screens/dashboard_screen.dart';  // Pastikan import DashboardScreen

class PengukuranScreen extends StatefulWidget {
  const PengukuranScreen({super.key});

  @override
  State<PengukuranScreen> createState() => _PengukuranScreenState();
}

class _PengukuranScreenState extends State<PengukuranScreen> {
  final TextEditingController _degreeController = TextEditingController();
  List<Map<String, String>> historyList = [];
  String _selectedAngleType = 'Azimut';

  void _addHistory(String degree) {
    final DateTime now = DateTime.now();
    historyList.add({
      'Dosen/Mahasiswa': 'Mahasiswa',
      'Identitas': '1941160005',
      'Datetime': '${now.month}/${now.day}/${now.year} ${now.hour}:${now.minute}:${now.second}',
      'Degree': degree,
      'AngleType': _selectedAngleType,
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengukuran"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian untuk menampilkan gambar atau icon putaran antena
            Center(
              child: Icon(
                Icons.navigation,
                size: 100,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),

            // Pilihan untuk Azimut atau Elevasi
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  value: 'Azimut',
                  groupValue: _selectedAngleType,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedAngleType = value!;
                    });
                  },
                ),
                const Text('Azimut'),
                Radio<String>(
                  value: 'Elevasi',
                  groupValue: _selectedAngleType,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedAngleType = value!;
                    });
                  },
                ),
                const Text('Elevasi'),
              ],
            ),
            const SizedBox(height: 20),

            // Input Field untuk memasukkan degree
            TextField(
              controller: _degreeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Inputkan Degree',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // Tombol untuk menerapkan inputan degree
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_degreeController.text.isNotEmpty) {
                    _addHistory(_degreeController.text);
                    _degreeController.clear();
                    setState(() {});
                  }
                },
                child: const Text('Terapkan'),
              ),
            ),
            const SizedBox(height: 20),

            // Control Buttons (arrows)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {},
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Tabel untuk menampilkan history pengukuran
            const Text(
              'History',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: historyList.length,
                itemBuilder: (context, index) {
                  final history = historyList[index];
                  return Card(
                    child: ListTile(
                      title: Text('Dosen/Mahasiswa: ${history['Dosen/Mahasiswa']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Identitas: ${history['Identitas']}'),
                          Text('Datetime: ${history['Datetime']}'),
                          Text('Degree: ${history['Degree']}°'),
                          Text('${history['AngleType']}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),

            // Bottom Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigasi ke Home (Dashboard)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DashboardScreens(name: 'Nama', id: 'ID')),
                    );
                  },
                  child: const Text('Home'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Hapus semua history
                    setState(() {
                      historyList.clear();
                    });
                  },
                  child: const Text('Delete All'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Ekspor data history
                  },
                  child: const Text('Export'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
